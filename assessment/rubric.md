# Sprint Review Rubric (Detailed)

Deze rubric beschrijft hoe Sprint Reviews worden beoordeeld. Ze is bedoeld als beoordelingskader voor lectoren en als transparante kwaliteitslat voor studenten. De rubric volgt Scrum-principes: een Sprint Review is een werkende sessie waarin de increment wordt geïnspecteerd en feedback wordt opgehaald om het plan bij te sturen.

---

## Beoordelingsschaal (per criterium)

- **4 - Excellent:** volledig, voorbeeldig en reproduceerbaar
- **3 - Goed:** voldoet, kleine hiaten zonder risico
- **2 - Voldoende:** basis aanwezig, maar onvolledig of fragiel
- **1 - Onvoldoende:** groot gebrek, onbetrouwbaar of niet aangetoond
- **0 - Niet aangetoond**

---

## Overzicht en weging

| Categorie | Gewicht |
| --- | --- |
| 1. Sprint Goal & Scope | 10% |
| 2. Increment & Demo-kwaliteit | 20% |
| 3. Evidence & Acceptatiecriteria | 15% |
| 4. Technische Kwaliteit | 20% |
| 5. Observability & Operations | 10% |
| 6. Security & Compliance | 10% |
| 7. Product Backlog Adaptatie | 10% |
| 8. Review Flow & Stakeholder Interactie | 5% |

---

## 1) Sprint Goal & Scope (10%)

**Doel:** is het sprintdoel helder, relevant en aantoonbaar gehaald?

Scoreer op:
- Sprint goal duidelijk geformuleerd en herhaald aan het begin van de review.
- Scope sluit aan bij het sprintdoel (geen scope drift in demo).
- Resultaat zichtbaar gekoppeld aan product value.
- Onvoltooid werk expliciet benoemd en teruggeplaatst op backlog.

**Ankers per score (voorbeeld):**
- 4: Sprint goal scherp, 100% herleidbaar naar getoonde increment, duidelijke afbakening.
- 3: Sprint goal duidelijk, kleine afwijkingen in scope.
- 2: Sprint goal vaag of te breed, demo toont slechts deels relevant werk.
- 1: Sprint goal ontbreekt of is niet gekoppeld aan demo.
- 0: Sprint goal niet benoemd.

---

## 2) Increment & Demo-kwaliteit (20%)

**Doel:** de increment is werkend, realistisch gedemonstreerd en toont waarde.

Scoreer op:
- Demo draait live, in realistische scenario’s, niet enkel slides.
- Alleen werk dat **Done** is, wordt gedemonstreerd.
- Demo bevat volledige flow (end-to-end), niet enkel losse features.
- Incidenten of fouten tijdens demo worden transparant uitgelegd.
- Relevante stakeholders kunnen vragen stellen en feedback geven.

**Ankers per score (voorbeeld):**
- 4: Live demo, end-to-end, foutafhandeling en edge cases zichtbaar.
- 3: Live demo, hoofdflow werkt, beperkte edge cases.
- 2: Demo deels live, deels statisch, fragiele flow.
- 1: Demo grotendeels slides of niet reproduceerbaar.
- 0: Geen demo.

---

## 3) Evidence & Acceptatiecriteria (15%)

**Doel:** bewijs dat criteria gehaald zijn en reproduceerbaar is.

Scoreer op:
- Elke getoonde story linkt expliciet naar acceptatiecriteria.
- Meetbare criteria zijn aantoonbaar (logs, screenshots, outputs).
- Bewijs is traceerbaar (link/locatie in repo of documentatie).
- Afwijkingen t.o.v. criteria zijn expliciet benoemd.
- Artifacts en documentatie zijn up-to-date en bruikbaar voor derden.
- Research-progress en PoC-artefacten zijn zichtbaar wanneer het researchcomponent actief is.

**Ankers per score (voorbeeld):**
- 4: Alle criteria expliciet afgevinkt met bewijs en locatie.
- 3: Meeste criteria gedekt, kleine gaten.
- 2: Bewijs ad-hoc, criteria impliciet.
- 1: Criteria ontbreken of zijn niet te herleiden.
- 0: Geen bewijs.

---

## 4) Technische Kwaliteit (20%)

**Doel:** stabiliteit, reproduceerbaarheid en engineeringkwaliteit.

Scoreer op:
- Deployments zijn reproduceerbaar (zelfde resultaat op nieuwe omgeving).
- Automatisatie is zichtbaar (playbooks/scripts, geen handmatige stappen).
- Betrouwbaarheid: services starten en herstellen correct.
- Basisperformance is acceptabel (geen evidente bottlenecks).
- Architectuur en configuratie zijn consistent met technische keuzes.
- Technische constraints en projectregels worden gerespecteerd.

**Ankers per score (voorbeeld):**
- 4: Reproduceerbaar, geautomatiseerd, robuust, met duidelijke bewijsvoering.
- 3: Overwegend reproduceerbaar, kleine handmatige stappen.
- 2: Reproduceerbaarheid onzeker, deels handmatig.
- 1: Fragiel of onbetrouwbaar.
- 0: Geen technische kwaliteit aangetoond.

---

## 5) Observability & Operations (10%)

**Doel:** inzicht in gedrag onder load en tijdens fouten.

Scoreer op:
- Dashboards tonen live data en relevante metrics.
- Logs zijn bruikbaar en correleerbaar met systeemgedrag.
- Incident of load test is aantoonbaar gemonitord.
- Acties zijn onderbouwd met data (geen pure aannames).
- Basis SLA/SLO of performance targets worden gerapporteerd wanneer van toepassing.

**Ankers per score (voorbeeld):**
- 4: Telemetry volledig, correlaties aantoonbaar, duidelijke conclusies.
- 3: Metrics en logs bruikbaar, beperkte correlatie.
- 2: Telemetry aanwezig maar onvolledig.
- 1: Telemetry schaars of niet bruikbaar.
- 0: Geen observability aangetoond.

---

## 6) Security & Compliance (10%)

**Doel:** basis security maatregelen aantoonbaar actief.

Scoreer op:
- Authenticatie en autorisatie gedemonstreerd.
- HTTPS en secure endpoints aantoonbaar actief.
- Geheimen/secrets niet hardcoded of publiek.
- Compliance-eisen zichtbaar toegepast (bv. PII/least privilege).

**Ankers per score (voorbeeld):**
- 4: Security end-to-end aantoonbaar, risico’s benoemd.
- 3: Belangrijkste controls aanwezig.
- 2: Basale controls, hiaten niet geadresseerd.
- 1: Security grotendeels ontbreekt.
- 0: Geen security bewijs.

---

## 7) Product Backlog Adaptatie (10%)

**Doel:** feedback leidt tot aanpassingen in backlog en planning.

Scoreer op:
- Feedback van stakeholders wordt expliciet vastgelegd.
- Backlog wordt geupdate tijdens of direct na review.
- Onvoltooide items worden correct hergepland.
- Nieuwe inzichten vertalen naar concrete backlog items.

**Ankers per score (voorbeeld):**
- 4: Feedback direct verwerkt in backlog met duidelijke acties.
- 3: Feedback genoteerd en nadien verwerkt.
- 2: Feedback genoteerd maar niet vertaald naar backlog.
- 1: Feedback informeel en niet geborgd.
- 0: Geen feedback vastgelegd.

---

## 8) Review Flow & Stakeholder Interactie (5%)

**Doel:** de review is een werkende sessie, geen eenrichtingspresentatie.

Scoreer op:
- Agenda en timebox worden gerespecteerd.
- Stakeholders zijn aanwezig en betrokken.
- Teamleden demonstreren zelf (niet alleen PO).
- Feedback wordt actief opgehaald en samengevat.

**Ankers per score (voorbeeld):**
- 4: Interactief, goed gefaciliteerd, duidelijke feedbacksamenvatting.
- 3: Overwegend interactief, beperkte stakeholder input.
- 2: Matig interactief, vooral presentatie.
- 1: Eenzijdige presentatie.
- 0: Geen reviewflow.

---

## Minimale voorwaarden (fail criteria)

Een Sprint Review kan **niet** slagen indien:
- Er geen werkende increment gedemonstreerd is.
- Het getoonde werk niet voldoet aan de Definition of Done.
- Bewijs of artifacts ontbreken voor kernstories.

---

## Opmerkingen voor beoordelaars

- De Sprint Review is **geen examen**, maar een werkende sessie met feedback en adaptatie als doel.
- De focus ligt op transparantie en inspectie, niet op perfectie.
- Gebruik dezelfde rubric consistent over alle teams.
