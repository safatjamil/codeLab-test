terraform {
  backend "s3" {
    bucket       = "bucket"
    encrypt      = true
    use_lockfile = true 
  }
}