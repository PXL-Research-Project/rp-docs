# PXL Research Project - Documentation

## Project Overview

This repository hosts the documentation, planning, and backlog for the **PXL Research Project**. The current mission is **"Operation UrbanShield"**, focusing on the deployment of **PXLCensor** - a privacy-focused face anonymization service.

## The Application: PXLCensor

PXLCensor is a web-based microservice application that detects and blurs/pixelates faces in uploaded images.

### Architecture
The application consists of five distinct components:
1.  **Frontend (Vue.js/Vite):** The user interface for uploading images and viewing results.
2.  **API (Node.js/Fastify):** The orchestrator managing uploads, queues, and user sessions.
3.  **Processor (Python/Deface):** A GPU/CPU-intensive worker that performs the actual face detection and anonymization.
4.  **Media (Node.js):** A secure file storage service serving images via signed URLs.
5.  **Database (PostgreSQL):** Stores job status, user references, and file metadata.

### Technical Constraints
*   **Production:** Strict **No-Container Policy** for the application layer. Services must run as "bare metal" processes (managed by `systemd`) on AWS EC2 instances.
*   **Configuration:** All infrastructure must be provisioned via **Ansible**.
*   **Observability:** **Datadog** is the primary tool for metrics and logging.
*   **Identity:** **Keycloak** (OIDC) linked to Microsoft accounts.

## Directory Structure

*   **`course/`:** The formal assignment description.
*   **`assessment/`:** Rubrics and Sprint Review templates.
*   **`planning/`:**
    *   `backlog.md`: The prioritized User Stories for the agile squads.
    *   `artifacts.md`: List of deliverables per phase.
    *   `phase1.md` / `phase2.md`: High-level phase descriptions.
*   **`assets/`:** Static assets for this documentation site.

## Usage & Development

### Running Documentation Locally
This site uses **Docsify**.
1.  Install: `npm i docsify-cli -g`
2.  Run: `docsify serve .`
3.  View: `http://localhost:3000`

### Editing Content
*   Update `planning/backlog.md` as requirements evolve.
*   Use standard Markdown.
*   Diagrams can be added using Mermaid syntax.

## Key Commands (Reference)

### Testing the Application Code
When working on the codebase (not the infra), use these commands:

*   **Unit Tests:** `npm run test:unit` (in `api`, `media`, or `processor` directories).
*   **Integration Tests:** `npm run test:integration` (requires local DB).
*   **Coverage:** `npm run test:coverage`.