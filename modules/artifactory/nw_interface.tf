resource "aws_network_interface" "devops" {
  subnet_id   = var.subnet_id[0]
  security_groups = [aws_security_group.artifactory.id]
#   private_ips = ["172.16.10.100"]

  tags = {
    Name = "artifactory_network_interface"
  }
}