#########################################
# CAM policy
#########################################
module "cam_policy" {
  source      = "../../modules/cam-policy"
  name        = "bob-tf-policy"
  description = "My example policy"

  policy = <<EOF
{
  "Version": "2.0",
  "Statement": [
    {
      "Action": [
        "cvm:Describe*"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    }
  ]
}
EOF

}


module "iam_policy_optional" {
  source = "../../modules/cam-policy"

  create_policy = false
}
