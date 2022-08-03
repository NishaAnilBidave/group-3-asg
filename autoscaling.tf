resource "aws_launch_configuration" "asg_launch" {
  name_prefix     = "asg-launch"
  image_id        = "ami-068257025f72f470d"
  instance_type   = "t3.small"
#   user_data       = file("user-data.sh")
  security_groups = [aws_security_group.server_sg.id]
  # total_local_storage_gb = 10

  lifecycle {
    create_before_destroy = true
  }
}

#autoscaling group - blue
resource "aws_autoscaling_group" "blue_asg" {
  min_size             = 2
  max_size             = 2
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.asg_launch.name
  availability_zones = ["ap-south-1a", "ap-south-1b"]
}

#autoscaling group - green
resource "aws_autoscaling_group" "green_asg" {
  min_size             = 2
  max_size             = 2
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.asg_launch.name
  availability_zones = ["ap-south-1a", "ap-south-1b"]
}