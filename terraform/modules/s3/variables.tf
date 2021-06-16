variable "webpage_domain" {
  description = "domainname for webpage and bucket name"
  type = string
}

variable "webpage_index" {
  description = "default webpage file"
  type = string
  default = "index.html"
}

variable "webpage_index_content" {
  description = "Body of webpage_index"
  type = string
  default = "<html><body><h1>Hello World!</h1></body></html>"
}
  
