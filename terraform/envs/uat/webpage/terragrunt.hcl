include {
  path = find_in_parent_folders()
}
terraform {
  source = "git::git@github.com:ekopiec/mozilla-hubs-webpage.git//terraform/modules/s3?ref=initial-tests"
}

inputs = {
  webpage_domain = "takehome.lizkopiec.com"
  webpage_index = "index.html"
}
