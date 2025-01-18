resource "google_sql_database_instance" "postgres_pvp_instance_name" {
  name             = "postgres-pvp-instance-name"
  database_version = "POSTGRES_14"
  root_password    = "abcABC123!"
  settings {
    tier = "db-custom-1-3840"
  }
  deletion_protection = false
}

resource "google_sql_database" "database" {
  name     = "db"
  instance = google_sql_database_instance.postgres_pvp_instance_name.name
}
