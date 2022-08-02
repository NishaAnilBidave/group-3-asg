data "aws_vpc" "vpc_group3" {
  filter {
    name   = "tag:Name"
    values = ["vpc_group3"]
  }
}