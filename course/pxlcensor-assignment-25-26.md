# Operation UrbanShield: Smart City Privacy

## The Client

UrbanEye AI, a computer vision startup, was recently acquired by the City of Berlin. The city is rolling out thousands of high-resolution cameras to optimize traffic flow and emergency response under the "Smart City" initiative.

## The Backstory

Berlin operates under a "Privacy First" legal mandate. It is strictly illegal for the city to store or view identifiable faces captured by public sensors. UrbanEye developed **PXLCensor** to solve this—a service that detects and pixelates faces.

While the "lab prototype" works in Docker, the City IT Department has a **strict No-container policy** for production cloud instances to minimize the security attack surface. Your task is to take this containerized prototype and rebuild it into a hardened, high-scale cloud platform using automation.

---

## Your Mission

As the Cloud Engineering Task Force, you must migrate PXLCensor to a resilient cloud environment that meets the City's standards for security, scalability, and monitoring.

### Bare-Metal Infrastructure & Ansible

Since Docker is banned on the production servers, you must automate the "bare metal" deployment.

* **AWS Setup:** Architect the network (VPC, Subnets, Security Groups) and high-availability components (Load Balancer, Auto Scaling Groups) via the AWS Console.
* **Ansible Orchestration:** Write playbooks to provision cloud instances from scratch—installing Node.js, Python, and PostgreSQL, and managing services via `systemd`.

### Scaling

To ensure the city's privacy mandate is met in real-time, the system must handle big fluctuations in traffic volume.

* **Elastic Capacity:** You must configure autoscaling that react to actual workload. If the image processing queue grows beyond a specific threshold during rush hour, new cloud instances must be provisioned and configured automatically.

* **Worker Optimization:** The Python-based face detection is CPU-intensive. You must determine the optimal instance type and scaling triggers (e.g., CPU utilization vs. custom metrics) to balance cost with the City's requirement for low-latency processing.

* **Reliability:** Scaling is not just about growing; it is about staying healthy. You must implement Target Tracking and Health Checks to ensure that if a single node fails, a load balancer immediately routes traffic to healthy instances.

### Departmental Portal & Identity

The City requires a centralized **Login Portal** for different departments (Traffic Control, Police, Urban Planning).

* **Identity Federation:** The portal must allow officials to log in using their official **Microsoft emails**.
* **Department Scoping:** Use the `AUTH_USER_HEADER` to ensure a Traffic Controller only sees traffic footage and cannot access data from other departments.

### Deep Observability & Performance

The City needs to know exactly how the system behaves under pressure.

* **Monitoring Stack:** Track and analyze key metrics.
* **Load Testing:** You must prove the system can handle a "Rush Hour" spike. You are required to run load tests to trigger and validate your **auto scaling** policies.

---

## Agile Team Roles

You will operate as an Agile Squad in Sprints.

* **Product Owner (PO):** A high-ranking official from the Metropolis Department of Innovation. They care about **SLAs** (Service Level Agreements). They will ask: "Can we handle 5,000 images during rush hour?"

---

## Technical Constraints

| Component | Requirement |
| --- | --- |
| **Cloud** | AWS (Manual Console setup for VPC, ELB, ASG) |
| **Automation** | **Ansible** (Strictly no Docker on production EC2) |
| **Identity** | SSO Portal with Microsoft OIDC/SAML integration |
| **Database** | Managed PostgreSQL (RDS) |
| **Observability** | TBD |
