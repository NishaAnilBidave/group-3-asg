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

resource "aws_lb_target_group_attachment" "blue" {
  target_group_arn = aws_lb_target_group.blue.arn
  target_id        = aws_lb.group_3_lb.arn
  port             = 80
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

resource "aws_lb_target_group_attachment" "green" {
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = aws_lb.group_3_lb.arn
  port             = 80
}