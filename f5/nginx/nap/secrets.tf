resource "kubernetes_secret" "docker-registry" {
    metadata {
        name = "regcred"
        namespace = kubernetes_namespace.nginx-ingress.metadata[0].name
    }
    
    type = "kubernetes.io/dockerconfigjson"

    data = {
        ".dockerconfigjson" = jsonencode({
            auths = {
                "${var.nginx_registry}" = {
                    "username" = var.nginx_jwt
                    "password" = var.nginx_pwd
                    "auth" = base64encode("${var.nginx_jwt}:${var.nginx_pwd}")
                }
            }
        })
    }
}
