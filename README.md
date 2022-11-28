# Google-Cloud-Functions-using-Terraform
In this project, I will show how to create Google Cloud Functions including gen1 and gen2 using Terraform. Before we start, I would highly suggest you to go through same steps specifically create google cloud functions with both generations using Google Cloud Console. 
Refer to my videos about how to create Google Cloud Functions using both Google Cloud Console and Terraform on Youtube.

* [Google Cloud Console](https://youtu.be/Pr_sNHmoi8E)
* [Terraform]()

## Getting started with VS Code

1. Create folder called cloud_functions and paste it in your VS Code Editor.
2. Inside your folder create two files main.tf, provider.tf
3. In your provider.tf specify Google Provider and enter following arguments

* provider.tf
  * project
  * region
  * zone 
  * credentials

4. Upload your keys.json from your service account and paste it into your cloud_functions folder.  

## Start working with Main.tf

* Step 1: Create [google_storage_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) by specifying following arguments:

  * name 
  * location

Before you upload object into your google cloud storage bucket, first run:

```
terraform init
terraform validate
terraform plan
terraform apply
```

* Step 2: Now upload index.zip object into your [google_storage_bucket_object](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) by specifying following arguments and run terraform apply:

  * name 
  * bucket
  * source

* Step 3: Start creating your Cloud Function Gen 1 [google_cloudfunctions_function](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function#argument-reference) by specifying following arguments:

  * name 
  * runtime
  * description
  * available_memory_mb
  * source_archive_bucket
  * source_archive_object
  * trigger_http
  * entry_point

* Step 4: Before you run terraform apply also allow public access for gen 1 with [google_cloudfunctions_function_iam_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function_iam) by specifying following arguments:

  * region 
  * cloud_function
  * role
  * member


* Step 5: Start creating your Cloud Function gen 2  [google_cloudfunctions2_function](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function) by specifying following arguments:

  * name 
  * location
  * description
  * build_config
  * service_config

* Step 6: Allow unauthenticated invocations for your Cloud Function gen 2 with [google_cloud_run_service_iam_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam) resource block by specifying following arguments:

  * location
  * service
  * role
  * members

Run terraform apply and check your output in your Google Cloud Platform account. 
  
# Congratulations 

Make sure to check out my videos on YouTube if you confuse or did not understand the steps.

* [Google Cloud Console](https://youtu.be/Pr_sNHmoi8E)
* [Terraform]()
