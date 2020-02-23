terraform{
    backend "s3" {
        bucket = "jhenrycode-vision"
        key = "stage_inf.tfstate"
        region = "us-east-1"
    }
}

provider "aws" {
    shared_credentials_file = "$HOME/.aws/credentials"
    profile                 = "default"
    region = "us-east-1"
}

module "jhenrycode-vision" {
    source = "../../definitions"

    vision_predictions_task_definition_path = "../../task-definitions/jhenrycode-vision.json.tpl"
}