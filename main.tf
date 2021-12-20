provider "kubernetes" {
    config_path    = "~/.kube/config"
    config_context = "kind-terraform-learn"
}


provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"
        config_context = "kind-terraform-learn"    
    }
}

module "jenkinsByHelm1" {
    source  = "./jenkins_helm"

    create_namespace = var.create_namespace
    namespace = "jenkins-1"
    nodePort         = 30201
}

module "jenkinsByHelm2" {
    source  = "./jenkins_helm"

    create_namespace = var.create_namespace
    namespace = "jenkins-2"
    nodePort         = 30202
}

# Manual style - configure k8 provider + creates Jenkins using custom modules

# provider "kubernetes" {
#     host = var.host

#     client_certificate     = base64decode(var.client_certificate)
#     client_key             = base64decode(var.client_key)
#     cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
# }

# module "jenkinsByTf" {
#     source  = "./jenkins_helm"

#     create_namespace = var.create_namespace
# }