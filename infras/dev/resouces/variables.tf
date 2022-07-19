# Common
variable "env" {
  default = "dev"
}

variable "project_name" {
  default = "pianosystem"
}

variable "namespace" {
  default = "tf"
}

# Global variables

variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}

# Network

variable "cidr_block" {
  default = "10.1.0.0/16"
}
