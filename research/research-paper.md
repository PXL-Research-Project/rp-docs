# Research Paper Richtlijnen

Naast het infrastructuur- en automatisatieproject voeren studenten een onderzoekscomponent uit. Dit research paper sluit inhoudelijk aan op het project en focust op monitoring, observability en performance-analyse in cloud omgevingen.

Het doel is niet enkel theoretisch onderzoek, maar het implementeren van een Proof of Concept (PoC) die de onderzochte concepten valideert binnen de projectinfrastructuur.

---

## Titelpagina

De titelpagina wordt aangeleverd als apart document volgens het officiële PXL-template.

---

## Inhoudsopgave

De inhoudsopgave wordt automatisch gegenereerd in de finale paper.

---

## Doel van het Research Component

Het researchgedeelte heeft drie hoofddoelen:

- Inzicht verwerven in moderne monitoring en observability technieken
- Theorie koppelen aan praktische cloud implementaties
- Onderbouwde beslissingen leren nemen op basis van metrics en experimenten

De observability tooling volgt de keuzes uit het projectgedeelte.

---

## Verplichte Structuur van de Paper

De paper moet opgebouwd zijn volgens onderstaande structuur.

---

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

- Concreet: gekoppeld aan een reëel probleem binnen het project
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

### Bronbespreking (Literature Study)

Analyseer relevante bronnen:

- Cloud monitoring best practices
- Observability principes
- Documentatie van de gekozen observability tool
- Whitepapers of academische publicaties

Doel:

- Context creëren
- Hypotheses onderbouwen
- Vergelijkingsmateriaal aanleveren

Bronnen moeten beoordeeld worden op relevantie en betrouwbaarheid volgens CRAAP-principes.

---

### Proof of Concept Implementation

Beschrijf de praktische implementatie:

- Architectuurkeuzes
- Agent configuratie van de gekozen observability tool
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

## Bibliografie

Alle gebruikte bronnen moeten correct opgenomen worden volgens APA of IEEE referentiestijl.

---

## AI Usage Declaration

Indien AI-tools gebruikt worden tijdens het researchproces of bij het schrijven van de paper:

Verplicht te vermelden:

- Welke AI-tool(s) gebruikt werden
- Voor welke taken (bv. brainstorming, herformuleren, code-analyse)
- Voorbeeldprompts
- Manuele validatie van gegenereerde inhoud

Onvermeld AI-gebruik wordt beschouwd als academische fout.

---

## Validatie Onderzoek (VO)

De Validatie Onderzoek vindt plaats tijdens Sprint 1 (SR0).

Tijdens deze sessie worden beoordeeld:

- Onderzoeksvraag
- Methodologie
- Bronnenselectie

Goedkeuring van VO is verplicht om verder te mogen gaan naar de uitvoeringsfase.

---

## Realisatie & Research Artefacten

Artefacten vormen het bewijs van de onderzoeksuitvoering.

Voorbeelden:

- Monitoring dashboards
- Load test resultaten
- Meetlogboeken
- Grafieken
- Screenshots van configuraties

Deze artefacten worden gebruikt tijdens Sprint Reviews en de eindpresentatie.

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

De PoC uit het research paper moet geïntegreerd zijn in de projectinfrastructuur:

- Dashboards moeten actief data tonen
- Alerts moeten triggerbaar zijn
- Metrics moeten afkomstig zijn van echte workloads

Losstaande demo-opstellingen worden niet aanvaard.
