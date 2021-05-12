variable "cloudflare_zone_id" {
  description = "The Domain's CloudFlare Zone ID"
  type        = string
}

variable "google_site_verification_code" {
  sensitive   = true
  description = "The Google Search Console verification code"
  type        = string
}

resource "cloudflare_zone_settings_override" "settings" {
  zone_id = var.cloudflare_zone_id
  settings {
    ssl                      = "full"
    always_use_https         = "on"
    automatic_https_rewrites = "on"
  }
}

resource "cloudflare_record" "root_dns_settings" {
  zone_id = var.cloudflare_zone_id
  name    = "geoffrey.dev"
  value   = "geoffhayward.github.io"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "google_site_verification_code" {
  zone_id = var.cloudflare_zone_id
  name    = "geoffrey.dev"
  type    = "TXT"
  value   = "google-site-verification=${var.google_site_verification_code}"
}

resource "cloudflare_worker_route" "geoffre_dev_worker_route" {
  zone_id     = var.cloudflare_zone_id
  pattern     = "geoffrey.dev/*"
  script_name = cloudflare_worker_script.geoffre_dev_script.name
}

resource "cloudflare_worker_script" "geoffre_dev_script" {
  name    = "geoffrey-dev-worker"
  content = file("cloudflare-worker.js")
}
