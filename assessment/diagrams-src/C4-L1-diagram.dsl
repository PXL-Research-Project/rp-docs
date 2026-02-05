workspace "Online Boutique - System Context" "System Context Diagram (C4 Level 1) - Online Boutique webapplicatie (scope en externe omgeving)" {

    model {

        shopper = person "Shopper (Klant)" {
            description "Bezoekt webshop, zoekt producten, voegt toe aan winkelwagen, rekent af."
        }

        admin = person "Customer Support / Admin" {
            description "Behandelt klantvragen, refunds, order issues, operationele opvolging."
        }

        marketing = person "Marketing / Analyst" {
            description "Analyseert conversies, ads, funnel, A/B tests."
        }

        boutique = softwareSystem "Online Boutique Web Application" {
            description "E-commerce webapplicatie om producten te browsen en aankopen te doen."
        }

        idp = softwareSystem "Identity Provider (OIDC/OAuth2)" {
            description "Externe authenticatie (optioneel): SSO, MFA, accountbeheer."
            tags "External"
        }

        payment_provider = softwareSystem "Payment Provider API" {
            description "Externe payment gateway (charge/authorize/capture)."
            tags "External"
        }

        email_provider = softwareSystem "Email Delivery Service" {
            description "Externe mail delivery (transactiemails, deliverability)."
            tags "External"
        }

        shipping_carrier = softwareSystem "Shipping/Carrier API" {
            description "Externe vervoerder: labels, tracking, shipping rates."
            tags "External"
        }

        fx_rates = softwareSystem "FX Rates Provider" {
            description "Externe wisselkoersen (bv. centrale bank / marktdata)."
            tags "External"
        }

        ads_network = softwareSystem "Ads Network" {
            description "Externe advertentienetwerk / campagne delivery."
            tags "External"
        }

        analytics = softwareSystem "Analytics Platform" {
            description "Externe analytics (page views, events, funnels)."
            tags "External"
        }

        fraud = softwareSystem "Fraud/Risk Scoring" {
            description "Externe risk checks op checkout/betalingen (optioneel)."
            tags "External"
        }

        sms = softwareSystem "SMS/Push Provider" {
            description "Externe notificaties voor delivery status (optioneel)."
            tags "External"
        }

        returns_portal = softwareSystem "Returns Portal" {
            description "Extern returns-systeem (RMA, labels) (optioneel)."
            tags "External"
        }

        shopper -> boutique "Browse, add-to-cart, checkout via browser/app" "HTTPS"
        admin -> boutique "Customer support acties (order lookup, refunds, issue tracking)" "HTTPS"
        marketing -> boutique "Rapportering via dashboards / exports" "HTTPS"

        boutique -> idp "SSO login, token validatie" "OIDC/OAuth2"
        boutique -> payment_provider "Betaling verwerken (authorize/capture)" "HTTPS"
        boutique -> email_provider "Orderbevestiging en status mails versturen" "HTTPS / SMTP API"
        boutique -> shipping_carrier "Shipping rates, labels, tracking updates" "HTTPS"
        boutique -> fx_rates "Wisselkoersen opvragen voor multi-currency prijzen" "HTTPS"
        boutique -> ads_network "Ads context / targeting / creatives" "HTTPS"
        boutique -> analytics "Events en page analytics publiceren" "HTTPS"
        boutique -> fraud "Fraude/risk check bij checkout" "HTTPS"
        boutique -> sms "Shipping / Delivery notificaties" "HTTPS"
        boutique -> returns_portal "Returns / RMA initiatie en status" "HTTPS"
    }

    views {

        systemContext boutique "SystemContext" {
            include *
        }

        styles {
            element "External" {
                background #EEEEEE
                stroke #999999
            }
        }
    }
}
