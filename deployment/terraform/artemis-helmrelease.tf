data "helm_repository" "stable" {
    name = "stable"
    url  = "https://github.com/fuchicorp/artemis/tree/feature-dev/deployment/terraform/artemis-deployment"
}

resource "helm_release" "artemis" {
  name       = "artemis-release"
  repository = "${file("./artemis-deployment/Chart.yaml")}"
  chart      = "artemis"
  version    = "0.1"

  values = [
    "${file("./artemis-deployment/values.yaml")}"
  ]

  set {
    name  = "cluster.enabled"
    value = "true"
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }

  set_string {
    name  = "service.annotations.artemis\\.io/port"
    value = "5000"
  }
}