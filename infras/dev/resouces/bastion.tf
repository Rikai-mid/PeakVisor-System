resource "aws_key_pair" "bastion" {
  key_name   = "${var.project_name}-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCz5rQ1pANmU2Oqy99Y9g7KFnezObNeciQzv1mEXPSWv/TWwERFS4ZDIBGqhhACHQQQts5rBC9o8xmFsXkoPnCAUJtn5qj34LqAE59XeKbx9TIQXstVzfcmUlD+SIJiHE5eSzosRrkic7C1lrV0g33V8iLW/GHqOA3Aa4f/VMCKtiy4+wgOyWcWeDyFVq3fQBUR3PxK+YjgPvPVFKgDf6D/b4c1i8k3/gEElDRCcYKAVq92wbYXvoFW2yqIdTKuIm/MEa/fk7lLdd0LXzQV9JbU79AwU0vBqiYedOvmL+VXSVGR4iTbK2hmq2aKkseQTnfB+0iaHJhzgTlSPygXYoUiI44V44ezfHDzbeYRPQgk9XXxRHhc0i0LZswuW/szbLsnJYcljvYw06bRJTesUDKzw7/6YjxdmEywurWnXWXYgjTOtRgUV+ma3dFtWDx13suf0qYVhgD5nwBSdbXVl67RCfiQktXSUEHl06rB8mD0CY5zVPuIrDpenY02gb95IinR4B/ezJmkUQ9xOLs9F9mqgAt8uTJqOvH2cKlh/vWYmoTPcg1YBuO/cBJa50HwpQHndQkCdbG4Ef4NcxecuMKK+ECIq9htsrXuQLtkv0oat794kflnS6zq77X4fYOmpUX2E0OwQQedSGJMrBKg0tBlxaA6Ul/sRc1NByYVrSnlXw== pianosystem"
}

module "ec2_bastion" {
  source  = "cloudposse/ec2-bastion-server/aws"
  version = "0.27.0"

  enabled = true

  namespace                   = var.namespace
  stage                       = var.env
  name                        = "${var.project_name}-bastion-server"
  instance_profile            = ""
  instance_type               = "t3.nano"
  security_groups             = [module.sg_bastion.id]
  subnets                     = module.bastion_public_subnets.public_subnet_ids
  key_name                    = aws_key_pair.bastion.key_name
  vpc_id                      = module.vpc.vpc_id
  associate_public_ip_address = true
  assign_eip_address          = true
  monitoring                  = false
  ssm_enabled                 = true
}
