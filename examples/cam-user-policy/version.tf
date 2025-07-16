terraform {
  required_version = ">=0.12"

  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = ">=1.81.0"
    }
  }
}


provider "tencentcloud" {
  region = "ap-guangzhou"
}
