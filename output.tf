output "ssh_cmd" {
  description = "The command to run to connect via SSH to the Compute instance via IAP"
    value       = "gcloud compute ssh --zone ${google_compute_instance.default.zone} ${google_compute_instance.default.name} --tunnel-through-iap --project ${var.project}"
}
output "tunnel_cmd" {
    description = "The command to run to connect to the Cloud SQL instance via IAP"
    value       = "gcloud compute start-iap-tunnel ${google_compute_instance.default.name} ${data.google_sql_database_instance.default.settings[0].ip_configuration[0].ipv4_enabled[0].port} --local-host-port=localhost:${data.google_sql_database_instance.default.settings[0].ip_configuration[0].ipv4_enabled[0].port} --zone=${google_compute_instance.default.zone}"
}
output "db_instance" {
    description = "The Cloud SQL instance name"
    value       = data.google_sql_database_instance.default
}