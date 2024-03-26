terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.62.1"
    }
  }
}

# Configure the HuaweiCloud Provider
provider "huaweicloud" {
  region     = var.credentialshwc[0]
  access_key = var.credentialshwc[1]
  secret_key = var.credentialshwc[2]
}