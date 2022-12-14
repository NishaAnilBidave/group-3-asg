data "aws_vpc" "vpc_group3" {
  filter {
    name   = "tag:Name"
    values = ["vpc_group3"]
  }
}

data "aws_subnet" "public_a" {
  filter {
    name   = "tag:Name"
    values = ["public_a"]
  }
}

data "aws_subnet" "public_b" {
  filter {
    name   = "tag:Name"
    values = ["public_b"]
  }
}

data "aws_subnet" "private_a" {
  filter {
    name   = "tag:Name"
    values = ["private_a"]
  }
}

data "aws_subnet" "private_b" {
  filter {
    name   = "tag:Name"
    values = ["private_b"]
  }
}

data "aws_ami" "ubuntu_blue" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["Blue_Ami-*"]
  }
}

data "aws_ami" "ubuntu_green" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["Green_Ami-*"]
  }
}

data "aws_ami" "bastion_host_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}