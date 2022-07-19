terraform {
  backend "s3" {
    bucket  = "pianosystem-terraform-state-file-storage"
    key     = "dev/resouces/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}
