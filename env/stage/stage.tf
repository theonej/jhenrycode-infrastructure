terraform {
    backend "s3" {
        bucket = "jhenrycode-vision"
        key = "stage_inf.tfstate"
        region = "us-east-1"
    }
}

provider "aws" {
    shared_credentials_file = "$HOME/.aws/credentials"
    profile = "default"
    region = "us-east-1"
}

module "jhenrycode-vision" {
    source = "../../definitions"
}

output "security_group_id" {
    value = module.jhenrycode-vision.security_group_id
}

output "subnet_ids" {
    value = module.jhenrycode-vision.subnet_ids
}

output "target_group_arn" {
    value = module.jhenrycode-vision.target_group_arn
}

output "ecs_cluster_id" {
    value = module.jhenrycode-vision.ecs_cluster_id
}