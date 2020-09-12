resource "kafka_topic" "logs" {
  name               = "systemd_logs"
  replication_factor = 3
  partitions         = 12

  config = {
    "segment.ms"     = "20000"
    "cleanup.policy" = "compact"
  }
}