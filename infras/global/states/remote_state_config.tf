terraform {
  backend "s3" {
    bucket  = "pianosystem-terraform-state-file-storage"
    key     = "global/s3/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}
