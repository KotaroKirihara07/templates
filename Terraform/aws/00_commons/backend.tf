terraform {
    backend "s3" {
        bucket = "terraform-state-123456789012"
        key = "states/backend.tfstate"
        region = "ap-northeast-1"
        use_lockfile = true
    }
}