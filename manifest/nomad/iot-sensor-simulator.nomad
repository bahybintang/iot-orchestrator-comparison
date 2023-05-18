job "iot-sensor-simulator" {
  datacenters = ["dc1"]

  constraint {
    attribute = "${attr.unique.hostname}"
    value     = "edge"
  }

  group "iot-sensor-simulator" {
    network {
      port "http" {
        static = 9393
      }
    }

    task "iot-sensor-simulator" {
      driver = "containerd-driver"

      config {
        image = "bintangbahy/iot-sensor-simulator:latest"
      }

      env {
        MOSCA_BROKER = "mosquitto"
      }

    }
  }
}
