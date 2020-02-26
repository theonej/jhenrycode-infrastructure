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

module "vision-predictions" {
    source = "../../modules/ecs"

    security_group_id = module.jhenrycode-vision.security_group_id
    subnet_ids = module.jhenrycode-vision.subnet_ids
    target_group_arn = module.jhenrycode-vision.target_group_arn
}