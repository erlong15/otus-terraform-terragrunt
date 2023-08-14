resource "yandex_vpc_default_security_group" "ch-training-sg" {
  network_id = module.vpc.vpc_id

  ingress {
    protocol       = "ANY"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
  ingress {
    description    = "VNC"
    port           = 5901
    protocol       = "TCP"    
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    protocol          = "ANY"
    description       = "Communication inside this SG"
    predefined_target = "self_security_group"
  }

  ingress {
    protocol       = "ICMP"
    description    = "ICMP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

    egress {
    protocol       = "ANY"
    description    = "To internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol          = "ANY"
    description       = "Communication inside this SG"
    predefined_target = "self_security_group"
  }
}