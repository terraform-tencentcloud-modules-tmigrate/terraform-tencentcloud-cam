# SCF Namespace
resource "tencentcloud_cam_policy" "this" {
  count           = var.create_policy ? 1 : 0
  name            = var.name
  description     = var.description
  document        = var.policy
}
