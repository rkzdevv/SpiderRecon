import os
import sys
import json
import re

target = sys.argv[1]
path = sys.argv[2]

ports_file = os.path.join(path, "ports.txt")

ports = []

if os.path.exists(ports_file):
    with open(ports_file) as f:
        for line in f:
            match = re.search(r"(\d+)/tcp\s+open\s+(\S+)", line)
            if match:
                ports.append({
                    "port": match.group(1),
                    "service": match.group(2)
                })

with open(os.path.join(path, "ports.json"), "w") as f:
    json.dump({"ports": ports}, f, indent=4)

print("[+] Parsed ports")
