terraform {
  backend "s3" {
    bucket         = "talent-academy-pascal-lab-tfstates"
    key            = "talent-academy/asg_group3/terraform.tfstates"
    region         = "eu-west-1"
    dynamodb_table = "terraform-lock"
  }
}