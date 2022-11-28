terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.44.1"
    }
  }
}

provider "google" {
  project     = "your project id"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = "your jeys.json from service account"
}

#Don't forget to provide these following roles in your service account

#Cloud Functions Admin
#Cloud Run Admin
#Service Account User
#Storage Admin