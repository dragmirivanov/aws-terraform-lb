provider "aws" {
    region = "eu-central-1"
}

module "endava-elb" {
  source = "./modules/loadBalancer-web"
}

module "endava-db" {
  source = "./modules/rds"
}


module "endava-monitoring" {
  source = "./modules/monitoring"
}


output "module_elb_output" {
  description = "The Load balancer was created. The IP is:"
  value = module.endava-elb.elb_dns_name
}

