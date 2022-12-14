# --- root/main.tf --- 

#Deploy Networking and compute Resources

module "networking" {
  source           = "./networking"
  vpc_cidr         = local.vpc_cidr
  private_sn_count = 3
  public_sn_count  = 2
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  max_subnets      = 20
  access_ip        = var.access_ip
  security_groups  = local.security_groups

}


module "compute" {
  source         = "./compute"
  public_sg      = module.networking.public_sg
  public_subnets = module.networking.public_subnets
  instance_count = 1
  instance_type  = "t2.micro"
  vol_size       = "30"
  key_name       = var.key_name
  # Only showing user data
  user_data                   = file("files/tools.sh")
  user_data_replace_on_change = true

  #templatefile("files/user_data.tpl",
  #
  #  { #Password              = var.Password
  #
  #}) # data.template_file.user_data.rendered
}