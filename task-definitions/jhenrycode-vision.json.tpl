[
    {
        "command":[

        ],
        "entryPoint": [

        ],
        "environment":[

        ] ,
        "essential": true,
        "image": "${account}.dkr.ecr.${region}.amazonaws.com/vision-predictions:${tag}",
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "/${env}/vision-predictions",
                "awslogs-region": "${log_region}",
                "awslogs-stream-prefix": "jhenrycode-vision"
            }
        },
        "name": "vision-predictions",
        "portMappings": [
            {
                "containerPort": ${app_port},
                "hostPort": ${host_port},
                "protocol": "tcp"
            }
        ]
    }
]