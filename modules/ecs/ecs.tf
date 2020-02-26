resource "aws_ecs_cluster" "jhenrycode-vision" {
    name = "jhenrycode-vision"
}

data "template_file" "vision-predictions" {
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

resource "aws_ecs_task_definition" "vision-predictions" {
    family = "jhenrycode-vision"
    execution_role_arn = var.ecs_role_arn
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu = var.vision_predictions_cpu
    memory = var.vision_predictions_memory
    container_definitions = data.template_file.vision-predictions.rendered
}

resource "aws_ecs_service" "vision-predictions" {
    name = "vision-predictions"

    cluster = aws_ecs_cluster.jhenrycode-vision.id
    task_definition = aws_ecs_task_definition.vision-predictions.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
        security_groups = [var.security_group_id]
        subnets = var.subnet_ids
        assign_public_ip = true
    }

    load_balancer {
        target_group_arn = var.target_group_arn
        container_name = "vision-predictions"
        container_port = var.vision_prediction_port
    }

}