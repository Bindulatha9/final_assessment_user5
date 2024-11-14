data "http" "my_ip" {
  url    = "https://api.ipify.org?format=text"
}
resource "aws_security_group" "user5sg" {  
  name        = "user5-web-ssh"
  vpc_id = var.vpcid
  description = "web server traffic allowed ssh & http from my ip"
}

resource "aws_vpc_security_group_ingress_rule" "dev-ingress-22" {
  security_group_id = aws_security_group.user5sg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "${data.http.my_ip.body}/32"
}

resource "aws_vpc_security_group_ingress_rule" "dev-ingress-80" {
  security_group_id = aws_security_group.user5sg.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "${data.http.my_ip.body}/32"
}

resource "aws_vpc_security_group_egress_rule" "dev-egress" {
  security_group_id = aws_security_group.user5sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
  