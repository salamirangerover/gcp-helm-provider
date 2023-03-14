# resource "google_service_account" "main" {
#   account_id   = "${var.cluster_name}-sa"
#   display_name = "GKE Cluster ${var.cluster_name} Service Account"
# }

# resource "google_project_iam_binding" "project" {
#   for_each = toset([
#     "roles/logging.logWriter",
#     "roles/monitoring.metricWriter",
#     "roles/monitoring.viewer",
#     "roles/stackdriver.resourceMetadata.writer",
#     "roles/dns.admin"
#   ])

#   project = var.project_id
#   role    = each.key
#   members = [
#     "serviceAccount:${google_service_account.main.email}"
#   ]
# }


# resource "google_container_cluster" "main" {
#   name               = var.cluster_name
#   location           = var.location
#   initial_node_count = 3
#   node_config {
#     service_account = google_service_account.main.email
#     oauth_scopes = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]

#     disk_size_gb = 30
#   }
#   timeouts {
#     create = "30m"
#     update = "40m"
#   }
# }

# resource "time_sleep" "wait_30_seconds" {
#   depends_on      = [google_container_cluster.main]
#   create_duration = "30s"
# }

# module "gke_auth" {
#   depends_on           = [time_sleep.wait_30_seconds]
#   source               = "terraform-google-modules/kubernetes-engine/google//modules/auth"
#   project_id           = var.project_id
#   cluster_name         = google_container_cluster.main.name
#   location             = var.location
#   use_private_endpoint = false
# }
