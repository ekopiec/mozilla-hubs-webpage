#Output URL where the website is hosted when finished.

output "website_URL" {
    value = "https://${var.subdomain}.${var.domain}"
    description = "URL of generated webpage"
}