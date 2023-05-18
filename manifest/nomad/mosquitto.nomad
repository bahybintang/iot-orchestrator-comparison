job "mosquitto" {
  datacenters = ["dc1"]

  constraint {
    attribute = "${attr.unique.hostname}"
    value     = "nomad-master"
  }

  group "mosquitto" {
    network {
      port "mqtt" {
        static = 1883
      }
    }

    task "mosquitto" {
      driver = "containerd-driver"

      config {
        image = "eclipse-mosquitto:2.0.12"
      }

    }
  }
}
