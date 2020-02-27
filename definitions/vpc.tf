data "aws_availability_zones" "available" {

}

resource "aws_vpc" "jhenrycode-vision" {
    cidr_block = "10.0.0.0/16"

    enable_dns_support = true
    enable_dns_hostnames = true
}

resource "aws_subnet" "public" {
    count = var.az_count
    cidr_block = cidrsubnet(aws_vpc.jhenrycode-vision.cidr_block, 8, count.index)
    vpc_id = aws_vpc.jhenrycode-vision.id
    availability_zone = data.aws_availability_zones.available.names[count.index]

    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "jhenrycode-vision-igw"{
    vpc_id = aws_vpc.jhenrycode-vision.id
}

resource "aws_route" "internet_access" {
    route_table_id = aws_vpc.jhenrycode-vision.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jhenrycode-vision-igw.id
}

output "subnet_ids" {
    value = aws_subnet.public.*.id
}