data "aws_ami" "amiid" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20240927"]
    }
  
}

resource "tls_private_key" "mykey" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "user5-ec2_key" {
  key_name   = "user5-ec2_key"
  public_key = tls_private_key.mykey.public_key_openssh

  tags = {
    Name = "user5-ec2_key"
  }
}

resource "aws_instance" "user5ec2" {
  ami =  data.aws_ami.amiid.id
  instance_type = var.vmsize
  security_groups = [ var.security_group_id]
  subnet_id = var.subnetid
  key_name = "user5-ec2_key"
  #user_data = file("webinstall.sh")
  user_data = <<-EOF
     #!bin/bash
     sudo yum update -y
     sudo yum install httpd -y
     sudo systemctl enable httpd
     sudo systemctl start httpd
     echo "welcome to web server depolyed using TF by user5" >/var/www/html/index.html
     EOF
  tags = {
    Name = var.name
    Environment = var.env
  }
}