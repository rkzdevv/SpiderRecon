import json
import sys
import os

path = sys.argv[1] + "/ports.json"

if not os.path.exists(path):
    print("[!] No data")
    exit()

with open(path) as f:
    data = json.load(f)

print("\n[+] Intelligence Report\n")

for p in data["ports"]:
    port = p["port"]

    if port == "22":
        print("[!] SSH → brute force possible")
    elif port == "80":
        print("[!] HTTP → web attack surface")
    elif port == "443":
        print("[!] HTTPS → SSL check")
    elif port == "3306":
        print("[!] MySQL exposed ⚠️")
