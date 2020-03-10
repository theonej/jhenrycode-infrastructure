resource "aws_elasticsearch_domain" "jhenrycode-vision-elastic"{
    domain_name = "jhenrycode-vision-elastic"
    elasticsearch_version = "6.7"

    cluster_config {
        instance_type = "t2.small.elasticsearch"
        instance_count = 1
    }

    ebs_options{
        ebs_enabled = true

        volume_type = "standard"
        volume_size = 10
    }

    access_policies = <<CONFIG
    {
        "Version" : "2012-10-17",
        "Statement" : [
            {
                "Action" : "es:*",
                "Principal" : "*",
                "Effect" : "Allow",
                "Resource" : "arn:aws:es:us-east-1:319304591743:domain/jhenrycode-vision-elastic/*"
            }
        ]
    }
    CONFIG
}