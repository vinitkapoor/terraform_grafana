# Configure Terragrunt to include common configurations for all environments
remote_state {
  backend = "local"
  config = {
    path = "${path_relative_to_include()}/terraform.tfstate"
  }
}

# Define variables for Grafana provider, values picked from environment variables
inputs = {
  grafana_url  = get_env("GRAFANA_URL")
  grafana_auth = get_env("GRAFANA_AUTH")
}

# Specify provider configuration to be inherited by child Terragrunt configs
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "us-east-1"
}

provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_auth
}
EOF
}

generate "grafanavars" {
  path      = "variables2.tf"
  if_exists = "overwrite"
  contents  = <<EOF
variable "grafana_url" {
  description = "Grafana URL"
  type        = string
}

variable "grafana_auth" {
  description = "Grafana Auth"
  type        = string
}

EOF
}

# Optionally, include a terraform block for required providers
generate "required_providers" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "local" {}
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "~> 2.0"
    }
  }
  required_version = ">= 1.3.0"
}
EOF
}