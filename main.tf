
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