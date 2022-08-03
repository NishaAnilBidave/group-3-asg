resource "aws_lb" "group_3_lb" {
  name               = "group-3-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.server_sg.id]
  subnets            = [data.aws_subnet.public_a.id]
  vpc_id             = data.aws_vpc.vpc_group3.id

  enable_deletion_protection = true

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.bucket
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags = {
    Environment = "group_3_production"
  }
}

#load balancers listeners
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}