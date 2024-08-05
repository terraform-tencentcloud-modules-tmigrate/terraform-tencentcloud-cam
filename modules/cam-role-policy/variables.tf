variable "roles" {
  type = any
  default = {}
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "ignored_policies" {
  type = list(string)
  default = []
}

variable "policies" {
  type = any
  default = {}
}