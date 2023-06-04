# Overall Results

## Memory

### Master Node

| Orchestrator/Testing Schema | Empty  | Fresh Install | With Deployment |
| --------------------------- | ------ | ------------- | --------------- |
| K3s                         | 242 MB | 754 MB        | 809 MB          |
| Nomad                       | 234 MB | 331 MB        | 434 MB          |
| KubeEdge                    | 282 MB | 840 MB        |                 |

### Worker Node x86

| Orchestrator/Testing Schema | Empty  | Fresh Install | With Deployment |
| --------------------------- | ------ | ------------- | --------------- |
| K3s                         | 248 MB | 311 MB        | 442 MB          |
| Nomad                       | 237 MB | 322 MB        | 473 MB          |
| KubeEdge                    | 263 MB | 393 MB        |                 |

### Worker Node ARM

| Orchestrator/Testing Schema | Empty | Fresh Install | With Deployment |
| --------------------------- | ----- | ------------- | --------------- |
| K3s                         | 70 MB | 111 MB        | 138 MB          |
| Nomad                       | 71 MB | 114 MB        | 156 MB          |
| KubeEdge                    | 82 MB | 131 MB        |                 |

## Storage

### Master Node

| Orchestrator/Testing Schema | Empty   | Fresh Install | With Deployment |
| --------------------------- | ------- | ------------- | --------------- |
| K3s                         | 1541 MB | 1989 MB       | 2010 MB         |
| Nomad                       | 1516 MB | 2087 MB       | 2116 MB         |
| KubeEdge                    | 1523 MB | 2394 MB       |                 |

### Worker Node x86

| Orchestrator/Testing Schema | Empty   | Fresh Install | With Deployment |
| --------------------------- | ------- | ------------- | --------------- |
| K3s                         | 1541 MB | 1913 MB       | 2675 MB         |
| Nomad                       | 1516 MB | 2086 MB       | 2828 MB         |
| KubeEdge                    | 1523 MB | 2543 MB       |                 |

### Worker Node ARM

| Orchestrator/Testing Schema | Empty   | Fresh Install | With Deployment |
| --------------------------- | ------- | ------------- | --------------- |
| K3s                         | 1681 MB | 2181 MB       | 4161 MB         |
| Nomad                       | 1681 MB | 2384 MB       | 3272 MB         |
| KubeEdge                    | 2047 MB | 2432 MB       |                 |