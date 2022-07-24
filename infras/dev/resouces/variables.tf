# Common
variable "env" {
  default = "dev"
}

variable "project_name" {
  default = "pianosystem"
}

variable "namespace" {
  default = "rikai"
}

# Global variables

variable "region" {
  default = "ap-northeast-1"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}

# Network

variable "cidr_block" {
  default = "10.1.0.0/16"
}

# Key pair

variable "ssh_key_path" {
  default = "./secret"
}

variable "generate_ssh_key" {
  default = true
}

# Database

variable "admin_password" {}
