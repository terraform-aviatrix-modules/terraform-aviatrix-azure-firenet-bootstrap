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
data "aws_iam_policy_document" "bootstrap_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "bootstrap" {
  name               = "bootstrap-${random_string.bucket.result}"
  assume_role_policy = data.aws_iam_policy_document.bootstrap_role.json
}

data "aws_iam_policy_document" "bootstrap_policy" {
  statement {
    actions = [
      "s3:List*",
      "s3:Get*",
    ]

    resources = [
      "${aws_s3_bucket.bootstrap.arn}",
    ]
  }
}

resource "aws_iam_policy" "bootstrap" {
  name   = "bootstrap-${random_string.bucket.result}"
  policy = data.aws_iam_policy_document.bootstrap_policy.json
}

resource "aws_iam_role_policy_attachment" "policy_role" {
  role       = aws_iam_role.bootstrap.name
  policy_arn = aws_iam_policy.bootstrap.arn
}

resource "aws_iam_instance_profile" "instance_role" {
  name = "bootstrap-${random_string.bucket.result}" #Needs to match the iam_role_name for the Aviatrix controller to pick it up.
  role = aws_iam_role.bootstrap.name
}
