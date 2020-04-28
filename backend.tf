terraform {
  backend "s3" { # s3 must be created first
    bucket  = "tf-demo-bucket-kyle"
    key     = "terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
    # dynamodb_table = "my-lock-table"  # for state locking
  }
}
