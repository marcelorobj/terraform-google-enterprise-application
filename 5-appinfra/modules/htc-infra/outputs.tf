output "ui_config" {
  description = "Yaml configuration for UI deployment"
  value       = local.ui_config_file
}

output "test_scripts" {
  description = "Test configuration shell scripts"
  value       = module.gke.test_scripts_list
}
