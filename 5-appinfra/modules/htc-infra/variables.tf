# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#-----------------------------------------------------
# Project and Regional Configuration
#-----------------------------------------------------
variable "regions" {
  description = "List of regions where GKE clusters should be created. Used for multi-region deployments."
  type        = list(string)
  default     = ["us-central1"]

  validation {
    condition     = length(var.regions) <= 4
    error_message = "Maximum 4 regions supported"
  }
}

#-----------------------------------------------------
# Deployment Options
#-----------------------------------------------------

variable "cloudrun_enabled" {
  description = "Enable Cloud Run deployment alongside GKE"
  type        = bool
  default     = false
}

variable "ui_image_enabled" {
  description = "Enable or disable the building of the UI image"
  type        = bool
  default     = false
}

#-----------------------------------------------------
# Output Configuration
#-----------------------------------------------------

variable "scripts_output" {
  description = "Output directory for testing scripts"
  type        = string
  default     = "./generated"
}

#-----------------------------------------------------
# PubSub Configuration
#-----------------------------------------------------

variable "pubsub_exactly_once" {
  description = "Enable Pub/Sub exactly once subscriptions"
  type        = bool
  default     = true
}

# variable "request_topic" {
#   description = "Request topic for tasks"
#   type        = string
#   default     = "request"
# }

# variable "request_subscription" {
#   description = "Request subscription for tasks"
#   type        = string
#   default     = "request_sub"
# }

# variable "response_topic" {
#   description = "Response topic for tasks"
#   type        = string
#   default     = "response"
# }

# variable "response_subscription" {
#   description = "Response subscription for tasks"
#   type        = string
#   default     = "response_sub"
# }

#-----------------------------------------------------
# BigQuery Configuration
#-----------------------------------------------------

# variable "dataset_id" {
#   description = "BigQuery dataset in the project to create the tables"
#   type        = string
#   default     = "pubsub_msgs"
# }

#-----------------------------------------------------
# Quota Configuration
#-----------------------------------------------------

variable "additional_quota_enabled" {
  description = "Enable quota requests for additional resources"
  type        = bool
  default     = false
}

variable "quota_contact_email" {
  description = "Contact email for quota requests"
  type        = string
  default     = ""
}

#-----------------------------------------------------
# GKE Cluster Configuration
#-----------------------------------------------------

variable "gke_standard_cluster_name" {
  description = "Base name for GKE clusters"
  type        = string
  default     = "gke-risk-research"
}

variable "node_machine_type_ondemand" {
  description = "Machine type for on-demand node pools"
  type        = string
  default     = "e2-standard-2"
}

variable "node_machine_type_spot" {
  description = "Machine type for spot node pools"
  type        = string
  default     = "e2-standard-2"
}

variable "min_nodes_ondemand" {
  description = "Minimum number of on-demand nodes"
  type        = number
  default     = 0
}

variable "max_nodes_ondemand" {
  description = "Maximum number of on-demand nodes"
  type        = number
  default     = 1
}

variable "min_nodes_spot" {
  description = "Minimum number of spot nodes"
  type        = number
  default     = 0
}

variable "max_nodes_spot" {
  description = "Maximum number of spot nodes"
  type        = number
  default     = 1
}

# variable "scaled_control_plane" {
#   description = "Deploy a larger initial nodepool to ensure larger control plane nodes are provisioned"
#   type        = bool
#   default     = false
# }

# variable "cluster_max_cpus" {
#   description = "Maximum CPU cores in cluster autoscaling resource limits"
#   type        = number
#   default     = 10000
# }

# variable "cluster_max_memory" {
#   description = "Maximum memory (in GB) in cluster autoscaling resource limits"
#   type        = number
#   default     = 80000
# }

#-----------------------------------------------------
# Storage Configuration
#-----------------------------------------------------

variable "storage_type" {
  description = "The type of storage system to deploy (PARALLELSTORE, LUSTRE, or null for none)"
  type        = string
  default     = null

  # validation {
  #   condition     = var.storage_type == null || contains(["PARALLELSTORE", "LUSTRE"], var.storage_type)
  #   error_message = "The storage_type must be null, PARALLELSTORE, or LUSTRE."
  # }
}

variable "storage_capacity_gib" {
  description = "Capacity in GiB for the selected storage system (Parallelstore or Lustre)"
  type        = number
  default     = null

  # validation {
  #   condition     = var.storage_capacity_gib > 0
  #   error_message = "Storage capacity must be a positive number or null."
  # }
}

variable "storage_locations" {
  description = "Map of region to location (zone) for storage instances e.g. {\"us-central1\" = \"us-central1-a\"}"
  type        = map(string)
  default     = {}
}

variable "deployment_type" {
  description = "Parallelstore Instance deployment type (SCRATCH or PERSISTENT)"
  type        = string
  default     = "SCRATCH"

  validation {
    condition     = contains(["SCRATCH", "PERSISTENT"], var.deployment_type)
    error_message = "deployment_type must be either SCRATCH or PERSISTENT."
  }
}

#-----------------------------------------------------
# Lustre Configuration
#-----------------------------------------------------

variable "lustre_filesystem" {
  description = "The name of the Lustre filesystem"
  type        = string
  default     = "lustre-fs"
}

variable "lustre_gke_support_enabled" {
  description = "Enable GKE support for Lustre instance"
  type        = bool
  default     = true
}

#-----------------------------------------------------
# Storage Options
#-----------------------------------------------------

variable "hsn_bucket" {
  description = "Enable hierarchical namespace GCS buckets"
  type        = bool
  default     = false
}

#-----------------------------------------------------
# Network Configuration
#-----------------------------------------------------

variable "storage_ip_range" {
  description = "IP range for Storage peering, in CIDR notation"
  type        = string
  default     = "172.16.0.0/16"
}

#-----------------------------------------------------
# Artifact Registry Configuration
#-----------------------------------------------------

variable "artifact_registry_name" {
  description = "Name of the Artifact Registry repository"
  type        = string
  default     = "research-images"
}

#-----------------------------------------------------
# Security Configuration
#-----------------------------------------------------

variable "enable_workload_identity" {
  description = "Enable Workload Identity for GKE clusters"
  type        = bool
  default     = true
}

#-----------------------------------------------------
# CSI Drivers Configuration
#-----------------------------------------------------

variable "enable_csi_parallelstore" {
  description = "Enable the Parallelstore CSI Driver"
  type        = bool
  default     = true
}

# variable "enable_csi_filestore" {
#   description = "Enable the Filestore CSI Driver"
#   type        = bool
#   default     = false
# }

variable "enable_csi_gcs_fuse" {
  description = "Enable the GCS Fuse CSI Driver"
  type        = bool
  default     = true
}

#-----------------------------------------------------
# VPC-SC
#-----------------------------------------------------

variable "service_perimeter_name" {
  description = "(VPC-SC) Service perimeter name. The created projects in this step will be assigned to this perimeter."
  type        = string
  default     = null
}

variable "service_perimeter_mode" {
  description = "(VPC-SC) Service perimeter mode: ENFORCE, DRY_RUN."
  type        = string
  default     = "DRY_RUN"

  validation {
    condition     = contains(["ENFORCE", "DRY_RUN"], var.service_perimeter_mode)
    error_message = "The service_perimeter_mode value must be one of: ENFORCE, DRY_RUN."
  }
}

variable "access_level_name" {
  description = "(VPC-SC) Access Level full name. When providing this variable, additional identities will be added to the access level, these are required to work within an enforced VPC-SC Perimeter."
  type        = string
  default     = null
}

variable "infra_project" {
  description = "The infrastructure project where resources will be managed."
  type        = string
}

variable "admin_project" {
  description = "The admin project where cloudbuild/cloudrun configurations will be managed."
  type        = string
}

variable "service_name" {
  type        = string
  description = "service name (e.g. 'transactionhistory')"
}

variable "region" {
  description = "The region where the cloud resources will be deployed."
  type        = string
}

variable "bucket_force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects. If false, Terraform will fail to delete buckets which contain objects."
  type        = bool
  default     = false
}

variable "workerpool_id" {
  description = <<-EOT
    Specifies the Cloud Build Worker Pool that will be utilized for triggers created in this step.

    The expected format is:
    `projects/PROJECT/locations/LOCATION/workerPools/POOL_NAME`.

    If you are using worker pools from a different project, ensure that you grant the
    `roles/cloudbuild.workerPoolUser` role on the workerpool project to the Cloud Build Service Agent and the Cloud Build Service Account of the trigger project:
    `service-PROJECT_NUMBER@gcp-sa-cloudbuild.iam.gserviceaccount.com`, `PROJECT_NUMBER@cloudbuild.gserviceaccount.com`
  EOT
  type        = string
  default     = ""
}

variable "logging_bucket" {
  description = "Bucket to store logging."
  type        = string
  default     = null
}

variable "bucket_kms_key" {
  description = "KMS Key id to be used to encrypt bucket."
  type        = string
  default     = null
}

variable "network_name" {
  description = "VPC Network Name"
  type        = string
}

variable "network_self_link" {
  description = "VPC Network self link"
  type        = string
}

variable "gke_cluster_names" {
  description = "GKE Cluster Name to be used in configurations"
  type        = list(string)
}

variable "gke_cluster_regions" {
  description = "GKE Cluster regions to be used in configurations"
  type        = list(string)
}

variable "parallelstore_deployment_type" {
  description = "Parallelstore Instance deployment type (SCRATCH or PERSISTENT)"
  type        = string
  default     = "SCRATCH"

  validation {
    condition     = contains(["SCRATCH", "PERSISTENT"], var.parallelstore_deployment_type)
    error_message = "deployment_type must be either SCRATCH or PERSISTENT"
  }
}

variable "network_project_id" {
  description = "VPC Network's project id"
  type        = string
}

variable "cloudbuild_sa" {
  description = "Admin project's cloud build service account"
  type        = string
}

variable "cluster_project_id" {
  type        = string
  description = "The GCP project ID where the cluster is created."
}

variable "cluster_project_number" {
  type        = string
  description = "The GCP project ID where the cluster is created."
}

variable "team" {
  description = "Environment Team, must be the same as the fleet scope team"
  type        = string
}

variable "env" {
  description = "The environment to prepare (ex. development)"
  type        = string
}