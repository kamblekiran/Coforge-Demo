
output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.k8s.name
}

output "kubernetes_cluster_id" {
  value = azurerm_kubernetes_cluster.k8s.id
}

output "kubelet_object_id" {
  value = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
}