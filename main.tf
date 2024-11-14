module "modvpc" {
    source = "./modules/VPC"
}
module "modsg" {
    source = "./modules/Security_group"  
    vpcid = module.modvpc.vpcid  
}

module "myec2" {
    source = "./modules/ec2"
    subnetid = module.modvpc.subnetid
    security_group_id = module.modsg.mysg
    name = var.name
    env = var.env 
}


