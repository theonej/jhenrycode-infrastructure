[
    {
        "command": [

        ],
         "entryPoint": [

         ],
         "environment":[

         ],
         "essential": true,
         "image": "${account}.dkr.ecr.${region}.amazonaws.com/vision-ui:${tag}",
         "logConfiguration": {
             "logDriver": "awslogs",
             "options":{
                 "awslogs-group": "/${env}/vision-ui",
                 "awslogs-region": "${region}",
                 "awslogs-stream-prefix": "jhenrycode-vision" 
             }
         },
         "name": "vision-ui",
         "portMappings":[
             {
                 "containerPort":${app_port},
                 "hostPort": ${host_port},
                 "protocol": "tcp"
             }
         ]
    }
]