# Generic Input Variables
variable "rg_despligue_name" {
  type        = string
  description = "Geupo de recursos de Azure"
  default     = "RSG-ASERRANE"
}
# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "aserrane"
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}




