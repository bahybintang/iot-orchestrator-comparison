# Overall Results

## Memory

### Master Node

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 277.874 MB | 741.346 MB    | 839.913 MB      |
| Nomad                       | 234 MB     | 331 MB        | 434 MB          |
| KubeEdge                    | 282 MB     | 840 MB        |                 |
|                             |            |               |                 |

### Worker Node x86

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 277.874 MB | 354.42 MB     | 468.715 MB      |
| Nomad                       | 237 MB     | 322 MB        | 473 MB          |
| KubeEdge                    | 263 MB     | 393 MB        |                 |

### Worker Node ARM

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 82.8378 MB | 130.024 MB    | 156.238 MB      |
| Nomad                       | 71 MB      | 114 MB        | 156 MB          |
| KubeEdge                    | 82 MB      | 131 MB        |                 |

## Storage

### Master Node

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 1522.37 MB | 2012.5 MB     | 2036.01 MB      |
| Nomad                       | 1516 MB    | 2087 MB       | 2116 MB         |
| KubeEdge                    | 1523 MB    | 2394 MB       |                 |

### Worker Node x86

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 1520.65 MB | 1937.22 MB    | 2680.34 MB      |
| Nomad                       | 1516 MB    | 2086 MB       | 2828 MB         |
| KubeEdge                    | 1523 MB    | 2543 MB       |                 |

### Worker Node ARM

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 1680.38 MB | 2426.93 MB    | 3315.94 MB      |
| Nomad                       | 1681 MB    | 2384 MB       | 3272 MB         |
| KubeEdge                    | 2047 MB    | 2432 MB       |                 |