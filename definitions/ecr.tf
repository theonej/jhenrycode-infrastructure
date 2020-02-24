resource "aws_ecr_repository" "vision-predictions" {
    name = "vision-predictions"
}

resource "aws_ecr_lifecycle_policy" "vision-prediction-policy"{
    repository = aws_ecr_repository.vision-predictions.name

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

