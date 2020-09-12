provider "kafka" {
  bootstrap_servers = ["localhost:19092","localhost:29092","localhost:39092"]
  ca_cert = file("../secrets/snakeoil-ca-1.crt")
  client_cert_file = "../secrets/cert-signed-client-admin"
  client_key_file = "../secrets/admin.private.key"
  skip_tls_verify = true
  tls_enabled = true
}