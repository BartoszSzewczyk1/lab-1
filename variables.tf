variable "public_access" {
  type    = bool
  default = false
}

variable "tags-to-ignore" {
  type    = list(string)
  default = ["department"]
}

# homewaork 3

variable "cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_ip_on_launch" {
  type = bool
  default = false
}

variable "subnets" {
  type = list(string)
  default = [ 
    "10.0.1.0/24",
    "10.0.2.0/24" ]
}

variable "tags" {
  type = map(string)
  default = {
    "owner" = "awsninja12"
    "purpose" = "learning"
  }
}