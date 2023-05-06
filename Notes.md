# K3s
## Empty
```bash
# Worker x64
k3s@worker:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         250        2785           3         385        2956
Swap:              0           0           0
k3s@worker:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 1543996  28737796   6% /

# Master
k3s@master:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         247        2790           3         383        2957
Swap:              0           0           0
k3s@master:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 1543988  28737804   6% /
```

## Fresh
```bash
# Master
k3s@master:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         706        1705           4        1009        2483
Swap:              0           0           0
k3s@master:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 2082776  28199016   7% /

# Worker x64
k3s@worker:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         290        2196           3         934        2903
Swap:              0           0           0
k3s@worker:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 2005676  28276116   7% /
```

## With Deployment
```bash
# Master
root@master:/home/k3s# free -m
               total        used        free      shared  buff/cache   available
Mem:            3421        1001        1030           4        1389        2169
Swap:              0           0           0
root@master:/home/k3s# df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 2602256  27679536   9% /

# Worker x64
k3s@worker:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         428        1562           4        1430        2742
Swap:              0           0           0
k3s@worker:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 2599932  27681860   9% /
```