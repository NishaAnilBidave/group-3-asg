#Security group for Blue server
resource "aws_security_group" "server_sg" {
  name        = "server-sg"
  description = "Allow connection for server security group."
  vpc_id      = data.aws_vpc.vpc_group3.id

  ingress {
    description = "Allow port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["110.224.205.97/32"]
  }

  ingress {
    description = "Allow port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["110.224.205.97/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "server-sg"
  }
}

#Security group for load balancers
resource "aws_security_group" "lb_sg" {
  name        = "lb-server"
  description = "Allow connection for load balancers."
  vpc_id      = data.aws_vpc.vpc_group3.id

  ingress {
    description = "Allow port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "lb-server"
  }
}

#Security group for Bastio Host server
resource "aws_security_group" "bastion_host_server_sg" {
  name        = "bastion-host-server"
  description = "Allow connection for bastion host server."
  vpc_id      = data.aws_vpc.vpc_group3.id

  ingress {
    description = "Allow port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "bastion-host-server"
  }
}