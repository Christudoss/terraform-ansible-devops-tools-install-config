resource "aws_security_group" "artifactory" {
  name        = "allow_artifactory"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Ingress from VPC"
    from_port   = 0
    to_port     = 8981-8082
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "Ingress from VPC"
    from_port   = 0
    to_port     = 8981-8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_artifactory"
  }
}
