data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "aerkoc-tf-workshop-assignment-8"
    key    = "network.tfstate"
  }
}
