resource "aws_launch_configuration" "asg_launch_blue" {
  name_prefix     = "asg-launch-blue"
  image_id        = data.aws_ami.ubuntu_blue.id
  instance_type   = "t3.small"
  user_data       = <<EOF
    #!/bin/bash
    sudo service nginx start
    sudo systemctl enable nginx.service
    EOF
  security_groups = [aws_security_group.lb_sg.id, aws_security_group.bastion_host_server_sg.id]
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
  security_groups = [aws_security_group.lb_sg.id, aws_security_group.bastion_host_server_sg.id]
  key_name        = "bastion_host_key"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
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
  launch_configuration = aws_launch_configuration.asg_launch_blue.name
  vpc_zone_identifier  = [data.aws_subnet.private_a.id]
}

#autoscaling group - green
resource "aws_autoscaling_group" "green_asg" {
  min_size             = 0
  max_size             = 2
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.asg_launch_green.name
  vpc_zone_identifier  = [data.aws_subnet.private_b.id]
}