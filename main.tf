variable "server-name" {
  type        = string
  default     = "kot"
  description = "Name of a server to provision"
}

locals {
  minNumberOfServer = 1
  maxNumberOfServer = 10
}

locals {
  countOfItems = {
    disks = 13
    servers = 22
    max = local.maxNumberOfServer + var.number-of-disks
    }
}

variable "number-of-servers" {
  type        = number
  description = "Required number of servers"
  default     = 2
  validation {
    condition     = var.number-of-servers >= local.minNumberOfServer && var.number-of-servers < local.maxNumberOfServer
    error_message = "Not supported number of server, it should be from the range [${local.minNumberOfServer}, ${local.maxNumberOfServer})"
  }
}

variable "number-of-disks" {
  type = number
}

variable "list-of-names" {
  type = list(string)
}

output "result" {
  value = "${var.number-of-servers} x ${var.number-of-servers}"
}

output "number-of-resources" {
  value = var.number-of-disks + var.number-of-servers
}

output "list-of-names" {
  value = "${join(", ", var.list-of-names)}"
}

output "key-from-map" {
  value = lookup(local.countOfItems, "max")
}




# Write a calculator

variable "a" {
  type = number
}

variable "b" {
  type = number
}

locals {
  calc = {
    "+" = var.a + var.b
    "-" = var.a - var.b
    "*" = var.a * var.b
    "/" = var.b != 0 ? var.a / var.b : "ERROR: Division by zero"
  }
}

# Allowed: +, -, *, /
variable "operand" {
  type = string
  validation {
    error_message = "Operand must be: + - * or /"
    condition = contains(["+", "-", "*", "/"], var.operand)
  }
}

output "result" {
  value = local.calc[var.operand]
}