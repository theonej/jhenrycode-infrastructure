resource "aws_ecr_repository" "jhenrycode-vision" {
    name = "jhenrycode-vision"
}

resource "aws_ecr_lifecycle_policy" "jhenrycode-vision-policy"{
    repository = aws_ecr_repository.jhenrycode-vision.name

    policy = <<EOF
    {
        "rules": [
            {
                "rulePriority": 1,
                "selection":{
                    "tagStatus":"untagged",
                    "countType": "sinceImagePushed",
                    "countUnit": "days",
                    "countNumber": 14 
                },
                "action": {
                    "type": "expire"
                }
            }
        ]
    }
    EOF
}

