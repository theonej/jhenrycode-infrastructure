resource "aws_cloudwatch_log_group" "vision-predictions" {
    name = "${format("/%s/vision-predictions", var.env)}"

    retention_in_days = 3
}