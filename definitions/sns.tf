resource "aws_sns_topic" "jhenrycode-image-added"{
    name = "jhenrycode-image-added"

    policy = <<POLICY
    {
        "Version": "2008-10-17",
        "Id": "__default_policy_ID",
        "Statement": [
            {
            "Sid": "__default_statement_ID",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": [
                "SNS:GetTopicAttributes",
                "SNS:SetTopicAttributes",
                "SNS:AddPermission",
                "SNS:RemovePermission",
                "SNS:DeleteTopic",
                "SNS:Subscribe",
                "SNS:ListSubscriptionsByTopic",
                "SNS:Publish",
                "SNS:Receive"
            ],
            "Resource": "arn:aws:sns:us-east-1:319304591743:jhenrycode-image-added",
            "Condition": {
                "StringEquals": {
                "aws:SourceArn": "${aws_s3_bucket.jhenrycode-image-bucket.arn}"
                }
            }
            }
        ]
    }
    POLICY
}