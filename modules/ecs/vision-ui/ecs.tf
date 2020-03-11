data "template_file" "vision-ui" {
    template = file("${path.module}/../../task-definitions/vision-ui.json.tpl")

    vars = {
        account = var.account
        region = var.region
        tag = var.tag
        log_region = var.region
        app_port = var.vision_ui_port
        host_port = var.vision_ui_port
        env = var.env
    }
}

resource "aws_ecs_task_definition" "vision-ui" {
    family = "jhenrycode-vision"
    execution_role_arn = var.ecs_role_arn
    network_mode = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu = var.vision_ui_cpu
    memory = var.vision_ui_memory
    container_definitions = data.template_file.vision-ui.rendered
}

resource "aws_ecs_service" "vision-ui" {
    name = "vision-ui"

    cluster = var.ecs_cluster_id
    task_definition = aws_ecs_task_definition.vision-ui.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
        security_groups = [var.security_group_id]
        subnets = var.subnet_ids
        assign_public_ip = true
    }

    load_balancer {
        target_group_arn = var.target_group_arn
        container_name = "vision-ui"
        container_port = var.vision_ui_port
    }

}