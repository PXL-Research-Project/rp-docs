# Sprint Planning & Roadmap

INTERN - enkel voor lectoren. Dit document is niet zichtbaar voor studenten.

Dit document bevat de planning, inschattingen en verdeling van de User Stories over de 3 sprints.

**Team Capaciteit:**
- Teamgrootte: 5 Studenten
- Beschikbaarheid: ~1 dag per week per student
- Sprint lengte: 3 weken
- **Totale capaciteit (geschat):** ~15-20 Story Points per sprint.

**Estimation Key (Fibonacci):**
- **1:** Triviaal (Tekst aanpassing, config change)
- **2:** Klein (Simpel script, kleine bugfix)
- **3:** Gemiddeld (Standaard feature, halve dag werk)
- **5:** Groot (Complex, onzekerheden, hele dag werk)
- **8:** Zeer Groot (Moet waarschijnlijk opgesplitst worden, meerdere dagen)

---

## Sprint 1: Manual Cloud Foundation
*Focus: Netwerk, Security Groups, en handmatige deployment van de stack.*

| ID | Title | Priority | Story Points | Assignee | Status |
|----|-------|----------|--------------|----------|--------|
| **US-01** | **Secure Network Architecture (VPC)** | High | 5 | | To Do |
| **US-02** | **Managed Database Deployment (RDS)** | High | 3 | | To Do |
| **US-03** | **Bare-Metal Application Deployment (EC2)** | High | 8 | | To Do |
| **US-04** | Frontend Hosting (Nginx Manual) | Medium | 3 | | To Do |
| **TECH-01** | Git Repository Setup & Access | High | 1 | | To Do |

**Sprint Doel:** Een werkende applicatie op AWS, zelfs als deze handmatig is gestart en nog niet schaalt.
**Totaal Punten:** ~20

---

## Sprint 2: Infrastructure as Code (Ansible)
*Focus: Automatisering, Idempotency en Secret Management.*

| ID | Title | Priority | Story Points | Assignee | Status |
|----|-------|----------|--------------|----------|--------|
| **US-05** | **Ansible Inventory & Base Config** | High | 3 | | To Do |
| **US-06** | **Service Management (Systemd)** | High | 5 | | To Do |
| **US-07** | App Deployment Playbooks | High | 5 | | To Do |
| **US-08** | Ansible Vault (Secrets) | Medium | 3 | | To Do |
| **TECH-02** | Domain Name & DNS (Route53) | Low | 2 | | To Do |

**Sprint Doel:** Geen SSH meer nodig voor updates. Deployment gebeurt via `ansible-playbook`.
**Totaal Punten:** ~18

---

## Sprint 3: Production Hardening
*Focus: High Availability, Security en Observability.*

| ID | Title | Priority | Story Points | Assignee | Status |
|----|-------|----------|--------------|----------|--------|
| **US-11** | **Elastic Compute Scaling (ASG)** | High | 8 | | To Do |
| **US-10** | **Secure Identity Integration (Keycloak SSO)** | Medium | 5 | | To Do |
| **US-12** | **Full-Stack Observability (Datadog)** | Medium | 5 | | To Do |
| **US-09** | Load Balancing (ALB + SSL) | High | 5 | | To Do |
| **TECH-03** | Final Load Test & Demo Prep | High | 3 | | To Do |

**Sprint Doel:** Een zelf-helend, veilig en inzichtelijk systeem dat klaar is voor de "Rush Hour" demo.
**Totaal Punten:** ~26 (Ambitieus, mogelijk overflow taken)

---

## Definition of Ready (DoR)
Een story mag pas in de sprint opgenomen worden als:
1. De User Story helder is omschreven.
2. Acceptatiecriteria compleet zijn.
3. Externe afhankelijkheden (bijv. AWS credits) geregeld zijn.

## Definition of Done (DoD)
Een story is pas klaar als:
1. Code/Configuratie is gecommit in Git.
2. Deployment is succesvol uitgevoerd op de test-omgeving.
3. Acceptatiecriteria zijn gedemonstreerd aan een teamlid (peer review).
4. Documentatie (README/Wiki) is bijgewerkt indien nodig.
