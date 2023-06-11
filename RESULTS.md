# Overall Results

## Memory

### Master Node

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 277.874 MB | 741.346 MB    | 839.913 MB      |
| Nomad                       | 276.825 MB | 351.274 MB    | 442.501 MB      |
| KubeEdge                    | 282 MB     | 840 MB        |                 |

### Worker Node x86

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 277.874 MB | 354.42 MB     | 468.715 MB      |
| Nomad                       | 262.145 MB | 343.934 MB    | 517.999 MB      |
| KubeEdge                    | 263 MB     | 393 MB        |                 |

### Worker Node ARM

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 82.8378 MB | 130.024 MB    | 156.238 MB      |
| Nomad                       | 82.8378 MB | 118.49 MB     | 153.093 MB      |
| KubeEdge                    | 82 MB      | 131 MB        |                 |

## Storage

### Master Node

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 1522.37 MB | 2012.5 MB     | 2036.01 MB      |
| Nomad                       | 1520.67 MB | 2129.89 MB    | 2149.06 MB      |
| KubeEdge                    | 1523 MB    | 2394 MB       |                 |

### Worker Node x86

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 1520.65 MB | 1937.22 MB    | 2680.34 MB      |
| Nomad                       | 1520.89 MB | 2129.92 MB    | 2871.86 MB      |
| KubeEdge                    | 1523 MB    | 2543 MB       |                 |

### Worker Node ARM

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 1680.38 MB | 2426.93 MB    | 3315.94 MB      |
| Nomad                       | 1680.38 MB | 2589.79 MB    | 3478.1 MB       |
| KubeEdge                    | 2047 MB    | 2432 MB       |                 |