# Overall Results

## Memory

### Master Node

| Orchestrator/Testing Schema | Empty  | Fresh Install | With Deployment |
| --------------------------- | ------ | ------------- | --------------- |
| K3s                         | 242 MB | 754 MB        | 809 MB          |
| Nomad                       | 234 MB | 331 MB        | 434 MB          |
| KubeEdge                    |        |               |                 |

### Worker Node x64

| Orchestrator/Testing Schema | Empty  | Fresh Install | With Deployment |
| --------------------------- | ------ | ------------- | --------------- |
| K3s                         | 248 MB | 311 MB        | 442 MB          |
| Nomad                       | 237 MB | 322 MB        | 473 MB          |
| KubeEdge                    |        |               |                 |

### Worker Node ARM

| Orchestrator/Testing Schema | Empty | Fresh Install | With Deployment |
| --------------------------- | ----- | ------------- | --------------- |
| K3s                         | 70 MB | 111 MB        | 138 MB          |
| Nomad                       | 71 MB | 114 MB        | 156 MB          |
| KubeEdge                    |       |               |                 |

## Storage

### Master Node

| Orchestrator/Testing Schema | Empty   | Fresh Install | With Deployment |
| --------------------------- | ------- | ------------- | --------------- |
| K3s                         | 1541 MB | 1989 MB       | 2010 MB         |
| Nomad                       | 1516 MB | 2087 MB       | 2116 MB         |
| KubeEdge                    |         |               |                 |

### Worker Node x64

| Orchestrator/Testing Schema | Empty   | Fresh Install | With Deployment |
| --------------------------- | ------- | ------------- | --------------- |
| K3s                         | 1541 MB | 1913 MB       | 2675 MB         |
| Nomad                       | 1516 MB | 2086 MB       | 2828 MB         |
| KubeEdge                    |         |               |                 |

### Worker Node ARM

| Orchestrator/Testing Schema | Empty   | Fresh Install | With Deployment |
| --------------------------- | ------- | ------------- | --------------- |
| K3s                         | 1681 MB | 2181 MB       | 4161 MB         |
| Nomad                       | 1681 MB | 2384 MB       | 3272 MB         |
| KubeEdge                    |         |               |                 |

# K3s

## Empty

```bash
# Master
k3s@master:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         231        2803           3         386        2962
Swap:              0           0           0
k3s@master:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 1540956  28740836   6% /

# Worker x64
k3s@worker:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         237        2803           3         379        2956
Swap:              0           0           0
k3s@worker:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 1540928  28740864   6% /

# Worker ARM
edge@orangepione:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:             999          67         818           3         112         904
Swap:            499           0         499
edge@orangepione:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/mmcblk0p1  14899752 1680076  13043452  12% /
```

## Fresh

```bash
# Master
k3s@master:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         720        1812           4         888        2463
Swap:              0           0           0
k3s@master:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 1988432  28293360   7% /

# Worker x64
k3s@worker:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         297        2323           3         800        2887
Swap:              0           0           0
k3s@worker:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 1912212  28369580   7% /

# Worker ARM
edge@edge:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:             999         106         107           4         785         864
Swap:            499           0         499
edge@edge:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/mmcblk0p1  14899752 2180552  12542976  15% /
```

## With Deployment

```bash
# Master
k3s@master:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         772        1728           4         920        2409
Swap:              0           0           0
k3s@master:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 2009800  28271992   7% /

# Worker x64
k3s@worker:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         422        1363           4        1634        2745
Swap:              0           0           0
k3s@worker:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 2674148  27607644   9% /

# Worker ARM
edge@edge:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:             999         132          25           3         840         838
Swap:            499          12         486
edge@edge:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/mmcblk0p1  14899752 4160208  10563320  29% /
```

# Nomad

## Empty

```bash
# Server
nomad@nomad-master:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         223        2834           3         362        2971
Swap:              0           0           0
nomad@nomad-master:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 1515292  28766500   6% /

# Client x64
nomad@nomad-worker:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         226        2840           3         354        2968
Swap:              0           0           0
nomad@nomad-worker:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 1515292  28766500   6% /

# Client ARM
edge@orangepione:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:             999          67         818           3         112         904
Swap:            499           0         499
edge@orangepione:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/mmcblk0p1  14899752 1680076  13043452  12% /
```

## Fresh

```bash
# Server
nomad@nomad-master:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         315        2109           3         996        2868
Swap:              0           0           0
nomad@nomad-master:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 2086616  28195176   7% /

# Client x64
nomad@nomad-worker:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         307        2130           3         984        2875
Swap:              0           0           0
nomad@nomad-worker:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 2085660  28196132   7% /

# Client ARM
edge@edge:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:             999         108         355          10         534         848
Swap:            499           5         494
edge@edge:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/mmcblk0p1  14899752 2383348  12340180  17% /
```

## With Deployment

```bash
# Server
nomad@nomad-master:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         413        1967           3        1041        2768
Swap:              0           0           0
nomad@nomad-master:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 2115228  28166564   7% /

# Client x64
nomad@nomad-worker:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         451        1166           3        1802        2715
Swap:              0           0           0
nomad@nomad-worker:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 2827724  27454068  10% /

# Client ARM
edge@edge:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:             999         148         100           7         750         811
Swap:            499           8         490
edge@edge:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/mmcblk0p1  14899752 3271728  11451800  23% /
```
