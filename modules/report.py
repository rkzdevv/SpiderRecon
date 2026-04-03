import json
import sys
import os

path = sys.argv[1]
json_file = os.path.join(path, "ports.json")
report_file = os.path.join(path, "report.md")

if not os.path.exists(json_file):
    exit()

with open(json_file) as f:
    data = json.load(f)

with open(report_file, "w") as f:
    f.write("# SpiderRecon Report\n\n")
    for p in data["ports"]:
        f.write(f"- {p['port']} ({p['service']})\n")

print("[+] Report generated")
