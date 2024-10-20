variable "projeto" {
  description = "Nome do projeto"
  type        = string
  default     = "VExpenses"
}

variable "candidato" {
  description = "Nome do candidato"
  type        = string
  default     = "william"
}

variable "subnet_id" {
  type = string
}

variable "sg_id" {
  type = string
}