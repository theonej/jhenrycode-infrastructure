resource "aws_ecs_cluster" "jhenrycode-vision" {
    name = "jhenrycode-vision"
}

output "ecs_cluster_id" {
    value = aws_ecs_cluster.jhenrycode-vision.id
}
