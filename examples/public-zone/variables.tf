variable "domain" {
  description = "Zone domain."
  type        = string
  default     = "foo.example-invalid.org."
}

variable "labels" {
  type        = map(any)
  description = "A set of key/value label pairs to assign to this ManagedZone"
  default = {
    owner   = "foo"
    version = "bar"
  }
}