variable "orchestrator_name" {
  description = "Name of the orchestrator"
  type        = string
}

variable "allowed_ports" {
  description = "Ports allowed to access"
  type        = list(number)
  default     = [22]
}

variable "allowed_source_addresses" {
  description = "Source address allowed to access"
  type        = list(string)
  default     = ["10.0", "10.112", "103.82.14.237"]
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
}

variable "allowed_public_key" {
  description = "Public key allowed to access"
  type        = string
}

variable "internal_subnet_id" {
  description = "ID of the internal subnet"
  type        = string
}

variable "external_subnet_id" {
  description = "ID of the external subnet"
  type        = string
}
