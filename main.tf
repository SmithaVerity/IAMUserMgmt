
terraform {
  # This module is now only being tested with Terraform 1.1.x. However, to make upgrading easier, we are setting 1.0.0 as the minimum version.
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "< 4.0"
    }
  }
}

# ------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ------------------------------------------------------------------------------

provider "aws" {
  region     = "ap-south-1"
  access_key = "your-access-key"
  secret_key = "your-secret-key"
}


variable "username" {
  type = list(string)
  default = ["CTPUser1","CMTSUser1"]
}

resource "aws_iam_user" "demo" {
  count = "${length(var.username)}"
  name = "${element(var.username,count.index )}"
}

resource "aws_iam_user_policy" "newemp_policy" {
	count = length(var.username)
	name = "new"
	user = element(var.username,count.index)
	policy = <<EOF
	{
	  "Version": "2012-10-17",
	  "Statement": [
		{
		  "Effect": "Allow",
		  "Action": [
			"ec2:Describe*"
		  ],
		  "Resource": "*"
		}
	  ]
	}
	EOF
}

output "user_arn" {
  value = aws_iam_user.demo.*.arn
}