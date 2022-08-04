<<<<<<< HEAD
resource "aws_launch_configuration" "asg_launch_blue" {
  name_prefix     = "asg-launch-blue"
  image_id        = data.aws_ami.ubuntu_blue.id
  instance_type   = "t3.small"
  user_data       = <<EOF
    #!/bin/bash
    sudo service nginx start
    sudo systemctl enable nginx.service
    EOF
  security_groups = [aws_security_group.server_sg.id]
  key_name        = "asg_key"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "asg_launch_green" {
  name_prefix     = "asg-launch-green"
  image_id        = data.aws_ami.ubuntu_green.id
  instance_type   = "t3.small"
  user_data       = <<EOF
    #!/bin/bash
    sudo service nginx start
    sudo systemctl enable nginx.service
    EOF
  security_groups = [aws_security_group.server_sg.id]
  key_name        = "bastion_host_key"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
=======
resource "aws_launch_configuration" "asg_launch" {
  name_prefix   = "asg-launch"
  image_id      = "ami-068257025f72f470d"
  instance_type = "t3.small"
  # user_data       = file("user_data.sh")
  security_groups = [aws_security_group.lb_sg.id, aws_security_group.bastion_host_server_sg.id]
  key_name        = "bastion_host_key"
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
>>>>>>> 16f82c1 (removed the comments)
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

#autoscaling group - blue
resource "aws_autoscaling_group" "blue_asg" {
  min_size             = 0
  max_size             = 2
  desired_capacity     = 2
<<<<<<< HEAD
  launch_configuration = aws_launch_configuration.asg_launch_blue.name
  vpc_zone_identifier  = [data.aws_subnet.private_a.id]
=======
  launch_configuration = aws_launch_configuration.asg_launch.name
  vpc_zone_identifier  = [data.aws_subnet.private_a.id, data.aws_subnet.private_b.id]
>>>>>>> 16f82c1 (removed the comments)
}

#autoscaling group - green
resource "aws_autoscaling_group" "green_asg" {
  min_size             = 0
  max_size             = 2
  desired_capacity     = 2
<<<<<<< HEAD
  launch_configuration = aws_launch_configuration.asg_launch_green.name
  vpc_zone_identifier  = [data.aws_subnet.private_b.id]
=======
  launch_configuration = aws_launch_configuration.asg_launch.name
  vpc_zone_identifier  = [data.aws_subnet.private_a.id, data.aws_subnet.private_b.id]

>>>>>>> 16f82c1 (removed the comments)
}