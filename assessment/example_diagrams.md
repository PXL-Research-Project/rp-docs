# Voorbeelddiagrammen

## C4 - L1 System Context Diagram

[C4-L1-System-Context-Diagram](assessment/images/C4-L1-diagramSystemContext.svg)

---

## C4 - L2 Container Diagram

[C4-L2-Container-Diagram](assessment/images/C4-L2containers-light.svg)

---

## Deployment diagram

```mermaid
flowchart TB

%% =========================
%% EDGE LAYER
%% =========================

users[End Users\nBrowsers/Mobile]
admins[Ops/Admins\nVPN/Bastion Access]
internet((Internet))

dns_public["Route53 Public DNS\nonline-boutique.com"]
waf["AWS WAF\nL7 Filtering"]

%% =========================
%% REGION + VPC
%% =========================

subgraph region["AWS Region eu-west-1"]
subgraph vpc["VPC 10.0.0.0/16"]

igw[Internet Gateway]

%% ROUTING
rtb_public["Public RT\n0.0.0.0/0 -> IGW"]
rtb_priv_a["Private RT AZ-A\n0.0.0.0/0 -> NAT-A"]
rtb_priv_b["Private RT AZ-B\n0.0.0.0/0 -> NAT-B"]

%% SECURITY GROUPS
sg_alb["SG-ALB\nIN:443/80 ANY\nOUT:80 SG-APP"]
sg_app["SG-APP\nIN:80 from ALB\nIN:50051 SG-APP\nOUT:443 NAT\nOUT:5432 RDS\nOUT:6379 REDIS"]
sg_rds["SG-RDS\nIN:5432 SG-APP"]
sg_redis["SG-REDIS\nIN:6379 SG-APP"]
sg_bastion["SG-BASTION\nIN:22 Admin IP"]

%% =========================
%% AZ A
%% =========================

subgraph az_a["Availability Zone A"]

subgraph pub_a["Public Subnet A 10.0.1.0/24"]
alb["Application Load Balancer\nHTTPS Listener 443"]
nat_a["NAT Gateway A"]
bastion["Bastion Host\nEC2 t3.micro"]
end

subgraph app_a["Private App Subnet A 10.0.11.0/24"]
fe_a["EC2 Frontend A\nt3.medium"]
be_a["EC2 Backend A\nm5.large"]
otel_a["OTel Agent A"]
end

subgraph data_a["Private Data Subnet A 10.0.21.0/24"]
rds_primary["RDS PostgreSQL Primary\ndb.m5.large"]
redis_primary["Redis Primary\ncache.t3.medium"]
end

end

%% =========================
%% AZ B
%% =========================

subgraph az_b["Availability Zone B"]

subgraph pub_b["Public Subnet B 10.0.2.0/24"]
nat_b["NAT Gateway B"]
end

subgraph app_b["Private App Subnet B 10.0.12.0/24"]
fe_b["EC2 Frontend B\nt3.medium"]
be_b["EC2 Backend B\nm5.large"]
otel_b["OTel Agent B"]
end

subgraph data_b["Private Data Subnet B 10.0.22.0/24"]
rds_standby["RDS Standby\nMulti-AZ"]
redis_replica["Redis Replica"]
end

end

%% =========================
%% SHARED SERVICES
%% =========================

s3["S3 Object Storage\nImages / Uploads"]
secrets["Secrets Manager"]
cloudwatch["CloudWatch Logs"]
prometheus["Prometheus"]
grafana["Grafana Dashboard"]

end
end

%% =========================
%% EDGE FLOW
%% =========================

users -->|DNS Query| dns_public
dns_public -->|A Record| alb

users -->|HTTPS 443| internet
internet --> waf
waf --> alb

%% =========================
%% SECURITY GROUP BINDINGS
%% =========================

sg_alb -.-> alb
sg_app -.-> fe_a
sg_app -.-> fe_b
sg_app -.-> be_a
sg_app -.-> be_b
sg_rds -.-> rds_primary
sg_rds -.-> rds_standby
sg_redis -.-> redis_primary
sg_redis -.-> redis_replica
sg_bastion -.-> bastion

%% =========================
%% ROUTING
%% =========================

igw --- vpc
rtb_public --> igw
rtb_priv_a --> nat_a
rtb_priv_b --> nat_b

rtb_public -.-> pub_a
rtb_public -.-> pub_b
rtb_priv_a -.-> app_a
rtb_priv_a -.-> data_a
rtb_priv_b -.-> app_b
rtb_priv_b -.-> data_b

%% =========================
%% LOAD BALANCING
%% =========================

alb -->|HTTP 80 Forward| fe_a
alb -->|HTTP 80 Forward| fe_b

alb -->|Health Checks| fe_a
alb -->|Health Checks| fe_b

%% =========================
%% APPLICATION FLOWS
%% =========================

%% Frontend to Backend
fe_a -->|gRPC 50051| be_a
fe_b -->|gRPC 50051| be_b
be_a <-->|Cross-AZ gRPC| be_b

%% Backend to DB
be_a -->|SQL 5432| rds_primary
be_b -->|SQL 5432| rds_primary

%% Redis
be_a -->|TCP 6379| redis_primary
be_b -->|TCP 6379| redis_replica

%% =========================
%% HA REPLICATION
%% =========================

rds_primary -.->|Sync Replication| rds_standby
redis_primary -.->|Async Replication| redis_replica

%% =========================
%% OUTBOUND TRAFFIC
%% =========================

be_a -->|HTTPS 443 Updates/APIs| nat_a
be_b -->|HTTPS 443 Updates/APIs| nat_b

nat_a --> igw
nat_b --> igw

%% =========================
%% STORAGE
%% =========================

fe_a -->|HTTPS 443| s3
fe_b -->|HTTPS 443| s3
be_a -->|HTTPS 443| s3
be_b -->|HTTPS 443| s3

%% =========================
%% SECRETS
%% =========================

fe_a -->|TLS| secrets
fe_b -->|TLS| secrets
be_a -->|TLS| secrets
be_b -->|TLS| secrets

%% =========================
%% OBSERVABILITY TRAFFIC
%% =========================

otel_a -->|OTLP Metrics| prometheus
otel_b -->|OTLP Metrics| prometheus

otel_a -->|Logs| cloudwatch
otel_b -->|Logs| cloudwatch

prometheus --> grafana

%% =========================
%% ADMIN ACCESS
%% =========================

admins -->|SSH 22| bastion
bastion -->|SSH 22| fe_a
bastion -->|SSH 22| fe_b
bastion -->|SSH 22| be_a
bastion -->|SSH 22| be_b
```

### Firewall Rules

#### SG-ALB (Application Load Balancer)

Doel: publiek verkeer ontvangen en alleen doorsturen naar frontend EC2.

#### Inbound Rules

| Source    | Protocol | Port | Description                          |
| --------- | -------- | ---- | ------------------------------------ |
| 0.0.0.0/0 | TCP      | 443  | HTTPS user traffic (production)      |
| 0.0.0.0/0 | TCP      | 80   | HTTP redirect naar HTTPS (optioneel) |

#### Outbound Rules

| Destination | Protocol | Port | Description                             |
| ----------- | -------- | ---- | --------------------------------------- |
| SG-APP      | TCP      | 80   | Forward traffic naar frontend instances |

---

### SG-APP (Frontend + Backend EC2 Instances)

Doel: applicatielaag, microservices, interne service calls.

#### Inbound Rules

| Source     | Protocol | Port  | Description                         |
| ---------- | -------- | ----- | ----------------------------------- |
| SG-ALB     | TCP      | 80    | ALB -> Frontend HTTP traffic        |
| SG-APP     | TCP      | 50051 | gRPC microservice east-west traffic |
| SG-BASTION | TCP      | 22    | SSH beheer (optioneel)              |

#### Outbound Rules

| Destination         | Protocol | Port | Description                           |
| ------------------- | -------- | ---- | ------------------------------------- |
| 0.0.0.0/0 (via NAT) | TCP      | 443  | External APIs, updates, SaaS services |
| SG-RDS              | TCP      | 5432 | PostgreSQL database                   |
| SG-REDIS            | TCP      | 6379 | Redis cache                           |
| AWS Secrets Manager | TCP      | 443  | Secrets ophalen                       |
| S3 Gateway Endpoint | TCP      | 443  | Object storage access                 |

---

### SG-RDS (Database Security Group)

Doel: database volledig isoleren.

#### Inbound Rules

| Source | Protocol | Port | Description                |
| ------ | -------- | ---- | -------------------------- |
| SG-APP | TCP      | 5432 | Backend application access |

#### Outbound Rules

| Destination | Protocol | Port | Description                  |
| ----------- | -------- | ---- | ---------------------------- |
| None        | -        | -    | Default deny (best practice) |

---

### SG-REDIS (Cache Layer)

Doel: alleen backend toegang.

#### Inbound Rules

| Source | Protocol | Port | Description          |
| ------ | -------- | ---- | -------------------- |
| SG-APP | TCP      | 6379 | Backend cache access |

#### Outbound Rules

| Destination | Protocol | Port | Description  |
| ----------- | -------- | ---- | ------------ |
| None        | -        | -    | Default deny |

---

### SG-BASTION (Admin Access)

Doel: veilige beheer-entrypoint.

#### Inbound Rules

| Source                | Protocol | Port | Description |
| --------------------- | -------- | ---- | ----------- |
| Admin Public IP Range | TCP      | 22   | SSH access  |

#### Outbound Rules

| Destination | Protocol | Port | Description        |
| ----------- | -------- | ---- | ------------------ |
| SG-APP      | TCP      | 22   | SSH to private EC2 |

---
