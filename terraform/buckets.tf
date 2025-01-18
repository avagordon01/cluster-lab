resource "google_storage_bucket" "md_storage" {
  name          = "ag-md-storage"
  uniform_bucket_level_access = true
  location      = "us-east1"
}
