# Phase 1: Manual Cloud Deployment

## User Stories

**Inrichten van de Cloud Netwerk Infrastructuur**
Als Cloud Engineer wil ik handmatig een VPC met bijbehorende Subnets, Internet Gateway en Route Tables inrichten, zodat er een geïsoleerde omgeving is voor de PXLCensor infrastructuur.

**Configureren van Security Groups en Netwerkbeveiliging**
Als Cloud Engineer wil ik specifieke Security Groups configureren voor de verschillende lagen (Frontend/API, DB, Media), zodat alleen noodzakelijk verkeer tussen de instances wordt toegestaan.

**Installeren en Configureren van de PostgreSQL Database**
Als Cloud Engineer wil ik handmatig een PostgreSQL instance provisionen en de database schema's laden, zodat de API en de Processor jobs kunnen opslaan en de queue kunnen beheren.

**Handmatige Deployment van de API en Frontend op EC2**
Als Cloud Engineer wil ik Node.js handmatig installeren op een Linux EC2 instance en de API en Frontend services configureren zonder Docker, zodat de web-interface en orchestrator beschikbaar zijn.

**Opzetten van de Processor en Media Services via Docker Run**
Als Cloud Engineer wil ik de Processor en de Media service handmatig starten op een EC2 instance middels `docker run` commando's, zodat de image processing logica en file storage actief zijn zonder gebruik van Docker Compose.

**Beheren van Service Persistence met Systemd**
Als Cloud Engineer wil ik voor de bare metal services `systemd` unit files schrijven en activeren, zodat deze automatisch herstarten na een crash of een reboot van de server.

**Inrichten van Cross-Service Connectivity en Environment Variables**
Als Cloud Engineer wil ik de environment variables handmatig configureren op alle instances, zodat de verschillende componenten elkaar kunnen vinden via hun private IP-adressen.

**Uitvoeren van de Functionele Acceptatie Test**
Als Product Owner wil ik via een publiek endpoint een foto kunnen uploaden en een geanonimiseerd resultaat kunnen downloaden, om te bevestigen dat de handmatige cloud-migratie succesvol is afgerond.
