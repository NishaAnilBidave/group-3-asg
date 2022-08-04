resource "aws_lb_target_group" "blue" {
  name     = "blue-tg-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.vpc_group3.id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_blue" {
  autoscaling_group_name = aws_autoscaling_group.blue_asg.id
  lb_target_group_arn    = aws_lb_target_group.blue.arn
}

# for green target group

resource "aws_lb_target_group" "green" {
  # name     = "green-tg-${random_pet.app.id}-lb"
  name     = "green-tg-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.vpc_group3.id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_green" {
  autoscaling_group_name = aws_autoscaling_group.green_asg.id
  lb_target_group_arn    = aws_lb_target_group.green.arn
}
