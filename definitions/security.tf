resource "aws_security_group" "jhenrycode-vision" {
    name = "jhenrycode-vision"

    vpc_id = aws_vpc.jhenrycode-vision.id

    ingress {
        protocol = "tcp"
        from_port = 9001
        to_port = 9001
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol = "tcp"
        from_port = 0
        to_port = 65535
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "jhenrycode-vision-elasticsearch" {
    name = "jhenrycode-vision-elasticsearch"

    vpc_id = aws_vpc.jhenrycode-vision.id

    ingress {
        protocol = "tcp"
        from_port = 443
        to_port = 443
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol = "tcp"
        from_port = 0
        to_port = 65535
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "security_group_id" {
    value = aws_security_group.jhenrycode-vision.id
}