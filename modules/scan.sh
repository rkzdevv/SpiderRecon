#!/bin/bash

TARGET=$1
URL=$2
OUT=$3

echo "[+] Running scans..."

nmap -sV -Pn "$TARGET" -oN "$OUT/ports.txt" &
whatweb "$URL" > "$OUT/web.txt" &
gobuster dir -u "$URL" -w /usr/share/wordlists/dirb/common.txt -q -o "$OUT/dirs.txt" &
nikto -h "$URL" > "$OUT/vulns.txt" &

{
echo "=== DNS ==="
dig "$TARGET"
echo ""
echo "=== WHOIS ==="
whois "$TARGET"
} > "$OUT/dns.txt" &

curl -I "$URL" > "$OUT/headers.txt" 2>/dev/null &

wait

echo "[+] Scan finished"
