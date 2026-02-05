# Product Backlog: Operation UrbanShield

Dit document bevat de user stories als een gewone backlog. De items zijn geordend per topic en de ID's bevatten geen sprintnummer. Studenten plannen zelf welke items in welke sprint komen.

---

## Topic: Foundation & Access

Kritieke afhankelijkheden:
- US-01 is nodig voor US-02 en US-03.
- US-02 is nodig voor US-03.
- US-04 en US-05 zijn nodig voor een volledige end-to-end demo.

### US-01: Secure Network Architecture (VPC Design) [High]
**User Story**
> **Als** Security Architect,
> **wil ik** een geisoleerde Virtual Private Cloud (VPC) met strikte netwerksegmentatie,
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

### US-02: Managed Database Deployment (RDS) [High]
**User Story**
> **Als** Applicatie Beheerder,
> **wil ik** een beheerde PostgreSQL database die alleen toegankelijk is vanuit ons eigen netwerk,
> **zodat** gebruikersdata (jobs, statussen) persistent worden opgeslagen zonder dat ik zelf database-patches of backups hoef te beheren.

**Context & Beschrijving**
De PXLCensor applicatie heeft een PostgreSQL database nodig. In plaats van zelf Postgres te installeren op een EC2 (wat veel onderhoud vergt), gebruiken we AWS RDS. De uitdaging hier is connectiviteit: de applicatie (die later op EC2 draait) moet bij de database kunnen, maar de database mag absoluut niet publiek toegankelijk zijn.

**Acceptatiecriteria**
- [ ] **RDS Instance:** Een `db.t3.micro` PostgreSQL instance (Free Tier) draait binnen de VPC.
- [ ] **Subnet Group:** De database is geplaatst in de **Private Subnets** (US-01).
- [ ] **Security Group:** Er is een specifieke DB-Security-Group die inkomend verkeer op poort `5432` **alleen** toestaat vanaf de CIDR-range van de Private Subnets (of een specifieke App-Security-Group). `0.0.0.0/0` is strikt verboden.
- [ ] **Schema Initialisatie:** De tabellen van PXLCensor zijn aangemaakt. (Tip: Gebruik een tijdelijke 'Bastion Host' of 'Jumpbox' in het publieke subnet om via een tunnel verbinding te maken en de SQL-scripts te draaien).

---

### US-03: Bare-Metal Application Deployment (EC2) [High]
**User Story**
> **Als** Release Engineer,
> **wil ik** de Node.js API en Python Processor handmatig werkend krijgen op Linux servers,
> **zodat** ik begrijp welke dependencies, environment variabelen en OS-settings nodig zijn voordat ik dit automatiseer.

**Context & Beschrijving**
Voordat we Ansible scripts kunnen schrijven, moeten we weten wat de applicatie nodig heeft. In deze story installeren we de backend services "bare-metal" op EC2 instances. Dit betekent: geen Docker voor de apps zelf. We moeten Node.js, Python, systeem-libraries (voor de image processing) en process managers configureren.

**Acceptatiecriteria**
- [ ] **Compute:** Twee EC2 instances (Amazon Linux 2023 of Ubuntu) draaien in de Private Subnets.
- [ ] **Dependencies:**
    - Instance A (API/Media): Node.js 18+ en PM2 (of vergelijkbaar) geinstalleerd.
    - Instance B (Processor): Python 3.10+, `pip`, en `libgl1` (voor OpenCV) geinstalleerd.
- [ ] **Configuratie:** Environment variabelen (`DATABASE_URL`, `PORT`) zijn ingesteld (bv. via `.env` of `/etc/environment`).
- [ ] **Connectiviteit:**
    - De API kan verbinden met de RDS database.
    - De Processor kan jobs ophalen uit de API/Database.
- [ ] **Security:** De instances zijn alleen benaderbaar via SSH vanaf de Bastion Host (Jumphost).

---

### US-04: Frontend Hosting (Nginx Manual) [Medium]
**User Story**
> **Als** Frontend Engineer,
> **wil ik** de frontend handmatig hosten op een webserver,
> **zodat** de applicatie bereikbaar is voor gebruikers tijdens de eerste demo's.

**Acceptatiecriteria**
- [ ] **Webserver:** Nginx draait op een instance in het public subnet.
- [ ] **Deploy:** De frontend artifacts zijn geplaatst in de webroot en worden correct geserveerd.
- [ ] **Routing:** Requests naar de API worden doorgestuurd naar de backend (reverse proxy).
- [ ] **Bereikbaarheid:** De frontend is bereikbaar via een publiek IP of test-domein.

---

### TECH-01: Git Repository Setup & Access [High]
**Doel**
- [ ] Repository aangemaakt en team heeft toegang.
- [ ] Branch protection of basisworkflow is afgesproken.

---

### US-05: Load Balancer (Manual ALB + SSL) [High]
**User Story**
> **Als** Platform Engineer,
> **wil ik** handmatig een Application Load Balancer met HTTPS configureren,
> **zodat** verkeer veilig verdeeld wordt en we een stabiel demo-endpoint hebben.

**Acceptatiecriteria**
- [ ] **ALB:** Load balancer is actief en gekoppeld aan target groups.
- [ ] **Health Checks:** Health checks zijn geconfigureerd.
- [ ] **HTTPS:** SSL-certificaat is actief (ACM).
- [ ] **Routing:** Frontend en API routes worden correct doorgestuurd.

---

## Topic: Automation & Ops

Kritieke afhankelijkheden:
- US-06 is nodig voor US-07 en US-08.
- US-07/US-08 zijn nodig voor US-10 en US-12.

### US-06: Ansible Inventory & Base Configuration [High]
**User Story**
> **Als** System Administrator,
> **wil ik** een geautomatiseerde basisconfiguratie uitrollen over al mijn servers,
> **zodat** elke server in mijn vloot identiek geconfigureerd is qua tijdzone, updates en toegang, zonder menselijke fouten.

**Context & Beschrijving**
We stappen over van "inloggen en typen" naar "push configuration". De eerste stap is een Ansible Inventory (lijst van servers) en een basis 'Role' die zorgt voor de hygiene van de servers.

**Acceptatiecriteria**
- [ ] **Inventory:** Een `hosts.ini` of `inventory.yml` bestand definieert groepen: `[loadbalancers]`, `[app_servers]`, `[workers]`.
- [ ] **Connectivity:** Ansible kan via SSH (met keys) verbinden met alle EC2 instances (mogelijk via een ProxyCommand/Bastion host config in `ansible.cfg`).
- [ ] **Role `common`:** Een Ansible Role die op *alle* servers:
    - `apt-get update` / `yum update` uitvoert.
    - Essentiele tools installeert (curl, git, htop, net-tools).
    - De tijdzone instelt op `Europe/Brussels`.
- [ ] **Idempotency:** Het playbook kan twee keer achter elkaar draaien zonder fouten en zonder onnodige wijzigingen ("changed=0" bij de tweede run).

---

### US-07: Service Management Automation (Systemd) [High]
**User Story**
> **Als** Site Reliability Engineer (SRE),
> **wil ik** dat de applicatie-services worden beheerd door het OS-init systeem (systemd),
> **zodat** de applicatie automatisch start bij het booten en herstart na een onverwachte crash.

**Context & Beschrijving**
Een professionele Linux applicatie draait niet in een `screen` sessie of via `node index.js &`. We gebruiken `systemd` unit files. Dit stelt ons in staat om logs te beheren (via `journalctl`) en restart policies te definieren.

**Acceptatiecriteria**
- [ ] **Ansible Templates:** Jinja2 templates (`.service.j2`) zijn gemaakt voor:
    - `pxlcensor-api.service`
    - `pxlcensor-media.service`
    - `pxlcensor-processor.service`
- [ ] **Deployment:** Het playbook plaatst deze files in `/etc/systemd/system/`, herlaadt de daemon, en activeert (`enable`) de services.
- [ ] **Environment Injection:** Secrets en configuratie (zoals DB URL) worden veilig in de service geinjecteerd (bijv. via `EnvironmentFile`).
- [ ] **Resilience Test:** Als ik `kill -9 <PID>` doe op het node-proces, start systemd het direct opnieuw op.

---

### US-08: App Deployment Playbooks [High]
**User Story**
> **Als** Release Engineer,
> **wil ik** een geautomatiseerde deployment van de applicaties via Ansible,
> **zodat** nieuwe releases reproduceerbaar en snel uitgerold worden.

**Acceptatiecriteria**
- [ ] **Playbooks:** Deployment playbooks voor API, Media en Processor bestaan.
- [ ] **Artifacts:** Build artifacts of git tags worden expliciet gedeployed.
- [ ] **Rollback:** Er is een eenvoudige rollback procedure (bv. vorige release tag).

---

### US-09: Ansible Vault (Secrets) [Medium]
**User Story**
> **Als** Security Engineer,
> **wil ik** secrets beheren via Ansible Vault,
> **zodat** credentials niet in plain text in de repository staan.

**Acceptatiecriteria**
- [ ] **Vault:** Gevoelige variabelen staan in een versleuteld vault-bestand.
- [ ] **Gebruik:** Playbooks kunnen de vault gebruiken tijdens deploys.
- [ ] **Procedure:** Decrypteren en rotatie zijn gedocumenteerd.

---

## Topic: Platform & Security

Kritieke afhankelijkheden:
- TECH-02 is nodig voor US-05 en US-10 (domein/HTTPS).
- US-11 is nodig voor US-12 (automation).

### TECH-02: Domain Name & DNS (Route53) [Medium]
**Doel**
- [ ] Domeinnaam is geregistreerd of toegewezen.
- [ ] DNS-records verwijzen naar de juiste public endpoint(s).

---

### US-10: Load Balancing Automation (ALB + SSL via Ansible) [High]
**User Story**
> **Als** Platform Engineer,
> **wil ik** de Application Load Balancer en HTTPS-configuratie automatiseren,
> **zodat** de setup reproduceerbaar is en certificaten centraal beheerd zijn.

**Acceptatiecriteria**
- [ ] **ALB:** Load balancer is actief en gekoppeld aan target groups.
- [ ] **Health Checks:** Health checks zijn geconfigureerd.
- [ ] **HTTPS:** SSL-certificaat is actief (ACM).
- [ ] **Routing:** Frontend en API routes worden correct doorgestuurd.

---

### US-11: Keycloak SSO (Manual Setup) [High]
**User Story**
> **Als** Compliance Officer,
> **wil ik** handmatig een Keycloak SSO-flow opzetten,
> **zodat** gebruikers kunnen inloggen via hun Microsoft account zonder aparte credentials.

**Context & Beschrijving**
De applicatie ondersteunt authenticatie via headers. We plaatsen handmatig een Identity Provider (Keycloak) die de login afhandelt via Microsoft OIDC en vervolgens het verkeer doorstuurt naar de backend met de juiste `AUTH_USER_HEADER`.

**Acceptatiecriteria**
- [ ] **Keycloak Setup:** Keycloak draait (mag in Docker op een aparte beheer-instance of via de cloud).
- [ ] **Client Config:** De PXLCensor frontend is geregistreerd als OIDC client.
- [ ] **Token Exchange:** Na inloggen stuurt de frontend het token mee, of een Gateway (zoals Nginx of OAuth2-Proxy) valideert de sessie.
- [ ] **User Scoping:** Een gebruiker ziet in de applicatie alleen ZIJN eigen geuploade foto's (gebaseerd op de unieke ID uit Keycloak).

---

### US-12: Keycloak SSO Automation (Ansible) [Medium]
**User Story**
> **Als** Platform Engineer,
> **wil ik** de Keycloak setup automatiseren,
> **zodat** de configuratie reproduceerbaar is en niet afhankelijk is van manuele stappen.

**Acceptatiecriteria**
- [ ] **Provisioning:** Keycloak wordt via Ansible uitgerold.
- [ ] **Config as Code:** Realm, clients en roles worden automatisch geconfigureerd.
- [ ] **Secrets:** Client secrets worden veilig beheerd (vault/secret manager).
- [ ] **Herhaalbaarheid:** Een nieuwe omgeving kan opgebouwd worden zonder handmatige UI-actie.

---

## Topic: Scale & Observability

Kritieke afhankelijkheden:
- US-13 is nodig voor load tests en scaling-evidence.
- US-14 bouwt voort op US-06/US-07 (agent deployment en telemetry).

### US-13: Elastic Compute Scaling (ASG) [High]
**User Story**
> **Als** Product Owner,
> **wil ik** dat het systeem automatisch extra rekenkracht (Processor nodes) bijschakelt als er veel foto's worden geupload,
> **zodat** we piekdrukte kunnen verwerken zonder te betalen voor servers die 's nachts stilstaan.

**Context & Beschrijving**
De Python image processing is CPU-intensief. Een server kan misschien 1 foto per 2 seconden aan. Als er 1000 foto's binnenkomen, duurt dat te lang. We gebruiken AWS Auto Scaling Groups (ASG) om dynamisch servers toe te voegen en te verwijderen.

**Acceptatiecriteria**
- [ ] **AMI (Amazon Machine Image):** Er is een strategie (bijv. "Golden AMI" of UserData bootstrap) om een nieuwe EC2 instance automatisch te configureren zonder handmatige Ansible run.
- [ ] **Launch Template:** Definieert de instance type (`t3.small` of `c5.large`?), security groups en SSH keys voor nieuwe nodes.
- [ ] **Scaling Policies:**
    - **Scale Out:** Als gemiddeld CPU-gebruik > 60% voor 2 minuten -> Voeg 1 instance toe.
    - **Scale In:** Als gemiddeld CPU-gebruik < 30% voor 5 minuten -> Verwijder 1 instance.
- [ ] **Demonstratie:** Een load test tool genereert CPU load, waarna in de AWS Console te zien is dat een nieuwe instance "Initializing" is.

---

### US-14: Full-Stack Observability (Datadog) [High]
**User Story**
> **Als** DevOps Engineer,
> **wil ik** dashboards met real-time metrics en logs van alle servers,
> **zodat** ik storingen kan diagnosticeren zonder op 10 verschillende servers te hoeven inloggen via SSH.

**Context & Beschrijving**
In een schalende omgeving (ASG) leven servers soms maar kort. Logs die op de schijf staan, ben je kwijt als de server stopt. We moeten logs en metrics streamen naar een extern platform: Datadog.

**Acceptatiecriteria**
- [ ] **Datadog Agent:** Ansible playbook installeert de Datadog agent op elke node.
- [ ] **System Metrics:** Dashboard toont CPU, RAM, Disk I/O van alle actieve nodes.
- [ ] **Log Aggregation:** De applicatie-logs (JSON format) worden door de agent opgepikt en zijn doorzoekbaar in Datadog Log Explorer.
- [ ] **Process Monitoring:** Het dashboard toont of de `node` en `python` processen 'Up' zijn.

---

## Topic: Release & Validation

Kritieke afhankelijkheden:
- TECH-03 vereist US-10/US-13/US-14 voor volledige validatie.

### TECH-03: Final Load Test & Demo Prep [High]
**Doel**
- [ ] Load test uitgevoerd met documentatie van resultaten.
- [ ] Demo scenario is voorbereid en reproduceerbaar.
