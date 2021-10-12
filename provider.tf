# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/home/sarva/.aws/credentials"
  profile = "default"
}


