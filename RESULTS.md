# Overall Results

## Memory

### Master Node

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 277.874 MB | 741.346 MB    | 839.913 MB      |
| Nomad                       | 276.825 MB | 351.274 MB    | 442.501 MB      |
| KubeEdge                    | 274.728 MB | 861.933 MB    | 897.584 MB      |

### Worker Node x86

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 277.874 MB | 354.42 MB     | 468.715 MB      |
| Nomad                       | 262.145 MB | 343.934 MB    | 517.999 MB      |
| KubeEdge                    | 253.756 MB | 427.821 MB    | 552.602 MB      |

### Worker Node ARM

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 82.8378 MB | 130.024 MB    | 156.238 MB      |
| Nomad                       | 82.8378 MB | 118.49 MB     | 153.093 MB      |
| KubeEdge                    | 82.8378 MB | 147.85 MB     | 162.53 MB       |

## Storage

### Master Node

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 1522.37 MB | 2012.5 MB     | 2036.01 MB      |
| Nomad                       | 1520.67 MB | 2129.89 MB    | 2149.06 MB      |
| KubeEdge                    | 1522.4 MB  | 2386.34 MB    | 2466.97 MB      |

### Worker Node x86

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 1520.65 MB | 1937.22 MB    | 2680.34 MB      |
| Nomad                       | 1520.89 MB | 2129.92 MB    | 2871.86 MB      |
| KubeEdge                    | 1521 MB    | 2349.01 MB    | 2992.58 MB      |

### Worker Node ARM

| Orchestrator/Testing Schema | Empty      | Fresh Install | With Deployment |
| --------------------------- | ---------- | ------------- | --------------- |
| K3s                         | 1680.38 MB | 2426.93 MB    | 3315.94 MB      |
| Nomad                       | 1680.38 MB | 2589.79 MB    | 3478.1 MB       |
| KubeEdge                    | 1680.66 MB | 2672.26 MB    | 3462.04 MB      |