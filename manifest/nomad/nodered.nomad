job "nodered" {
  datacenters = ["dc1"]

  constraint {
    attribute = "${attr.unique.hostname}"
    value     = "nomad-worker"
  }

  group "nodered" {
    network {
      port "http" {
        static = 1880
      }
    }

    task "nodered" {
      driver = "containerd-driver"

      config {
        image = "nodered/node-red:2.1.3"
      }

    }
  }
}
