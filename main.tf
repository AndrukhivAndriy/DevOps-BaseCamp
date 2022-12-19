provider "google" {

  credentials = file("mygcp-creds.json")
  project = "direct-builder-276316"
  region  = "europe-west3"
  zone    = "europe-west3-a"
}

resource "google_compute_instance" "web" { // create Instance with Apache + PHP
  name         = "webserver"
  machine_type = "f1-micro"

  tags = ["web", "http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  metadata_startup_script = file("apache2.sh")  // Shell script to install Mysql client, apache, php
  // Available by the link https://github.com/AndrukhivAndriy/DevOps-BaseCamp/blob/2944d4b8798fb9dc4afe7fe71b5e9386c1818d1c/apache2.sh

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  network_interface {
    network = "default"
    access_config {

    }

  }
}

resource "google_sql_database_instance" "mysql-from-terraform" {  // create database instance with public IP by default 
name = "my-database-instance"
database_version = "MYSQL_8_0"
region = "europe-west3"
settings {
tier = "db-f1-micro"
}
deletion_protection = "false"
}
resource "google_sql_database" "database-from-tf" {  // create database
name = "mydatabase"
instance = google_sql_database_instance.mysql-from-terraform.name
charset = "utf8"
collation = "utf8_general_ci"
}

// Not good solution via security, but it is described in official documentation
/*
resource "google_sql_user" "users" {
name = "root"
instance = "${google_sql_database_instance.mysql-from-terraform.name}"
host = "%"
password = "mypassw0rd"
}
*/
// Create user.DB via IAM

resource "google_sql_user" "iam_user_for_for_db" {
  name     = "markvanholsteijn@binx.io"
  instance = google_sql_database_instance.mysql-from-terraform.name
  type     = "CLOUD_IAM_USER"
}

resource "google_project_iam_member" "iam_user_cloudsql_instance_user" { // The IAM user requires the roles cloudsql.instanceUser and cloudsql.client to connect.
  role   = "roles/cloudsql.instanceUser"
  member = format("user:%s", google_sql_user.iam_user_for_for_db.name)
}

resource "google_project_iam_member" "iam_user_cloudsql_client" {
  role   = "roles/cloudsql.client"
  member = format("user:%s", google_sql_user.iam_user_for_for_db.name)
}
*/
