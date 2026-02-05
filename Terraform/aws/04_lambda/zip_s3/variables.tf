# ----------------------------
# prefix
# ----------------------------

variable "prefix" {
  type        = string
  description = "prefix"
  default     = "test"
}


# ----------------------------
# Lambda関数
# ----------------------------

variable "function_name" {
  type        = string
  description = "function name"
  default     = "lambda_function"
}