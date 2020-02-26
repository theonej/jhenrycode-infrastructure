resource "aws_security_group" "jhenrycode-vision" {
    name = "jhenrycode-vision"

    vpc_id = aws_vpc.jhenrycode-vision.id

    ingress {
        protocol = "tcp"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol = "tcp"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "security_group_id" {
    value = aws_security_group.jhenrycode-vision.id
}