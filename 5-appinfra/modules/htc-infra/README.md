
# Load Test for HTC

## Overview

This is a general purpose gRPC load test.

See the details of running the program in its [src/README.md](src/README.md). See below for
deployment on Google Cloud.

## Deployment with Cloud Shell

The following link will walk you through a quick start in Cloud Shell:

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://shell.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fgooglecloudplatform%2Frisk-and-research-blueprints&cloudshell_git_branch=main&cloudshell_workspace=examples%2Frisk%2Floadtest&cloudshell_tutorial=QUICKSTART.md&show=terminal)

## Deploy with Terraform

### Requirements

You must have have the following installed:
* `gcloud` installed (see [installation](https://cloud.google.com/sdk/docs/install))
* `kubectl` installed (see [install tools](https://kubernetes.io/docs/tasks/tools/))
* A bash-based shell (Linux or Mac OS/X)

Note that Cloud Shell meets the requirements.

### Configuration

Create `terraform.tfvars` with the following content:
```
project_id="<project id>"
region="<region>"
zones=["<letter zone1>", "<letter zone2>", "<letter zone3>"]
```

For example in us-central1:
```
project_id="<project id>"
region="us-central1"
zones=["a", "b", "c", "f"]
```

For example in europe-west1:
```
project_id="<project id>"
region="europe-west1"
zones=["b", "c", "d"]
```

### Create infrastructure

Authorize `gcloud` if needed:
```sh
gcloud auth login  --quiet --update-adc
```

Update the `gcloud` project:

```bash
gcloud config set project YOUR_PROJECT_ID
```

You may need to enable some basic APIs for Terraform to work:
```sh
gcloud services enable iam.googleapis.com cloudresourcemanager.googleapis.com
```

Initialize and run terraform:
```sh
terraform init
terraform apply
```

NOTE: While running the terraform if the APIs are newly enabled, there may be
timing errors and terraform apply will need to be re-run.

## Seeing infrastructure & Running Test Workloads

### See what's from terraform

Inspect the possible run scripts:
```sh
terraform output
```

Key variable outputs:
 * local_test_scripts contain a list of shell scripts which you can run for different loadtests.
 * get_credentials is the command line to fetch the credentials for kubectl.
 * lookerstudio_create_dashboard_url is a link to create a new Lookerstudio Dashboard from a template.
 * monitoring_dashboard_url is a custom made monitoring dashboard for loadtest.

### Running the GUI

Create a virtual environment:
```sh
python3 -m venv ui/.venv
ui/.venv/bin/python3 -m pip install -r ui/requirements.txt
```

Run the Gradio dashboard:
```sh
ui/.venv/bin/python3 ui/main.py generated/config.yaml
```

Use port 8080 or preview 8080 in the Cloud Shell (Webpreview). This allows you to load
tests, inspect the jobs from BigQuery (similar to the dashboard), and has some deep
links into the Console.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_level\_name | (VPC-SC) Access Level full name. When providing this variable, additional identities will be added to the access level, these are required to work within an enforced VPC-SC Perimeter. | `string` | `null` | no |
| additional\_quota\_enabled | Enable quota requests for additional resources | `bool` | `false` | no |
| admin\_project | The admin project where cloudbuild/cloudrun configurations will be managed. | `string` | n/a | yes |
| artifact\_registry\_name | Name of the Artifact Registry repository | `string` | `"research-images"` | no |
| bucket\_force\_destroy | When deleting a bucket, this boolean option will delete all contained objects. If false, Terraform will fail to delete buckets which contain objects. | `bool` | `false` | no |
| bucket\_kms\_key | KMS Key id to be used to encrypt bucket. | `string` | `null` | no |
| cloudbuild\_sa | Admin project's cloud build service account | `string` | n/a | yes |
| cloudrun\_enabled | Enable Cloud Run deployment alongside GKE | `bool` | `false` | no |
| cluster\_project\_id | The GCP project ID where the cluster is created. | `string` | n/a | yes |
| cluster\_project\_number | The GCP project ID where the cluster is created. | `string` | n/a | yes |
| deployment\_type | Parallelstore Instance deployment type (SCRATCH or PERSISTENT) | `string` | `"SCRATCH"` | no |
| enable\_csi\_gcs\_fuse | Enable the GCS Fuse CSI Driver | `bool` | `true` | no |
| enable\_csi\_parallelstore | Enable the Parallelstore CSI Driver | `bool` | `true` | no |
| enable\_workload\_identity | Enable Workload Identity for GKE clusters | `bool` | `true` | no |
| env | The environment to prepare (ex. development) | `string` | n/a | yes |
| gke\_cluster\_names | GKE Cluster Name to be used in configurations | `list(string)` | n/a | yes |
| gke\_cluster\_regions | GKE Cluster regions to be used in configurations | `list(string)` | n/a | yes |
| gke\_standard\_cluster\_name | Base name for GKE clusters | `string` | `"gke-risk-research"` | no |
| hsn\_bucket | Enable hierarchical namespace GCS buckets | `bool` | `false` | no |
| infra\_project | The infrastructure project where resources will be managed. | `string` | n/a | yes |
| logging\_bucket | Bucket to store logging. | `string` | `null` | no |
| lustre\_filesystem | The name of the Lustre filesystem | `string` | `"lustre-fs"` | no |
| lustre\_gke\_support\_enabled | Enable GKE support for Lustre instance | `bool` | `true` | no |
| max\_nodes\_ondemand | Maximum number of on-demand nodes | `number` | `1` | no |
| max\_nodes\_spot | Maximum number of spot nodes | `number` | `1` | no |
| min\_nodes\_ondemand | Minimum number of on-demand nodes | `number` | `0` | no |
| min\_nodes\_spot | Minimum number of spot nodes | `number` | `0` | no |
| network\_name | VPC Network Name | `string` | n/a | yes |
| network\_project\_id | VPC Network's project id | `string` | n/a | yes |
| network\_self\_link | VPC Network self link | `string` | n/a | yes |
| node\_machine\_type\_ondemand | Machine type for on-demand node pools | `string` | `"e2-standard-2"` | no |
| node\_machine\_type\_spot | Machine type for spot node pools | `string` | `"e2-standard-2"` | no |
| parallelstore\_deployment\_type | Parallelstore Instance deployment type (SCRATCH or PERSISTENT) | `string` | `"SCRATCH"` | no |
| pubsub\_exactly\_once | Enable Pub/Sub exactly once subscriptions | `bool` | `true` | no |
| quota\_contact\_email | Contact email for quota requests | `string` | `""` | no |
| region | The region where the cloud resources will be deployed. | `string` | n/a | yes |
| regions | List of regions where GKE clusters should be created. Used for multi-region deployments. | `list(string)` | <pre>[<br>  "us-central1"<br>]</pre> | no |
| scripts\_output | Output directory for testing scripts | `string` | `"./generated"` | no |
| service\_name | service name (e.g. 'transactionhistory') | `string` | n/a | yes |
| service\_perimeter\_mode | (VPC-SC) Service perimeter mode: ENFORCE, DRY\_RUN. | `string` | `"DRY_RUN"` | no |
| service\_perimeter\_name | (VPC-SC) Service perimeter name. The created projects in this step will be assigned to this perimeter. | `string` | `null` | no |
| storage\_capacity\_gib | Capacity in GiB for the selected storage system (Parallelstore or Lustre) | `number` | `null` | no |
| storage\_ip\_range | IP range for Storage peering, in CIDR notation | `string` | `"172.16.0.0/16"` | no |
| storage\_locations | Map of region to location (zone) for storage instances e.g. {"us-central1" = "us-central1-a"} | `map(string)` | `{}` | no |
| storage\_type | The type of storage system to deploy (PARALLELSTORE, LUSTRE, or null for none) | `string` | `null` | no |
| team | Environment Team, must be the same as the fleet scope team | `string` | n/a | yes |
| ui\_image\_enabled | Enable or disable the building of the UI image | `bool` | `false` | no |
| workerpool\_id | Specifies the Cloud Build Worker Pool that will be utilized for triggers created in this step.<br><br>The expected format is:<br>`projects/PROJECT/locations/LOCATION/workerPools/POOL_NAME`.<br><br>If you are using worker pools from a different project, ensure that you grant the<br>`roles/cloudbuild.workerPoolUser` role on the workerpool project to the Cloud Build Service Agent and the Cloud Build Service Account of the trigger project:<br>`service-PROJECT_NUMBER@gcp-sa-cloudbuild.iam.gserviceaccount.com`, `PROJECT_NUMBER@cloudbuild.gserviceaccount.com` | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| test\_scripts | Test configuration shell scripts |
| ui\_config | Yaml configuration for UI deployment |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
