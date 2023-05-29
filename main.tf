# ------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ------------------------------------------------------------------------------

provider "aws" {
  region     = "ap-south-1"
}

resource "aws_iam_user" "demo" {
  count = "${length(var.username)}"
  name = "${element(var.username,count.index )}"
}


output "user_arn" {
  value = aws_iam_user.demo.*.arn
}
