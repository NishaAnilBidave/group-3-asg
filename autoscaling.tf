resource "aws_launch_configuration" "asg_launch" {
  name_prefix     = "asg-launch"
  image_id        = "ami-068257025f72f470d"
  instance_type   = "t3.small"
  # user_data       = file("user_data.sh")
  security_groups = [aws_security_group.lb_sg.id, aws_security_group.bastion_host_server_sg.id]
  key_name = "bastion_host_key"
  # vpc_id          = data.aws_vpc.vpc_group3.id
  # total_local_storage_gb = 10

  lifecycle {
    create_before_destroy = true
  }
}

#autoscaling group - blue
resource "aws_autoscaling_group" "blue_asg" {
  min_size             = 0
  max_size             = 2
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.asg_launch.name
  vpc_zone_identifier = [data.aws_subnet.private_a.id, data.aws_subnet.private_b.id]
  # availability_zones = ["ap-south-1a", "ap-south-1b"]
}

#autoscaling group - green
resource "aws_autoscaling_group" "green_asg" {
  min_size             = 0
  max_size             = 2
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.asg_launch.name
  vpc_zone_identifier = [data.aws_subnet.private_a.id, data.aws_subnet.private_b.id]
  # availability_zones = ["ap-south-1a", "ap-south-1b"]
}