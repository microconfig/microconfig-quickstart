provider "microconfig" {
  source_dir      = "../"
  entrypoint      = "/usr/local/bin/microconfig"
}

resource "microconfig_service" "payment-backend" {
  environment = "dev"
  name        = "payment-backend"
}

output "data" {
  value = microconfig_service.payment-backend.data["deploy.yaml"]
}