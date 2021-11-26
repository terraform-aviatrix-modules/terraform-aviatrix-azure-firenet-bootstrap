#PANW Bootstrap config

#Random string for unique s3 bucket
resource "random_string" "bucket" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "bootstrap" {
  bucket = "panw-bootstrap-${random_string.bucket.result}"
  acl    = "private"
}

resource "aws_s3_bucket_object" "folder_config" {
  bucket = aws_s3_bucket.bootstrap.id
  acl    = "private"
  key    = "config/"
  source = "/dev/null"
}

resource "aws_s3_bucket_object" "folder_content" {
  bucket = aws_s3_bucket.bootstrap.id
  acl    = "private"
  key    = "content/"
  source = "/dev/null"
}

resource "aws_s3_bucket_object" "folder_license" {
  bucket = aws_s3_bucket.bootstrap.id
  acl    = "private"
  key    = "license/"
  source = "/dev/null"
}

resource "aws_s3_bucket_object" "folder_software" {
  bucket = aws_s3_bucket.bootstrap.id
  acl    = "private"
  key    = "software/"
  source = "/dev/null"
}

resource "aws_s3_bucket_object" "xml" {
  bucket = aws_s3_bucket.bootstrap.id
  key    = "config/bootstrap.xml"
  source = "bootstrap.xml"
}

resource "aws_s3_bucket_object" "init" {
  bucket = aws_s3_bucket.bootstrap.id
  key    = "config/init-cfg.txt"
  source = "init-cfg.txt"
}

#Create IAM role and policy for the FW instance to access the bucket.
resource "aws_iam_role" "bootstrap" {
  name               = "bootstrap"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "bootstrap" {
  name   = "bootstrap"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": [${aws_s3_bucket.bootstrap.arn}]
        }
    ]
}
EOF
}