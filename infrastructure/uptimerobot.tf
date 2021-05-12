data "uptimerobot_alert_contact" "email_alerts" {
  friendly_name = "Email Alerts for geoffrey.dev"
}

data "uptimerobot_alert_contact" "sms_alerts" {
  friendly_name = "SMS Alerts for geoffrey.dev"
}

resource "uptimerobot_monitor" "main" {
  friendly_name = "Geoffrey.dev"
  type          = "keyword"
  keyword_type  = "not exists"
  keyword_value = "Welcome to Geoffrey.dev"
  url           = "https://geoffrey.dev"
  interval      = 300

  alert_contact {
    id = data.uptimerobot_alert_contact.email_alerts.id
  }

  alert_contact {
    id = data.uptimerobot_alert_contact.sms_alerts.id
  }
}