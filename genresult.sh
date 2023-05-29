# Memory
cat RESULTS.md | grep "Mem:" | sed -n '1,9p' - | awk '{print $3}' | xargs -I {} bash -c 'echo {} |  python3 -c "import math; x = float(input()); print(math.ceil(x * 1.04858), \"MB\")"'

# Storage
cat RESULTS.md | grep "/dev/" | sed -n '1,9p' - | awk '{print $3}' | xargs -I {} bash -c 'echo {} |  python3 -c "import math; x = float(input()); print(math.ceil(x / 1000), \"MB\")"'