# Phase 2: Automation, Scaling & Security

## User Stories

**Automation van de Infrastructure Provisioning met Ansible**
Als DevOps Engineer wil ik Ansible playbooks schrijven om de base OS, dependencies (Node.js, Python, PostgreSQL) en security hardening automatisch te configureren op alle EC2 instances, zodat handmatige fouten worden geëlimineerd.

**Geautomatiseerde Application Deployment en Systemd Management**
Als DevOps Engineer wil ik Ansible gebruiken om de PXLCensor services te deployen en de bijbehorende `systemd` units te beheren, inclusief het configureren van de environment variables voor de gehele stack.

**Implementatie van Keycloak voor Identity Federation**
Als Security Engineer wil ik Keycloak configureren als de centrale Identity Provider, gekoppeld aan Microsoft Office 365 via OIDC/SAML, zodat ambtenaren veilig kunnen inloggen met hun officiële werkmail.

**Realisatie van Department Scoping en Data Segregatie**
Als Developer wil ik de applicatie configureren om de `AUTH_USER_HEADER` vanuit Keycloak correct te verwerken, zodat ambtenaren van verschillende stadsdiensten (zoals Politie of Verkeer) alleen hun eigen data kunnen inzien.

**Configuratie van de Application Load Balancer en HTTPS**
Als Cloud Engineer wil ik een Application Load Balancer (ALB) inrichten met SSL-certificaten, zodat al het inkomende verkeer veilig via HTTPS wordt afgehandeld en verdeeld over de gezonde instances in de target groups.

**Opzetten van Auto Scaling Groups voor Peak Traffic**
Als SRE wil ik Auto Scaling Groups (ASG) configureren die op basis van CPU-utilization of custom metrics (zoals de processing queue depth) automatisch extra workers bijschakelen tijdens rush hour verkeersdrukte.

**Full-Stack Monitoring en Dashboards in Datadog**
Als DevOps Engineer wil ik de Datadog Agent uitrollen via Ansible om APM (Application Performance Monitoring), structured JSON logs en system metrics te verzamelen voor real-time visualisatie in dashboards.

**Validatie van Schaalbaarheid middels Load Testing**
Als QA Engineer wil ik geautomatiseerde load tests uitvoeren om te bewijzen dat het platform automatisch opschaalt onder zware belasting en correct herstelt wanneer de infrastructuur wordt geconfronteerd met 4K "poison pill" images.

**Implementatie van Self-Healing Mechanismen**
Als SRE wil ik de monitoring in Datadog koppelen aan herstelacties via Ansible of systemd, zodat "frozen" workers automatisch gedetecteerd en herstart worden zonder menselijke tussenkomst.
