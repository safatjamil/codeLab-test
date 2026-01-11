terraform {
  backend "s3" {
    region       = "us-east-1"
    bucket       = "bucket"
    encrypt      = true
    use_lockfile = true 
  }
}