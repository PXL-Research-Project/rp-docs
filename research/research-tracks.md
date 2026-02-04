# Research Tracks — Approved Topics & Custom Proposals

Elke projectgroep kiest één research track. Deze bepaalt de focus van het applied research component en de bijhorende Proof of Concept (PoC).

Het onderzoek moet aantoonbaar geïntegreerd zijn in de projectinfrastructuur.

Elke research track moet het PXL onderzoeksproces volgen:

- Ontwerpen (Sprint 1)
- Gegevens verzamelen (Sprint 2)
- Uitvoering en analyse (Sprint 3)
- Evaluatie en conclusie (Final delivery)

Tracks die deze flow niet respecteren worden niet aanvaard.

---

## Track Selectie Model

Er zijn twee opties:

1. Kies een track uit de **Approved Topics List**  
2. Dien een **Custom Research Proposal** in (onder voorwaarden)

---

# Approved Research Tracks

Deze tracks zijn vooraf goedgekeurd en afgestemd op de projectarchitectuur.

---

## Track A — Autoscaling & Processing Performance

### Doel

Onderzoeken hoe observability tooling kan worden ingezet om autoscaling gedrag van CPU-intensieve workloads te optimaliseren.

---

### Hoofdonderzoeksvraag

Hoe kan observability tooling (zoals Datadog) worden gebruikt om autoscaling gedrag van processing workloads in AWS te optimaliseren?

---

### Mogelijke Subvragen

Teams selecteren minimaal 2:

- Welke metrics correleren het sterkst met processing bottlenecks?  
- Welke scaling triggers (CPU vs custom metrics) leveren stabielere performance?  
- Wat is de impact van scaling delays op end-to-end job latency?  
- Hoe beïnvloeden cooldown settings de stabiliteit van autoscaling?  

---

### Verplichte PoC Componenten

- Load test scenario  
- Auto Scaling Group configuratie  
- Observability dashboards  
- Scaling event analyse  

---

### Verwachte Output

- Metric dashboards  
- Scaling event screenshots  
- Performance grafieken  
- Analyse van scaling behavior  

---

## Track B — Full-Stack Observability & Incident Detection

### Doel

Onderzoeken hoe metrics, logs en traces samen bijdragen aan snellere probleemdetectie.

---

### Hoofdonderzoeksvraag

In welke mate verbetert full-stack observability (metrics, logs en traces) de detectie en analyse van productieproblemen?

---

### Mogelijke Subvragen

- Welke combinatie van telemetry levert de snelste root cause identification?  
- Wat is het verschil in troubleshooting tijd met en zonder tracing?  
- Hoe helpt structured logging bij incidentanalyse?  
- Welke dashboards zijn operationeel het meest bruikbaar?  

---

### Verplichte PoC Componenten

- Datadog APM tracing  
- Structured logging setup  
- Dashboard configuratie  
- Incident simulatie (bijv. resource saturation, service failure)  

---

### Verwachte Output

- Trace voorbeelden  
- Log correlation screenshots  
- Incident timeline analyse  
- Detection time vergelijking  

---

## Track C — Monitoring Tool Comparison (Datadog vs CloudWatch)

### Doel

Vergelijken van commerciële SaaS monitoring met native cloud tooling.

---

### Hoofdonderzoeksvraag

Hoe verhoudt Datadog zich tot AWS CloudWatch voor monitoring van een schaalbare EC2-based applicatie?

---

### Mogelijke Subvragen

- Welke metrics zijn standaard beschikbaar in beide tools?  
- Wat is het verschil in setup complexity?  
- Welke alerting features zijn beschikbaar?  
- Welke tool biedt betere schaalbaarheid en usability?  

---

### Verplichte PoC Componenten

- Basis monitoring setup in beide tools  
- Identieke workload test  
- Alert configuratie  
- Dashboard vergelijking  

---

### Verwachte Output

- Feature comparison table  
- Setup effort analyse  
- Alert responsiveness vergelijking  

---

## Track D — Capacity Planning & Cost Efficiency

### Doel

Onderzoeken hoe observability data kan worden gebruikt om resource provisioning te optimaliseren.

---

### Hoofdonderzoeksvraag

Hoe kan observability data gebruikt worden om onder- en overprovisioning in cloud infrastructuur te beperken?

---

### Mogelijke Subvragen

- Welke workload patronen zijn zichtbaar tijdens piekbelasting?  
- Welke instance types bieden beste price-performance ratio?  
- Welke scaling policies leiden tot resource waste?  
- Hoe kan historical metric data gebruikt worden voor capacity forecasting?  

---

### Verplichte PoC Componenten

- Load test data  
- Cost-related metrics  
- Instance type vergelijking  
- Capacity forecasting analyse  

---

### Verwachte Output

- Cost vs performance grafieken  
- Resource utilization analyse  
- Scaling efficiency evaluatie  

---

# Custom Research Proposal

Teams mogen een eigen research topic voorstellen mits goedkeuring.

---

## Vereisten voor Custom Proposals

Het voorstel moet:

- Direct gerelateerd zijn aan cloud infrastructure, observability of performance engineering  
- Meetbaar zijn via metrics, logs of traces  
- Praktisch implementeerbaar zijn binnen het project  
- Een PoC bevatten  
- Aansluiten bij AWS + observability context  

---

## In te dienen Proposal Template

Custom proposals moeten onderstaande structuur volgen:

---

### Project Context

Beschrijf:

- Het probleem  
- Waarom dit relevant is voor het project  

---

### Research Question

Formuleer één duidelijke hoofdvraag.

---

### Hypothesis

Beschrijf wat je verwacht te observeren of meten.

---

### Proposed Methodology

Beschrijf:

- Tooling  
- Experimentele setup  
- Dataverzameling  
- Validatiemethode  

---

### Planned PoC

Beschrijf:

- Wat geïmplementeerd wordt  
- Welke metrics/logs/traces worden gebruikt  
- Hoe resultaten gemeten worden  

---

## Goedkeuringsproces

Custom topics worden pas geldig na:

- Inhoudelijke goedkeuring door lector  
- Technische haalbaarheidscheck  
- Scope-validatie  

Zonder goedkeuring wordt het topic niet beoordeeld.

---

# Relatie met Research Paper

Elke track moet volledig gevolgd worden binnen de structuur van:

Project → Research Paper Richtlijnen

De paper moet aantonen:

- Concrete PoC implementatie  
- Meetbare resultaten  
- Data-gedreven conclusies  
- Reflectie op technische keuzes  

Theoretische papers zonder operationele PoC worden niet aanvaard.
