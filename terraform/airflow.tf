resource "google_project_service" "composer_api" {
  service = "composer.googleapis.com"
  disable_on_destroy = false
}

resource "google_service_account" "custom_service_account" {
  account_id   = "custom-service-account"
  display_name = "Example Custom Service Account"
}

resource "google_project_iam_member" "custom_service_account" {
  project = "cluster-lab-2"
  member   = format("serviceAccount:%s", google_service_account.custom_service_account.email)
  // Role for Public IP environments
  role     = "roles/composer.worker"
}

data "google_project" "project" {}

resource "google_service_account_iam_member" "custom_service_account" {
  service_account_id = google_service_account.custom_service_account.name
  role = "roles/composer.ServiceAgentV2Ext"
  member = "serviceAccount:service-${data.google_project.project.number}@cloudcomposer-accounts.iam.gserviceaccount.com"
}

resource "google_composer_environment" "example_environment" {
  name = "example-environment"

  config {

    software_config {
      image_version = "composer-2.10.2-airflow-2.10.2"
      airflow_config_overrides = {
        // KEY = "VALUE"
      }
    }

    node_config {
      service_account = google_service_account.custom_service_account.email
    }

  }
}
