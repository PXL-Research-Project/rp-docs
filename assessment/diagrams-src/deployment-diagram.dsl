workspace "Online Boutique - EKS Production" {

    model {
        shopper = person "Shopper"

        onlineBoutique = softwareSystem "Online Boutique" {
            # Management & Controllers
            ingress_ctrl = container "AWS Load Balancer Controller" "Manages ALBs" "Go"
            secrets_op = container "External Secrets Operator" "Syncs AWS Secrets" "Go"
            
            # Kubernetes Networking Abstraction
            frontend_svc = container "Frontend Service" "Kubernetes Service (ClusterIP)" "K8s"
            
            # Microservices
            frontend = container "Frontend" "Web UI" "Go HTTP"
            checkout = container "Checkout Service" "" "Go gRPC"
            cart = container "Cart Service" "" ".NET gRPC"
            product = container "Product Catalog Service" "" "Go gRPC"
            currency = container "Currency Service" "" "Node.js gRPC"
            payment = container "Payment Service" "" "Node.js gRPC"
            shipping = container "Shipping Service" "" "Go gRPC"
            email = container "Email Service" "" "Python gRPC"
            reco = container "Recommendation Service" "" "Python gRPC"
            ads = container "Ad Service" "" "Java gRPC"
            
            otel = container "Telemetry Collector" "" "OpenTelemetry"
            rds = container "Relational Database" "" "PostgreSQL"
            redis = container "Cart Data Store" "" "Redis"
            obj = container "Object Storage" "" "S3"

            # --- Technical Relationships ---
            # Ingress Flow
            frontend_svc -> frontend "Routes to" "TCP 8080"
            
            # Internal Microservices
            frontend -> product "Browse" "gRPC/TCP 8080"
            frontend -> cart "Cart Ops" "gRPC/TCP 7070"
            frontend -> currency "Convert" "gRPC/TCP 7000"
            frontend -> reco "Get Recs" "gRPC/TCP 8080"
            frontend -> ads "Get Ads" "gRPC/TCP 9555"
            frontend -> checkout "Submit" "gRPC/TCP 5050"
            
            checkout -> cart "Get Cart" "gRPC/TCP 7070"
            checkout -> payment "Charge" "gRPC/TCP 50051"
            checkout -> shipping "Ship" "gRPC/TCP 50051"
            checkout -> email "Send" "gRPC/TCP 8080"
            checkout -> currency "Final Convert" "gRPC/TCP 7000"
            
            cart -> redis "State" "TCP 6379"
            product -> rds "Query" "SQL/TCP 5432"
            checkout -> rds "Update" "SQL/TCP 5432"

            frontend -> obj "Fetch Images" "HTTPS/TCP 443"
            product -> obj "Manage Images" "HTTPS/TCP 443"
            
            # OTel Ingestion
            frontend -> otel "Traces" "OTLP"
            checkout -> otel "Traces" "OTLP"
            cart -> otel "Traces" "OTLP"
            product -> otel "Traces" "OTLP"
            currency -> otel "Traces" "OTLP"
            payment -> otel "Traces" "OTLP"
            shipping -> otel "Traces" "OTLP"
            email -> otel "Traces" "OTLP"
            reco -> otel "Traces" "OTLP"
            ads -> otel "Traces" "OTLP"

            # Recursive relationships for replication instances
            rds -> rds "Replicate" "SQL/5432"
            redis -> redis "Replicate" "TCP/6379"
        }

        shopper -> frontend_svc "Browses" "HTTPS/TCP 443"

        deploymentEnvironment "Production" {
            deploymentNode "Amazon Web Services" "" "" "Amazon Web Services - Cloud" {
                eks_cp = infrastructureNode "EKS Control Plane" "" "" "Amazon Web Services - Elastic Kubernetes Service"
                ecr = infrastructureNode "ECR" "" "" "Amazon Web Services - Elastic Container Registry"
                iam = infrastructureNode "IAM / OIDC" "" "" "Amazon Web Services - Identity and Access Management IAM"
                secrets_mgr = infrastructureNode "AWS Secrets Manager" "" "" "Amazon Web Services - Secrets Manager"
                kms = infrastructureNode "AWS KMS" "Encryption Keys" "" "Amazon Web Services - Key Management Service"
                xray = infrastructureNode "AWS X-Ray" "" "" "Amazon Web Services - X-Ray"
                prom = infrastructureNode "Managed Prometheus" "" "" "Amazon Web Services - Managed Service for Prometheus"
                cw_logs = infrastructureNode "CloudWatch Logs" "Log Sink" "" "Amazon Web Services - CloudWatch"
                
                deploymentNode "eu-west-1" "" "" "Amazon Web Services - Region" {
                    r53 = infrastructureNode "Route 53" "" "" "Amazon Web Services - Route 53"
                    s3_inst = containerInstance obj

                    deploymentNode "VPC 10.0.0.0/16" "" "" "Amazon Web Services - VPC" {
                        s3_ep = infrastructureNode "S3 Endpoint" "" "" "Amazon Web Services - Simple Storage Service"
                        ecr_ep = infrastructureNode "ECR Interface Endpoint" "" "" "Amazon Web Services - Elastic Container Registry"
                        sts_ep = infrastructureNode "STS Interface Endpoint" "Required for IRSA" "" "Amazon Web Services - Security Token Service"
                        cw_ep = infrastructureNode "CloudWatch Interface Endpoint" "Private Log Ingestion" "" "Amazon Web Services - CloudWatch"

                        deploymentNode "AZ A" "" "" "Amazon Web Services - Availability Zone" {
                            deploymentNode "Public Subnet" "" "" "Amazon Web Services - VPC Subnet Public" {
                                alb = infrastructureNode "ALB" "" "" "Amazon Web Services - Elastic Load Balancing"
                                waf = infrastructureNode "WAF" "" "" "Amazon Web Services - WAF"
                                nat = infrastructureNode "NAT GW" "" "" "Amazon Web Services - NAT Gateway"
                            }
                            
                            deploymentNode "Private App Subnet" "" "" "Amazon Web Services - VPC Subnet Private" {
                                deploymentNode "EKS Cluster" "" "" "Amazon Web Services - Elastic Kubernetes Service" {
                                    
                                    f_svc_inst = containerInstance frontend_svc
                                    
                                    deploymentNode "Managed Node Group" "" "" "Amazon Web Services - EC2" {
                                        deploymentNode "Pod: LBC" "" "" "Kubernetes - Pod" {
                                            lbc = containerInstance ingress_ctrl
                                        }
                                        deploymentNode "Pod: ESO" "" "" "Kubernetes - Pod" {
                                            eso = containerInstance secrets_op
                                        }
                                        deploymentNode "Pod: Frontend" "" "" "Kubernetes - Pod" {
                                            fa = containerInstance frontend
                                        }
                                        deploymentNode "Pod: Checkout" "" "" "Kubernetes - Pod" {
                                            ca = containerInstance checkout
                                        }
                                        deploymentNode "Pod: OTel" "" "" "Kubernetes - Pod" {
                                            ta = containerInstance otel
                                        }
                                        
                                        # All other microservice instances preserved
                                        containerInstance cart
                                        containerInstance product
                                        containerInstance currency
                                        containerInstance payment
                                        containerInstance shipping
                                        containerInstance email
                                        containerInstance reco
                                        containerInstance ads
                                    }
                                }
                            }
                            
                            deploymentNode "Private Data Subnet" "" "" "Amazon Web Services - VPC Subnet Private" {
                                rds_p = containerInstance rds "Primary"
                                rds_s = containerInstance rds "Standby"
                                redis_p = containerInstance redis "Primary"
                                redis_r = containerInstance redis "Replica"
                            }
                        }
                    }

                    # --- Infrastructure Relationships ---
                    r53 -> alb "Resolve" "DNS/UDP 53"
                    alb -> waf "Filter" "HTTPS/TCP 443"
                    alb -> fa "Target Group (IP mode)" "HTTP/TCP 8080"
                    
                    lbc -> eks_cp "Watch" "HTTPS/TCP 443"
                    lbc -> alb "Config" "HTTPS/TCP 443"
                    
                    # KMS Encryption Links
                    rds_p -> kms "Encrypts Storage"
                    secrets_mgr -> kms "Encrypts Secrets"
                    fa -> kms "Decrypt Secrets" "HTTPS/443"
                    
                    # Private Egress Flow
                    eso -> sts_ep "Assume Role" "HTTPS/TCP 443"
                    sts_ep -> iam "Auth Loop" "HTTPS/TCP 443"
                    eso -> secrets_mgr "Sync Secrets" "HTTPS/TCP 443"
                    
                    fa -> ecr_ep "Pull" "HTTPS/TCP 443"
                    ecr_ep -> ecr "Proxy"
                    fa -> iam "Auth" "HTTPS/TCP 443"

                    fa -> s3_ep "Request" "HTTPS/TCP 443"
                    s3_ep -> s3_inst "Bridge" "HTTPS/TCP 443"
                    
                    # Observability Sinks
                    ta -> xray "Traces" "OTLP/gRPC 443"
                    ta -> prom "Metrics" "Remote Write/TCP 443"
                    ta -> cw_ep "Private Logs" "HTTPS/TCP 443"
                    cw_ep -> cw_logs "Forward"
                    
                    ca -> nat "External Payment GW" "HTTPS/TCP 443"
                }
            }
        }
    }

    views {
        deployment onlineBoutique "Production" "EKS_KMS_Fixed" {
            include *
        }
        theme https://static.structurizr.com/themes/amazon-web-services-2023.01.31/theme.json
    }
}