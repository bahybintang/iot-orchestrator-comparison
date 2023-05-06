# Empty
```bash
# Worker x64
k3s@worker:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         232        2904           3         283        2960
Swap:              0           0           0
k3s@worker:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 1543932  28737860   6% /
Swap:              0           0           0

# Master
k3s@master:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         232        2900           3         288        2962
Swap:              0           0           0
k3s@master:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 1553340  28728452   6% /
```

# K3s Fresh
```bash
# Master
k3s@master:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         895        1157           4        1368        2276
Swap:              0           0           0
k3s@master:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 2597872  27683920   9% /

# Worker x64
k3s@worker:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:            3421         278        2547           4         596        2910
Swap:              0           0           0
k3s@worker:~$ df /
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root       30298176 1838912  28442880   7% /
```