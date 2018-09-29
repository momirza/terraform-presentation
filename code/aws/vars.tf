variable "instance_port" {
    default = 8000
}

variable "container_port" {
    default = 8000
}

variable "image" {
    default = "momirza/cowsayer"
}

variable "health_check_path" {
    default = "health_check"
}

variable "image_version" {
    default = "0.1.0"
}

variable "instance_count" {
    default = 2
}

variable "domain_name" {
    default = "cowoca.com"
}

variable "instance_protocol" {
    default = "http"
}

variable "load_balancer_protocol" {
    default = "http"
}

variable "load_balancer_port" {
    default = {
        "http" = 80
        "https" = 443
    }
}