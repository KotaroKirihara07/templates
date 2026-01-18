# Configure the AWS Provider
provider "aws" {
    region = "ap-northeast-1"
    shared_config_files = ["~/.aws/config"]
    shared_credentials_files = ["~/.aws/credentials"]
    profile = "PROFILE_NAME"
}