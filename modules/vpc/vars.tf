variable "availability_zones" {
  type        = list(any)
  description = "AWS Region Availability Zones"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnet_cidr_block" {
  type        = list(any)
  description = "Public Subnet CIDR Block"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidr_block" {
  type        = list(any)
  description = "Private Subnet CIDR Block"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
