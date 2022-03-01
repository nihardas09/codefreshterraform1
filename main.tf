resource "google_service_account" "experiment3" {
  account_id   = "kubeservice1"
  display_name = "KubeClJob"
}

resource "google_container_cluster" "primary1" {
  name     = "my-gke-cluster1"
  location = "asia-south1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes1" {
  name       = "my-node-pool2"
  location   = "asia-south1"
  cluster    = google_container_cluster.primary1.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-micro"

   /* # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = "kubeservice1"
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]*/
  }
}