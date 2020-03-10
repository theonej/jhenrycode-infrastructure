resource "aws_s3_bucket" "jhenrycode-image-bucket" {
    bucket = "jhenrycode-images"
}

resource "aws_s3_bucket_notification" "image-added-notification"{
    bucket = aws_s3_bucket.jhenrycode-image-bucket.id

    topic{
        topic_arn = aws_sns_topic.jhenrycode-image-added.arn
        events = ["s3:ObjectCreated:*"]
        filter_suffix = ".jpg"
    }
}
