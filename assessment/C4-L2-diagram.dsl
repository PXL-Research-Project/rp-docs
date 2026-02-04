workspace "Online Boutique" "Container Diagram (C4 Level 2) - Online Boutique (interne softwarestructuur)" {

    configuration {
        scope softwareSystem
    }

    !identifiers hierarchical

    model {

        shopper = person "Shopper" {
            description "Gebruikt web UI in browser."
        }

        admin = person "Admin/Support" {
            description "Operationeel beheer, klantendossiers, refunds (via interne UI/console)."
        }

        onlineBoutique = softwareSystem "Online Boutique Web Application" {
            description "Online Boutique webapplicatie (container-level interne softwarestructuur)."

            lb = container "Reverse Proxy / Load Balancer" {
                technology "Nginx / ALB"
                description "TLS termination, routing, rate limiting, WAF rules (logisch)."
            }

            frontend = container "Frontend (Web UI + Edge API)" {
                technology "Go HTTP server"
                description "Serveert UI, beheert sessie-id, orchestreert user flows; roept backend services aan via gRPC."
            }

            checkout = container "Checkout Service" {
                technology "Go (gRPC)"
                description "Orkestreert checkout: cart ophalen, payment, shipping, email bevestiging."
            }

            cart = container "Cart Service" {
                technology ".NET/C# (gRPC)"
                description "Leest/schrijft winkelwagen items in Redis."
            }

            product = container "Product Catalog Service" {
                technology "Go (gRPC)"
                description "Productlijst, zoeken, productdetails. (Brondata/DB)."
            }

            currency = container "Currency Service" {
                technology "Node.js (gRPC)"
                description "Converteert bedragen tussen valuta; haalt real-world koersen op."
            }

            payment = container "Payment Service" {
                technology "Node.js (gRPC)"
                description "Verwerkt creditcard charge (mock) en geeft transactie-id terug."
            }

            shipping = container "Shipping Service" {
                technology "Go (gRPC)"
                description "Berekening shipping cost en verzendproces (mock)."
            }

            email = container "Email Service" {
                technology "Python (gRPC)"
                description "Verstuurt order confirmation email (mock)."
            }

            reco = container "Recommendation Service" {
                technology "Python (gRPC)"
                description "Aanbevelingen op basis van items in cart."
            }

            ads = container "Ad Service" {
                technology "Java (gRPC)"
                description "Tekst-ads op basis van contextwoorden."
            }

            redis = container "Cart Data Store" {
                technology "Redis"
                description "Sessiegerelateerde cart storage (key-value)."
            }

            rds_app = container "Relational Database" {
                technology "PostgreSQL (SQL)"
                description "Persistente data (product master, orders, payments metadata, auditing)."
            }

            obj = container "Object Storage" {
                technology "S3-compatible"
                description "Product images, uploads, receipts (immutable artifacts)."
            }

            queue = container "Message Broker" {
                technology "SQS/RabbitMQ"
                description "Asynchrone events: order-created, payment-confirmed, shipment-created, email-send."
            }

            otel = container "Telemetry Collector" {
                technology "OpenTelemetry Collector"
                description "Centraliseert traces/metrics/logs forwarding."
            }

            mon = container "Monitoring/Alerting" {
                technology "Prometheus + Grafana"
                description "Dashboards, alerts, SLOs."
            }

            logs = container "Central Logging" {
                technology "ELK / OpenSearch"
                description "Log ingestie, correlatie met trace-id."
            }

            sec = container "Secrets Manager Client" {
                technology "SDK/Sidecar"
                description "Runtime ophalen van secrets (DB creds, API keys)."
            }

            loadgen = container "Load Generator" {
                technology "Locust"
                description "Simuleert realistische user flows (test/benchmark)."
            }
        }

        shopper -> onlineBoutique.lb "Gebruikt webapp" "HTTPS 443"
        admin -> onlineBoutique.lb "Admin acties (optionele admin UI/API)" "HTTPS 443"

        onlineBoutique.lb -> onlineBoutique.frontend "Route /, /product, /cart, /checkout" "HTTP 80 (internal)"

        onlineBoutique.frontend -> onlineBoutique.product "Product listing/search/detail" "gRPC 50051"
        onlineBoutique.frontend -> onlineBoutique.cart "Add/remove/view cart" "gRPC 50051"
        onlineBoutique.frontend -> onlineBoutique.currency "Price conversion / display" "gRPC 50051"
        onlineBoutique.frontend -> onlineBoutique.reco "Recommendations for user/cart" "gRPC 50051"
        onlineBoutique.frontend -> onlineBoutique.ads "Contextual ads" "gRPC 50051"
        onlineBoutique.frontend -> onlineBoutique.checkout "Checkout submit" "gRPC 50051"

        onlineBoutique.checkout -> onlineBoutique.cart "Get cart content" "gRPC 50051"
        onlineBoutique.checkout -> onlineBoutique.payment "Charge card / authorize" "gRPC 50051"
        onlineBoutique.checkout -> onlineBoutique.shipping "Quote + ship items" "gRPC 50051"
        onlineBoutique.checkout -> onlineBoutique.email "Send confirmation" "gRPC 50051"
        onlineBoutique.checkout -> onlineBoutique.currency "Final currency conversion" "gRPC 50051"

        onlineBoutique.cart -> onlineBoutique.redis "Read/write cart" "TCP 6379"

        onlineBoutique.product -> onlineBoutique.rds_app "Read product data" "SQL 5432"
        onlineBoutique.checkout -> onlineBoutique.rds_app "Write order + audit trail" "SQL 5432"

        onlineBoutique.frontend -> onlineBoutique.obj "Fetch product images" "HTTPS 443"
        onlineBoutique.product -> onlineBoutique.obj "Manage product images (admin pipeline)" "HTTPS 443"

        onlineBoutique.checkout -> onlineBoutique.queue "Publish order events" "AMQP/HTTPS"
        onlineBoutique.email -> onlineBoutique.queue "Consume email-send jobs" "AMQP/HTTPS"
        onlineBoutique.shipping -> onlineBoutique.queue "Consume shipment jobs, publish tracking" "AMQP/HTTPS"
        onlineBoutique.payment -> onlineBoutique.queue "Publish payment status" "AMQP/HTTPS"

        onlineBoutique.frontend -> onlineBoutique.otel "Traces/metrics/logs" "OTLP gRPC 4317"
        onlineBoutique.checkout -> onlineBoutique.otel "Traces/metrics/logs" "OTLP gRPC 4317"
        onlineBoutique.cart -> onlineBoutique.otel "Traces/metrics/logs" "OTLP gRPC 4317"
        onlineBoutique.product -> onlineBoutique.otel "Traces/metrics/logs" "OTLP gRPC 4317"
        onlineBoutique.currency -> onlineBoutique.otel "Traces/metrics/logs" "OTLP gRPC 4317"
        onlineBoutique.payment -> onlineBoutique.otel "Traces/metrics/logs" "OTLP gRPC 4317"
        onlineBoutique.shipping -> onlineBoutique.otel "Traces/metrics/logs" "OTLP gRPC 4317"
        onlineBoutique.email -> onlineBoutique.otel "Traces/metrics/logs" "OTLP gRPC 4317"
        onlineBoutique.reco -> onlineBoutique.otel "Traces/metrics/logs" "OTLP gRPC 4317"
        onlineBoutique.ads -> onlineBoutique.otel "Traces/metrics/logs" "OTLP gRPC 4317"

        onlineBoutique.otel -> onlineBoutique.mon "Export metrics" "Prometheus scrape 9090"
        onlineBoutique.otel -> onlineBoutique.logs "Forward logs" "HTTPS 443"

        onlineBoutique.loadgen -> onlineBoutique.lb "Synthetic traffic for tests" "HTTPS 443"

        onlineBoutique.frontend -> onlineBoutique.sec "Fetch secrets/config at runtime" "HTTPS 443"
        onlineBoutique.checkout -> onlineBoutique.sec "Fetch secrets/config at runtime" "HTTPS 443"
        onlineBoutique.product -> onlineBoutique.sec "Fetch secrets/config at runtime" "HTTPS 443"
        onlineBoutique.cart -> onlineBoutique.sec "Fetch secrets/config at runtime" "HTTPS 443"
        onlineBoutique.payment -> onlineBoutique.sec "Fetch secrets/config at runtime" "HTTPS 443"
        onlineBoutique.email -> onlineBoutique.sec "Fetch secrets/config at runtime" "HTTPS 443"
        onlineBoutique.shipping -> onlineBoutique.sec "Fetch secrets/config at runtime" "HTTPS 443"
        onlineBoutique.currency -> onlineBoutique.sec "Fetch secrets/config at runtime" "HTTPS 443"
        onlineBoutique.reco -> onlineBoutique.sec "Fetch secrets/config at runtime" "HTTPS 443"
        onlineBoutique.ads -> onlineBoutique.sec "Fetch secrets/config at runtime" "HTTPS 443"
    }

    views {
        container onlineBoutique containers {
            description "Container Diagram (C4 Level 2) - Online Boutique (interne softwarestructuur)"
            include *
        }
    }
}
