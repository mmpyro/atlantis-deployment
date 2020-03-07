output "gke_name" {
  value = google_container_cluster.primary.name
}

output "gke_node_pool_name" {
  value = google_container_node_pool.primary_preemptible_nodes.name
}
