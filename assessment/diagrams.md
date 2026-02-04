# Verplichte Diagrammen - Cloud Web Application Project

Dit document beschrijft de **verplichte diagrammen**, hun doel, inhoud en de bijhorende beoordelingscriteria voor het cloud deployment project. De diagrammen zijn zo gekozen dat overlap wordt vermeden en elk diagram een duidelijk afgebakend abstractieniveau heeft.

De volgende drie diagrammen zijn verplicht:

- System Context Diagram (C4 Level 1)
- Container Diagram (C4 Level 2)
- Deployment Diagram

Extra diagrammen mogen toegevoegd worden, maar worden niet meegerekend in de basisbeoordeling.

---

## Overzicht Abstractieniveaus

| Diagram | Focus |
|---------|-------|
|System Context | Externe omgeving en scope|
|Container | Interne softwarestructuur|
|Infrastructure | Cloud deployment en networking|

Deze scheiding moet duidelijk zichtbaar zijn in de aangeleverde diagrammen.

---

## System Context Diagram (C4 Level 1)

### Beschrijving

Dit diagram geeft een hoog niveau overzicht van het volledige systeem en zijn omgeving. De webapplicatie wordt weergegeven als één enkel logisch systeem zonder interne technische details.

### Doel

- Begrip creëren bij niet-technische stakeholders
- Scope en systeemgrenzen afbakenen
- Externe afhankelijkheden zichtbaar maken

### Moet tonen

- Gebruikers (bijvoorbeeld studenten, admins, klanten)
- Externe systemen en services
- De webapplicatie als één logisch blok
- Relaties tussen actoren en het systeem

### Voorbeeldrelaties

- Student -> Browser -> Web Application  
- Web Application -> Payment API  
- Web Application -> Email Service  

### Checklist

**Vereist:**

- Gebruikers correct geïdentificeerd
- Webapplicatie als één enkel systeem weergegeven
- Externe services correct benoemd
- Relaties visueel weergegeven

**Verboden:**

- Geen interne softwarecomponenten
- Geen AWS infrastructuur
- Geen subnetten, servers of databases

**Controlepunten:**

- Is de scope van het systeem duidelijk?
- Zijn alle externe afhankelijkheden zichtbaar?
- Is het diagram begrijpelijk voor niet-technische lezers?

---

## Container Diagram (C4 Level 2)

### Beschrijving

Dit diagram toont de belangrijkste softwarecomponenten (of "containers", dit is niet hetzelfde als linux containers) binnen het systeem en hoe deze met elkaar communiceren.

### Doel

- Software architectuur verduidelijken
- Technologiekeuzes expliciet maken
- Interfaces en communicatiepaden tonen

### Moet minimaal bevatten (voor webapplicaties)

- Frontend applicatie (bijvoorbeeld React, Vue, Angular)
- Backend API
- Database
- Reverse proxy of load balancer

### Voorbeeldarchitectuur

- Browser -> Load Balancer -> Backend API -> Database  
- Backend API -> Object Storage (uploads)

### Checklist

**Vereist:**

- Frontend component
- Backend API component
- Database component
- Load balancer of reverse proxy indien gebruikt
- Communicatierelaties tussen componenten

**Aanbevolen:**

- Technologie stack vermelden
- Protocols aanduiden (HTTP, REST, SQL)

**Verboden:**

- Geen subnetten
- Geen security groups
- Geen VPC-structuren

**Controlepunten:**

- Is de interne architectuur logisch opgebouwd?
- Zijn verantwoordelijkheden per component duidelijk?
- Zijn communicatiepaden correct?

---

## Deployment Diagram

### Beschrijving

Dit diagram beschrijft hoe de applicatie wordt uitgerold op de cloud infrastructuur. De focus ligt op netwerkstructuur, security en resource placement.

### Doel

- Inzicht geven in cloud architectuur
- Security en netwerkontwerp verifiëren
- Deploymentstructuur documenteren

### Moet minimaal bevatten

- VPC  
- Public subnet(s)  
- Private subnet(s)  
- Availability Zones  
- EC2 instances of compute resources  
- RDS of database resource  
- Security groups  
- Route tables  
- Internet Gateway en/of NAT Gateway  

### Best practice vereisten

- Duidelijke netwerkgrenzen (VPC en subnetten)
- Subnetten expliciet labelen als public of private
- Netwerkverkeer en poorten aanduiden (HTTP, HTTPS, database)
- High availability tonen indien toegepast

### Checklist

**Vereist:**

- Correcte VPC-structuur
- Public en private subnetten aanwezig
- Availability Zones weergegeven
- Compute en database resources correct geplaatst
- Security groups gekoppeld aan juiste resources
- Routingcomponenten correct weergegeven

**Netwerkvereisten:**

- Publiek verkeer alleen via public subnet
- Database niet publiek toegankelijk
- NAT Gateway gebruikt voor outbound verkeer vanuit private subnetten indien nodig

**Security vereisten:**

- Inkomend verkeer beperkt tot noodzakelijke poorten
- Database enkel bereikbaar vanuit backend subnet
- Security group regels consistent met architectuur

**Controlepunten:**

- Is het netwerkontwerp logisch en veilig?
- Is high availability correct toegepast indien vermeld?
- Komt de infrastructuur overeen met het Container Diagram?

---

## Algemene Richtlijnen

- Diagrammen moeten zelfstandig leesbaar zijn
- Alle componenten moeten duidelijk gelabeld zijn
- Consistente naamgeving over alle diagrammen
- Relaties en datastromen expliciet weergeven
- Geen decoratieve elementen zonder functioneel nut
- Technische correctheid primeert boven visuele complexiteit

---

## Beoordelingsfocus

De evaluatie zal zich richten op:

- Architecturale correctheid
- Cloud networking inzicht
- Security awareness
- Consistentie tussen diagrammen
- Professionele presentatie en documentatiekwaliteit
