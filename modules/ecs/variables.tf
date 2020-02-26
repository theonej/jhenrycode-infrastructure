variable "vision_prediction_port" {
    default = "9001"
}

variable "region" {
    default = "us-east-1"
}

variable "env" {
    default = "stage"
}

variable "account" {
    default = "319304591743"
}

variable "az_count" {
    default = 2
}

variable "vision_predictions_task_definition_path" {

}

variable "ecs_role_arn" {
     default ="arn:aws:iam::319304591743:role/jhenrycode-vision-ecs-role"
}

variable "vision_predictions_cpu" {
    default = "256"
}

variable "vision_predictions_memory" {
    default = "512"
}

variable "tag" {
    default = "local"
}

variable "security_group_id" {

}

variable "subnet_ids" {

}

variable "target_group_arn" {
    
}