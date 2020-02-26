resource "aws_alb" "jhenrycode-vision" {
    name = "jhenrycode-vision"
    internal = false
    load_balancer_type = "application"
    subnets = aws_subnet.public.*.id
    security_groups = [aws_security_group.jhenrycode-vision.id]
    idle_timeout = 300
}

resource "aws_alb_target_group" "http" {
    name = "jhenrycode-vision-http-listener"
    port = var.vision_prediction_port
    protocol = "HTTP"
    vpc_id = aws_vpc.jhenrycode-vision.id
    target_type = "ip"

    health_check {
        healthy_threshold = "3"
        interval = "30"
        protocol = "HTTP"
        matcher = "200"
        timeout = "3"
        path = "/prediction/version"
        unhealthy_threshold = "2"
    }
}

resource "aws_alb_listener" "jhenrycode-vision" {
    load_balancer_arn = aws_alb.jhenrycode-vision.id
    port = var.vision_prediction_port
    protocol = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.http.id
        type = "forward"
    }
}

resource "aws_lb_listener_rule" "vision-prediction" {
    listener_arn = aws_alb_listener.jhenrycode-vision.arn

    priority = 100

    action {
        type = "forward"
        target_group_arn = aws_alb_target_group.http.arn
    }

    condition{
        path_pattern{
            values = ["/prediction*"]
        }
    }
}

output "target_group_arn" {
    value = aws_alb_target_group.http.arn
}
