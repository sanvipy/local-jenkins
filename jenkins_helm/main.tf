
resource "kubernetes_namespace" "jenkins_namespace" {
  count = var.create_namespace ? 1 : 0
  metadata {
    annotations = {
      name = "jenkins"
    }

    labels = {
      managedby = "terraform"
    }

    name = var.namespace
  }
}


resource "helm_release" "jenkins" {
    name       = "jenkins"
    repository = "https://charts.jenkins.io"
    chart      = "jenkins"
    version    = "3.9.3"
    namespace  = var.namespace
    timeout    = 600
    values = [
    "${file("./jenkins_helm/values.yaml")}"
    ]


  set {
    name  = "controller.nodePort"
    value = var.nodePort
  }

}

