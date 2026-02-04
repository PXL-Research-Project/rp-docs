# Product Backlog: Operation UrbanShield

Dit document bevat de gedetailleerde specificaties voor de user stories. Elke story volgt het standaard agile format maar bevat extra context en technische randvoorwaarden specifiek voor de PXLCensor infrastructuur migratie.

---

## Sprint 1: Manual Cloud Foundation (The "Click-Ops" Phase)
*Doel: Inzicht krijgen in de AWS componenten door ze eerst handmatig te configureren voordat we automatiseren.*

### US-101: Secure Network Architecture (VPC Design)
**User Story**
> **Als** Security Architect,
> **wil ik** een geïsoleerde Virtual Private Cloud (VPC) met strikte netwerksegmentatie,
> **zodat** backend-systemen en databases onbereikbaar zijn voor directe aanvallen vanaf het internet, terwijl de frontend wel bereikbaar blijft.

**Context & Beschrijving**
We kunnen de 'Default VPC' van AWS niet gebruiken omdat deze niet voldoet aan de veiligheidseisen van de stad Berlijn. We moeten een netwerk bouwen dat "Secure by Design" is. Dit betekent dat we onderscheid maken tussen publieke zones (DMZ) en private zones. Servers in de private zone (zoals de Database en de API) mogen **nooit** een publiek IP-adres hebben, maar moeten wel updates kunnen downloaden.

**Acceptatiecriteria**
- [ ] **VPC Configuratie:** Een nieuwe VPC is aangemaakt met CIDR `10.0.0.0/16` in regio `eu-west-1`.
- [ ] **Subnet Strategie:**
    - 2x Public Subnets (in AZ-1a en AZ-1b) voor load balancers/bastions.
    - 2x Private Subnets (in AZ-1a en AZ-1b) voor applicaties en databases.
- [ ] **Routing (Public):** Een Internet Gateway (IGW) is gekoppeld en geconfigureerd in de route table van de public subnets.
- [ ] **Routing (Private):** Een **NAT Gateway** is ingericht in een public subnet, en de route table van de private subnets verwijst hiernaar voor uitgaand verkeer (zodat `apt-get` of `yum` werkt).
- [ ] **Validatie:** Een test-EC2 in het private subnet kan `google.com` pingen, maar is **niet** bereikbaar via SSH vanaf het internet.

---

### US-102: Managed Database Deployment (RDS)
**User Story**
> **Als** Applicatie Beheerder,
> **wil ik** een beheerde PostgreSQL database die alleen toegankelijk is vanuit ons eigen netwerk,
> **zodat** gebruikersdata (jobs, statussen) persistent worden opgeslagen zonder dat ik zelf database-patches of backups hoef te beheren.

**Context & Beschrijving**
De PXLCensor applicatie heeft een PostgreSQL database nodig. In plaats van zelf Postgres te installeren op een EC2 (wat veel onderhoud vergt), gebruiken we AWS RDS. De uitdaging hier is connectiviteit: de applicatie (die later op EC2 draait) moet bij de database kunnen, maar de database mag absoluut niet publiek toegankelijk zijn.

**Acceptatiecriteria**
- [ ] **RDS Instance:** Een `db.t3.micro` PostgreSQL instance (Free Tier) draait binnen de VPC.
- [ ] **Subnet Group:** De database is geplaatst in de **Private Subnets** (US-101).
- [ ] **Security Group:** Er is een specifieke DB-Security-Group die inkomend verkeer op poort `5432` **alleen** toestaat vanaf de CIDR-range van de Private Subnets (of een specifieke App-Security-Group). `0.0.0.0/0` is strikt verboden.
- [ ] **Schema Initialisatie:** De tabellen van PXLCensor zijn aangemaakt. (Tip: Gebruik een tijdelijke 'Bastion Host' of 'Jumpbox' in het publieke subnet om via een tunnel verbinding te maken en de SQL-scripts te draaien).

---

### US-103: Bare-Metal Application Deployment (EC2)
**User Story**
> **Als** Release Engineer,
> **wil ik** de Node.js API en Python Processor handmatig werkend krijgen op Linux servers,
> **zodat** ik begrijp welke dependencies, environment variabelen en OS-settings nodig zijn voordat ik dit automatiseer.

**Context & Beschrijving**
Voordat we Ansible scripts kunnen schrijven, moeten we weten wat de applicatie nodig heeft. In deze story installeren we de backend services "bare-metal" op EC2 instances. Dit betekent: geen Docker voor de apps zelf. We moeten Node.js, Python, systeem-libraries (voor de image processing) en process managers configureren.

**Acceptatiecriteria**
- [ ] **Compute:** Twee EC2 instances (Amazon Linux 2023 of Ubuntu) draaien in de Private Subnets.
- [ ] **Dependencies:**
    - Instance A (API/Media): Node.js 18+ en PM2 (of vergelijkbaar) geïnstalleerd.
    - Instance B (Processor): Python 3.10+, `pip`, en `libgl1` (voor OpenCV) geïnstalleerd.
- [ ] **Configuratie:** Environment variabelen (`DATABASE_URL`, `PORT`) zijn ingesteld (bv. via `.env` of `/etc/environment`).
- [ ] **Connectiviteit:**
    - De API kan verbinden met de RDS database.
    - De Processor kan jobs ophalen uit de API/Database.
- [ ] **Security:** De instances zijn alleen benaderbaar via SSH vanaf de Bastion Host (Jumphost).

---

## Sprint 2: Infrastructure as Code (Automation Phase)
*Doel: Reproduceerbaarheid en snelheid. Handmatige stappen uit Sprint 1 worden Ansible Playbooks.*

### US-201: Ansible Inventory & Base Configuration
**User Story**
> **Als** System Administrator,
> **wil ik** een geautomatiseerde basisconfiguratie uitrollen over al mijn servers,
> **zodat** elke server in mijn vloot identiek geconfigureerd is qua tijdzone, updates en toegang, zonder menselijke fouten.

**Context & Beschrijving**
We stappen over van "inloggen en typen" naar "push configuration". De eerste stap is een Ansible Inventory (lijst van servers) en een basis 'Role' die zorgt voor de hygiëne van de servers.

**Acceptatiecriteria**
- [ ] **Inventory:** Een `hosts.ini` of `inventory.yml` bestand definieert groepen: `[loadbalancers]`, `[app_servers]`, `[workers]`.
- [ ] **Connectivity:** Ansible kan via SSH (met keys) verbinden met alle EC2 instances (mogelijk via een ProxyCommand/Bastion host config in `ansible.cfg`).
- [ ] **Role `common`:** Een Ansible Role die op *alle* servers:
    - `apt-get update` / `yum update` uitvoert.
    - Essentiële tools installeert (curl, git, htop, net-tools).
    - De tijdzone instelt op `Europe/Brussels`.
- [ ] **Idempotency:** Het playbook kan twee keer achter elkaar draaien zonder fouten en zonder onnodige wijzigingen ("changed=0" bij de tweede run).

---

### US-202: Service Management Automation (Systemd)
**User Story**
> **Als** Site Reliability Engineer (SRE),
> **wil ik** dat de applicatie-services worden beheerd door het OS-init systeem (systemd),
> **zodat** de applicatie automatisch start bij het booten en herstart na een onverwachte crash.

**Context & Beschrijving**
Een professionele Linux applicatie draait niet in een `screen` sessie of via `node index.js &`. We gebruiken `systemd` unit files. Dit stelt ons in staat om logs te beheren (via `journalctl`) en restart policies te definiëren.

**Acceptatiecriteria**
- [ ] **Ansible Templates:** Jinja2 templates (`.service.j2`) zijn gemaakt voor:
    - `pxlcensor-api.service`
    - `pxlcensor-media.service`
    - `pxlcensor-processor.service`
- [ ] **Deployment:** Het playbook plaatst deze files in `/etc/systemd/system/`, herlaadt de daemon, en activeert (`enable`) de services.
- [ ] **Environment Injection:** Secrets en configuratie (zoals DB URL) worden veilig in de service geïnjecteerd (bijv. via `EnvironmentFile`).
- [ ] **Resilience Test:** Als ik `kill -9 <PID>` doe op het node-proces, start systemd het direct opnieuw op.

---

## Sprint 3: Scale & Observability (Production Phase)
*Doel: Het systeem klaarmaken voor zware belasting en monitoring.*

### US-301: Elastic Compute Scaling (ASG)
**User Story**
> **Als** Product Owner,
> **wil ik** dat het systeem automatisch extra rekenkracht (Processor nodes) bijschakelt als er veel foto's worden geüpload,
> **zodat** we piekdrukte kunnen verwerken zonder te betalen voor servers die 's nachts stilstaan.

**Context & Beschrijving**
De Python image processing is CPU-intensief. Eén server kan misschien 1 foto per 2 seconden aan. Als er 1000 foto's binnenkomen, duurt dat te lang. We gebruiken AWS Auto Scaling Groups (ASG) om dynamisch servers toe te voegen en te verwijderen.

**Acceptatiecriteria**
- [ ] **AMI (Amazon Machine Image):** Er is een strategie (bijv. "Golden AMI" of UserData bootstrap) om een nieuwe EC2 instance automatisch te configureren zonder handmatige Ansible run.
- [ ] **Launch Template:** Definieert de instance type (`t3.small` of `c5.large`?), security groups en SSH keys voor nieuwe nodes.
- [ ] **Scaling Policies:**
    - **Scale Out:** Als gemiddeld CPU-gebruik > 60% voor 2 minuten -> Voeg 1 instance toe.
    - **Scale In:** Als gemiddeld CPU-gebruik < 30% voor 5 minuten -> Verwijder 1 instance.
- [ ] **Demonstratie:** Een load test tool genereert CPU load, waarna in de AWS Console te zien is dat een nieuwe instance "Initializing" is.

---

### US-302: Secure Identity Integration (Keycloak SSO)
**User Story**
> **Als** Compliance Officer,
> **wil ik** dat gebruikers inloggen via hun bestaande Microsoft account en niet via een losse gebruikersnaam/wachtwoord,
> **zodat** we centraal toegangsbeheer hebben en voldoen aan het security beleid van de stad.

**Context & Beschrijving**
De applicatie ondersteunt authenticatie via headers. We moeten een Identity Provider (Keycloak) plaatsen die de login afhandelt (via OIDC met Microsoft/Google of een interne user database) en vervolgens het verkeer doorstuurt naar de backend met de juiste `AUTH_USER_HEADER`.

**Acceptatiecriteria**
- [ ] **Keycloak Setup:** Keycloak draait (mag in Docker op een aparte beheer-instance of via de cloud).
- [ ] **Client Config:** De PXLCensor frontend is geregistreerd als OIDC client.
- [ ] **Token Exchange:** Na inloggen stuurt de frontend het token mee, of een Gateway (zoals Nginx of OAuth2-Proxy) valideert de sessie.
- [ ] **User Scoping:** Een gebruiker ziet in de applicatie alleen ZIJN eigen geüploade foto's (gebaseerd op de unieke ID uit Keycloak).

---

### US-303: Full-Stack Observability (Datadog)
**User Story**
> **Als** DevOps Engineer,
> **wil ik** dashboards met real-time metrics en logs van alle servers,
> **zodat** ik storingen kan diagnosticeren zonder op 10 verschillende servers te hoeven inloggen via SSH.

**Context & Beschrijving**
In een schalende omgeving (ASG) leven servers soms maar kort. Logs die op de schijf staan, ben je kwijt als de server stopt. We moeten logs en metrics streamen naar een extern platform: Datadog.

**Acceptatiecriteria**
- [ ] **Datadog Agent:** Ansible role installeert de Datadog agent op elke node.
- [ ] **System Metrics:** Dashboard toont CPU, RAM, Disk I/O van alle actieve nodes.
- [ ] **Log Aggregation:** De applicatie-logs (JSON format) worden door de agent opgepikt en zijn doorzoekbaar in Datadog Log Explorer.
- [ ] **Process Monitoring:** Het dashboard toont of de `node` en `python` processen 'Up' zijn.