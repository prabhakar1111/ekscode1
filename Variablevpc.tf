variable "vpc-cidr"{
    default = "10.0.0.0/16"
    description = "vpc CIDR Block"
    type = string
}

#publicsb1

variable "publicsb1"{
    default = "10.0.1.0/24"
    description = "Public CIDR Block"
    type = string
}

#privatesb1

variable "publicsb1"{
    default = "10.0.2.0/24"
    description = "Private CIDR Block"
    type = string
}


