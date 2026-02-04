# Research Paper Richtlijnen

Naast het infrastructuur- en automatisatieproject voeren studenten een onderzoekscomponent uit. Dit research paper sluit inhoudelijk aan op het PXLCensor project en focust op monitoring, observability en performance-analyse in cloud omgevingen.

Het doel is niet enkel theoretisch onderzoek, maar het implementeren van een Proof of Concept (PoC) die de onderzochte concepten valideert binnen de projectinfrastructuur.

---

## Doel van het Research Component

Het researchgedeelte heeft drie hoofddoelen:

- Inzicht verwerven in moderne monitoring en observability technieken
- Theorie koppelen aan praktische cloud implementaties
- Onderbouwde beslissingen leren nemen op basis van metrics en experimenten

De primaire toolingcontext voor dit project is Datadog, in lijn met de observability-eisen uit het projectgedeelte.

---

## Verplichte Structuur van de Paper

De paper moet opgebouwd zijn volgens onderstaande structuur.

### Abstract

Korte samenvatting van het volledige onderzoek:

- Probleemstelling
- Onderzoeksvraag
- Methodologie
- Belangrijkste bevindingen
- Conclusies

De abstract moet zelfstandig leesbaar zijn.

---

### Research Question en Hypothesis

Formuleer minimaal:

- Eén duidelijke onderzoeksvraag
- Eén of meerdere hypotheses

Richtlijnen:

- Concreet: gekoppeld aan een reëel probleem binnen PXLCensor
- Afgebakend: haalbaar binnen projectduur
- Meetbaar: verifieerbaar via experimenten

Voorbeelden van invalshoeken:

- Impact van autoscaling op processing latency
- Correlatie tussen queue depth en CPU saturation
- Effectiviteit van custom application metrics versus standaard system metrics

---

### Methodology

Beschrijf hoe het onderzoek uitgevoerd wordt:

- Literatuurstudie aanpak
- Keuze van tools
- Experimentele opzet
- Meetstrategie
- Validatiemethode

Dit gedeelte moet reproduceerbaar zijn voor andere teams.

---

### Literature Study

Analyseer relevante bronnen:

- Cloud monitoring best practices
- Observability principes
- Datadog documentatie
- Whitepapers of academische publicaties

Doel:

- Context creëren
- Hypotheses onderbouwen
- Vergelijkingsmateriaal aanleveren

---

### Proof of Concept Implementation

Beschrijf de praktische implementatie:

- Architectuurkeuzes
- Datadog agent configuratie
- Metrics collection
- Log ingestion
- Dashboards
- Alerts

Regels:

- Geen volledige code dumps
- Enkel relevante configuratiefragmenten
- Focus op architecturale keuzes en configuratiebeslissingen

---

### Results en Analysis

Analyseer de verzamelde data:

- Grafieken
- Trends
- Performance bottlenecks
- Scaling gedrag
- Bottleneck identificatie

Vergelijk resultaten met hypothese.

---

### Conclusion

Beantwoord expliciet:

- De onderzoeksvraag
- Geldigheid van de hypothese

Bespreek:

- Beperkingen
- Onverwachte resultaten
- Mogelijke optimalisaties

---

### Reflection (STARR)

Individuele reflectie per student op basis van:

- Situation
- Task
- Action
- Result
- Reflection

Focus op:

- Technische leerpunten
- Samenwerking
- Probleemoplossing
- Besluitvorming

---

## Praktische Richtlijnen

### Code Gebruik

Toegestaan:

- Kleine configuratiefragmenten
- Architectuursnippets
- Monitoring configuraties

Niet toegestaan:

- Volledige repositories
- Lange source code blokken

---

### Academische Schrijfstijl

Vereisten:

- Objectieve schrijfstijl
- Correct taalgebruik
- Consistente terminologie
- Duidelijke structuur
- Bronvermelding bij externe referenties

---

## Relatie met Projectgedeelte

De PoC uit het research paper moet geïntegreerd zijn in de PXLCensor infrastructuur:

- Datadog dashboards moeten actief data tonen
- Alerts moeten triggerbaar zijn
- Metrics moeten afkomstig zijn van echte workloads

Losstaande demo-opstellingen worden niet aanvaard.
