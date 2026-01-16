# Op te leveren Artifacts

### Manual Cloud Deployment (Fase 1)

In deze fase tonen de studenten aan dat de architectuur begrepen wordt en functioneert in een cloud-omgeving.

* **Architecture Diagram:** Een gedetailleerd overzicht van de AWS VPC, inclusief subnets, route tables en de security groups voor de EC2 instances en RDS.
* **Connectivity Report:** Logs of screenshots die bewijzen dat de bare-metal API succesvol verbinding maakt met de RDS instance en de containerized services.
* **Service Proof:** Een screenshot van de werkende web-interface via een publiek IP-adres waarbij een foto succesvol is geanonimiseerd.
* **Systemd Inventory:** Een lijst van de handmatig aangemaakte systemd unit files op de API en Frontend instances.

### Automation and Configuration Management

Hier verschuift de bewijslast naar de repository en reproduceerbaarheid.

* **Git Repository:** De volledige broncode van de Ansible playbooks en roles.
* **Provisioning Logs:** Terminal output van een succesvolle `ansible-playbook` run waarbij alle tasks de status "ok" of "changed" hebben op een schone instance.
* **Idempotency Check:** Bewijs dat een tweede run van het playbook resulteert in nul wijzigingen ("changed=0").
* **Inventory File:** Een correct geconfigureerd Ansible inventory bestand waarin de verschillende host groups (api, workers, db) zijn gedefinieerd.

### Identity and Access Management

De focus ligt hier op de integratie tussen de applicatie, Keycloak en externe providers.

* **Keycloak Realm Export:** Een JSON-export van de geconfigureerde realm, inclusief de OIDC client settings.
* **Identity Provider Proof:** Een schermopname van de login-flow waarbij een gebruiker inlogt via een Microsoft account en wordt teruggestuurd naar de PXLCensor interface.
* **Header Validation:** Logs van de API service die aantonen dat de `AUTH_USER_HEADER` correct wordt ontvangen en dat requests zonder geldige header worden geweigerd (401 Unauthorized).

### Infrastructure Scaling and High Availability

Bewijs dat de infrastructuur elastisch is en verkeer veilig afhandelt.

* **ALB Configuration:** Screenshots van de Application Load Balancer met een werkende HTTPS listener en de bijbehorende target groups.
* **ASG Policy Document:** Een beschrijving van de gekozen scaling triggers (bijv. CPU threshold of custom metrics) inclusief de cooldown periodes.
* **Health Check Logs:** Overzicht uit de AWS Console dat aantoont dat instances als "Healthy" worden aangemerkt door de load balancer.

### Deep Observability and Monitoring

Inzichtelijk maken van de systeemgezondheid via externe tooling.

* **Datadog Dashboard:** Een link naar of PDF-export van een live dashboard met daarop infra metrics, log-volumes en applicatie-latency.
* **Structured Logs:** Een screenshot uit de Datadog Log Explorer die aantoont dat applicatie-logs als geparsede JSON velden binnenkomen.
* **APM Traces:** Een screenshot van een trace in Datadog die de flow van een request laat zien van de API naar de Processor.

### Final Stress Test and Validation

De ultieme validatie van de productie-waardigheid.

* **Load Test Report:** Resultaten van een tool zoals Locust of JMeter die de response times en throughput laten zien tijdens een gesimuleerde piekbelasting.
* **Scaling Event History:** Een screenshot van de AWS Auto Scaling history waaruit blijkt dat er daadwerkelijk nieuwe nodes zijn bijgeplaatst tijdens de load test.
* **Self-Healing Proof:** Een video of log-overzicht waarin te zien is dat een handmatig "gekillde" service of een vastgelopen 4K-processing job door het systeem wordt gedetecteerd en hersteld.
