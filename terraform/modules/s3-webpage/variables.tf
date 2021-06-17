variable "domain" {
  type = string
  description = "second level domain with TLD"
}

variable "subdomain" {
  type = string
  description = "subdomain without . or second level domain"
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
  
