#TODO expose port all:22 for ssh, all:44321 for pmcd
#TODO expose port control:9090 for cockpit

provider "google" {
  project     = "cluster-lab-2"
  region      = "us-east1"
  zone        = "us-east1-c"
}
