
resource "aws_ecs_cluster" "jhenrycode-vision" {
    name = "jhenrycode-vision"
}

data "template_file" "jhenrycode-vision" {
    template = file(var.vision_predictions_task_definition_path)

    vars = {
        account = var.account
        region = var.region
        tag = var.tag
        log_region = var.region
        app_port = var.vision_prediction_port
        host_port = var.vision_prediction_port
        env = var.env
    }
}

resource "aws_ecs_task_definition" "jhenrycode-vision" {
    family = "jhenrycode-vision"
    execution_role_arn = var.ecs_role_arn
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu = var.vision_predictions_cpu
    memory = var.vision_predictions_memory
    container_definitions = data.template_file.jhenrycode-vision.rendered
}

resource "aws_ecs_service" "vision-predictions" {
    name = "vision-predictions"
    cluster = aws_ecs_cluster.jhenrycode-vision.id
    task_definition = aws_ecs_task_definition.jhenrycode-vision.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
        security_groups = [aws_security_group.jhenrycode-vision.id]
        subnets = aws_subnet.public.*.id
        assign_public_ip = true
    }

    load_balancer {
        target_group_arn = aws_alb_target_group.http.arn
        container_name = "vision-predictions"
        container_port = var.vision_prediction_port
    }

    depends_on =[
        "aws_alb_listener.jhenrycode-vision"
    ]
}