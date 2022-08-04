resource "aws_lb" "group_3_lb" {
  name               = "group-3-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]

  enable_deletion_protection = true

  tags = {
    Environment = "group_3_lb"
  }
}

#load balancers listeners
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.group_3_lb.arn
  port              = "80"
  protocol          = "HTTP"

    default_action {
      type             = "forward"
      forward {
          target_group {
              arn = aws_lb_target_group.blue.arn
          }

          target_group {
              arn = aws_lb_target_group.green.arn
          }
      }
  }
}
