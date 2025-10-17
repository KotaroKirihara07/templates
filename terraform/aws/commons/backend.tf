terraform {
    backend "s3" {
        bucket = "s3_bucket_name"
        key = "aaa/backend.tfstate"
        region = "ap-northeast-1"
        lock_file = true
    }
}