include {
  path = find_in_parent_folders()
}
terraform {
  source = "git::git@github.com:ekopiec/mozilla-hubs-webpage.git//terraform/modules/s3-webpage?ref=v4"
}

inputs = {
  domain = "lizkopiec.com"
  subdomain = "takehome-uat"
}
