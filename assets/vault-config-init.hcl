auto_auth = {
  method = {
    type = "kubernetes"
    config = {
      role = "grafana-deployment"
    }
  }
}

sink = {
  type = "file"
  config = {
    path = "/home/vault/.token"
  }
}

exit_after_auth = true
pid_file = "/home/vault/.pid"

template = {
  create_dest_dirs = true
  destination = "/vault/users/admin/username"
  contents = <<-EOF
  {{- with secret "secrets/grafana/users/admin" -}}
  {{ .Data.username }}
  {{- end }}
  EOF
}

template = {
  destination = "/vault/users/admin/password"
  contents = <<-EOF
  {{- with secret "secrets/grafana/users/admin" -}}
  {{ .Data.password }}
  {{- end }}
  EOF
}

vault = {
  ca_cert = "/vault/tls/tls.crt"
}
