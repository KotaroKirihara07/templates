# ----------------------------
# prefix
# ----------------------------

variable "prefix" {
    type = string
    description = "prefix"
    default = "test"
}


# ----------------------------
# CloudWatch
# ----------------------------

variable "retention_in_days" {
    type = int
    description = "retention in days"
    default = 365
}


