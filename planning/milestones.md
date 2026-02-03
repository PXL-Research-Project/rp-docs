# Project Milestones

### Milestone: Automatisering van de Core Infrastructure

In deze fase stoppen de studenten met het handmatig typen van commando's op servers.

* **Ansible Base Playbooks:** Ontwikkelen van playbooks die een "vanilla" EC2 instance omtoveren tot een functionele node (Node.js/Python installatie).
* **Systemd Integratie:** Het migreren van handmatige processen naar beheerde services die automatisch herstarten bij falen.
* **Configuration Management:** Alle environment variables en secrets (zoals database credentials) worden centraal beheerd via Ansible in plaats van handmatige `.env` bestanden.

### Milestone: Identity Hardening en Privacy Compliance

Hier wordt de stap gezet naar de beveiligingseisen van de stad Berlijn.

* **Keycloak Deployment:** Het opzetten van een Keycloak server (mag als een van de twee toegestane containers).
* **Microsoft SSO:** Koppelen van de login flow aan de officiële Microsoft identity provider.
* **Header-based Auth:** De API moet de `x-auth-request-email` (of vergelijkbaar) header gaan afdwingen en de data filteren op basis van de afdeling van de gebruiker.

### Milestone: Elasticity en High Availability

Het systeem moet nu "meeademen" met de drukte in de stad.

* **Application Load Balancer (ALB):** Het inrichten van een entry point dat verkeer verdeelt en SSL-certificaten afhandelt voor HTTPS.
* **Target Groups & Health Checks:** Het definiëren van criteria wanneer een instance als "healthy" wordt beschouwd.
* **Auto Scaling Policy:** Het configureren van regels (zoals: "start een nieuwe instance als de CPU boven de 70% komt") om rush hour op te vangen.

### Milestone: Full Stack Observability met Datadog

Inzicht krijgen in wat er onder de motorkap gebeurt tijdens belasting.

* **Agent Deployment:** De Datadog agent moet via Ansible op alle nodes worden uitgerold.
* **Log Collection:** Het configureren van de applicatie om logs in JSON-formaat naar Datadog te streamen.
* **Custom Dashboarding:** Het bouwen van een visueel overzicht dat de correlatie toont tussen inkomende foto's en de systeembelasting.

### Milestone: De Ultieme Stress Test en Oplevering

De finale validatie van het opgeleverde werk.

* **Load Test Executie:** Het uitvoeren van een gesimuleerde "rush hour" om te zien of de ASG daadwerkelijk nieuwe instances spint.
* **Poison Pill Recovery:** Testen of het systeem herstelt als er opzettelijk een corrupt of extreem groot 4K bestand wordt geüpload.

---

### Vergelijkingstabel: Van Fase 1 naar Fase 2

| Feature | Fase 1 (PoC State) | Fase 2 (Production State) |
| --- | --- | --- |
| **Deployment** | Handmatig (SSH + Bash) | **Ansible Playbooks** |
| **Security** | Publieke IP's & HTTP | **ALB, Private Subnets & HTTPS** |
| **Identity** | Geen (Open toegang) | **Keycloak Microsoft SSO** |
| **Scalability** | Single Instance (Fixed) | **Auto Scaling Group (Elastic)** |
| **Monitoring** | Geen / AWS Console | **Datadog Dashboards & Alerts** |
| **Recovery** | Handmatige herstart | **Self-healing via systemd/ASG** |
