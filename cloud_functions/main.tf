#Step1.google_storage_bucket
resource "google_storage_bucket" "terf_bucket_tff" {
  name     = "fun_bucket_tff"
  location = "us-central1"
}

#Step2.google_storage_bucket_object
resource "google_storage_bucket_object" "source_code" {
  name   = "objects"
  bucket = google_storage_bucket.terf_bucket_tff.name
  source = "index.zip"
}

#Step3.google_cloudfunctions_functions
resource "google_cloudfunctions_function" "fun_from_tff" {
  name        = "func_from_tff"
  runtime     = "nodejs16"
  description = "This is my first function from terraform script"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.terf_bucket_tff.name
  source_archive_object = google_storage_bucket_object.source_code.name

  trigger_http = true
  entry_point  = "helloWorld"
}

#Step4.google_cloudfunctions_functions_iam_member
resource "google_cloudfunctions_function_iam_member" "allow_access_tff" {
  region         = google_cloudfunctions_function.fun_from_tff.region
  cloud_function = google_cloudfunctions_function.fun_from_tff.name


  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

#Step5.google_cloudfunctions2_functions_function
resource "google_cloudfunctions2_function" "function" {
  name        = "function-v2"
  location    = "us-central1"
  description = "This is my second generation function from terraform script"

  build_config {
    runtime     = "nodejs16"
    entry_point = "helloWorld"
    environment_variables = {
      BUILD_CONFIG_TEST = "build_test"
    }
    source {
      storage_source {
        bucket = google_storage_bucket.terf_bucket_tff.name
        object = google_storage_bucket_object.source_code.name
      }
    }
  }
  service_config {
    min_instance_count             = 1
    max_instance_count             = 10
    available_memory               = "256M"
    timeout_seconds                = 60
    all_traffic_on_latest_revision = true
  }
}

#Step6.google_cloud_run_service_iam_binding
resource "google_cloud_run_service_iam_binding" "default" {
  location = google_cloudfunctions2_function.function.location
  service  = google_cloudfunctions2_function.function.name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}

