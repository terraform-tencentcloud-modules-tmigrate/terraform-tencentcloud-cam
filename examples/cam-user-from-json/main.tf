module "cam_group_user_policy" {
  source = "../../modules/cam-group-user-policy"

  users = jsondecode(file("./users.json"))

}