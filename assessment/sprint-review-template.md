# Sprint Review Template: Operation UrbanShield

**Project:** Operation UrbanShield - Smart City Privacy

**Squad Naam:** [Naam]

**Sprint Nummer:** [Nummer]

**Fase:** [Fase 1: Manual PoC / ...]

---

## Sprint Goal

Wat was het hoofddoel van deze sprint en welke specifieke onderdelen van de PXLCensor stack stonden centraal?

---

## Live Demo: Scenario Based

Geen losse features, maar een proces-gebaseerde demonstratie voor de Product Owner.

* **Scenario:** [Bijv. "Een ambtenaar van de verkeersdienst logt in via Microsoft en uploadt 10 foto's van een verkeerskruispunt tijdens spitsuur."]
* **Wat laten we zien:** [Bijv. Login flow, Processing status in de UI, Anoniem resultaat, Scaling events in de AWS console.]

---

## Technische Bewijslast (Artifacts)

Presentatie van de bewijslast die de kwaliteit van het werk onderbouwt.

| Artifact | Beschrijving & Locatie (Link/Repo) | Status |
| --- | --- | --- |
| **Architecture Diagram** | Visuele weergave van de huidige Cloud infra. | [Voltooid/In progress] |
| **Ansible Playbooks** | Bewijs van geautomatiseerde deployment en idempotency. | [Link naar Git] |
| **Datadog Dashboards** | Live view van systeemgezondheid en metrics. | [Screenshot/Link] |
| **Load Test Reports** | Resultaten van de stresstest en ASG reactie. | [PDF/Log] |
| **Security Audit** | Bewijs van HTTPS, Keycloak integratie en Header-auth. | [Testrapport] |

---

## SLA & Performance Status

Hoe presteert het systeem ten opzichte van de eisen van de Stad Berlijn?

* **Availability:** Hoeveel downtime is er geweest tijdens de deployment?
* **Latency:** Wat is de gemiddelde verwerkingstijd van een standaard afbeelding?
* **Scaling:** Hoe snel werd een nieuwe worker gespind tijdens de load test?
* **Poison Pill Resilience:** Hoe reageerde het systeem op het corrupte 4K testbestand?

---

## Definition of Done Check

Is alles wat we laten zien ook echt "af"?

[] ...
[] ...
[] ...

---

## Feedback Product Owner

* **Opmerkingen van de PO:** [Ruimte voor feedback]
* **Nieuwe inzichten/eisen:** [Ruimte voor wijzigingen in de backlog]

---

## Volgende Stappen

Wat is de prioriteit voor de komende sprint om de volgende milestone te bereiken?

1. [Prioriteit 1]
2. [Prioriteit 2]

