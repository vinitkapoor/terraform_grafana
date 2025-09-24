# Include the root terragrunt.hcl for shared configuration
include {
  path = find_in_parent_folders()
}

# Define local variables
locals {
  notification_name = "grafana-notification"
  environment       = "dev"
}

# Pass input variables to the underlying Terraform module
inputs = {
  name        = local.notification_name
  environment = local.environment
}

# Configure the source of the Terraform module
terraform {
    source = "../../../modules/notifications"
}