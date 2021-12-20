variable "create_namespace" {
  description = "to create the namespace or not"
  type        = bool
  default     = false
}

variable "namespace" {
  type        = string
  default     = "jenkins"
}


variable "nodePort" {
  type        = number
}
