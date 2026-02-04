# Operation UrbanShield: Smart City Privacy

*UrbanEye AI*, een computer vision startup, is onlangs overgenomen door de stad Berlijn. De stad rolt duizenden high-resolution camera's uit om de traffic flow en emergency response te optimaliseren onder het "Smart City" initiatief.

Berlijn werkt onder een "Privacy First" legal mandate. Het is strikt verboden voor de stad om identificeerbare gezichten, vastgelegd door public sensors, op te slaan of te bekijken. UrbanEye heeft **PXLCensor** ontwikkeld om dit op te lossen - een service die gezichten detecteert en pixelate.

Hoewel het "lab prototype" werkt in Docker, hanteert de City IT Department een **strict No-container policy** voor production cloud instances om de security attack surface te minimaliseren. Jouw taak is om dit containerized prototype te transformeren naar een hardened, high-scale cloud platform met behulp van automation.

---

## Mission

Als de Cloud Engineering Task Force moet je PXLCensor migreren naar een resilient cloud environment die voldoet aan de standaarden van de stad voor security, scalability en monitoring.

### Bare-Metal Infrastructure & Ansible

Aangezien Docker verboden is op de production servers, moet je de "bare metal" deployment automatiseren.

* **AWS Setup:** Architect het netwerk (VPC, Subnets, Security Groups) en de high-availability components (Load Balancer, Auto Scaling Groups) via de AWS Console.
* **Ansible Orchestration:** Schrijf playbooks om cloud instances vanaf nul te provisionen - installeer Node.js, Python en PostgreSQL, en beheer de services via `systemd`.

### Scaling

Om te garanderen dat het privacy mandate van de stad in real-time wordt nageleefd, moet het systeem grote fluctuaties in traffic volume kunnen opvangen.

* **Elastic Capacity:** Je moet autoscaling configureren die reageert op de actuele workload. Als de image processing queue tijdens rush hour boven een specifieke threshold uitkomt, moeten nieuwe cloud instances automatisch geprovisioned en geconfigureerd worden.
* **Worker Optimization:** De Python-gebaseerde face detection is CPU-intensive. Je moet het optimale instance type en de juiste scaling triggers (bijv. CPU utilization vs. custom metrics) bepalen om kosten te balanceren met de eis van de stad voor low-latency processing.
* **Reliability:** Scaling gaat niet alleen over groei; het gaat over gezond blijven. Je moet Target Tracking en Health Checks implementeren om te garanderen dat als een single node faalt, een load balancer het verkeer onmiddellijk naar healthy instances routeert.

### Departmental Portal & Identity

De stad vereist een gecentraliseerde **Login Portal** voor verschillende afdelingen (Traffic Control, Police, Urban Planning).

* **Identity Federation:** De portal moet ambtenaren in staat stellen in te loggen met hun officiële **Microsoft emails**.
* **Department Scoping:** Gebruik de `AUTH_USER_HEADER` om te garanderen dat een Traffic Controller alleen traffic footage ziet en geen toegang heeft tot data van andere afdelingen.

### Deep Observability & Performance

De stad moet precies weten hoe het systeem zich gedraagt onder druk.

* **Monitoring Stack:** Track en analyseer key metrics (bijv. met Prometheus en Grafana).
* **Load Testing:** Je moet bewijzen dat het systeem een "Rush Hour" spike aankan. Je bent verplicht om load tests uit te voeren om je **auto scaling** policies te triggeren en te valideren.

---

## Agile Team Roles

Je werkt als een Agile Squad in Sprints.

* **Product Owner (PO):** Een hooggeplaatste functionaris van de Metropolis Department of Innovation. Zij focussen op **SLAs** (Service Level Agreements).

---

## Technical Constraints

| Component | Requirement |
| --- | --- |
| **Cloud** | TBD |
| **Automation** | **Ansible** (Strikt geen Docker op cloud instances) |
| **Identity** | SSO Portal met Microsoft OIDC/SAML integration |
| **Database** | Managed PostgreSQL (RDS) |
| **Observability** | TBD |
