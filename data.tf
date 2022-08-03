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