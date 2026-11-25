#!/usr/bin/env bash
set -euo pipefail

ONIONOO_URL="https://onionoo.torproject.org/details"
OUT_DIR="" # Empty means repository root

# Only run mkdir if OUT_DIR is explicitly defined and not empty
if [ -n "$OUT_DIR" ]; then
  mkdir -p "$OUT_DIR"
  PREFIX="$OUT_DIR/"
else
  PREFIX=""
fi

echo "[*] Downloading Onionoo details..."
curl -sL "$ONIONOO_URL" | tee >(gzip -9 > "${PREFIX}onionoo_details.json.gz") > onionoo_raw.json

echo "[*] Parsing running nodes..."

jq -r '
  .relays[] | select(.running == true) |
  (.flags | index("Exit") != null) as $is_exit |
  ((.or_addresses // []) + (if $is_exit then (.exit_addresses // []) else [] end))[] as $addr |
  ($addr | sub("^\\["; "") | sub("]:[0-9]+$"; "") | sub(":[0-9]+$"; "")) as $ip |
  if ($ip | contains(".")) then
    "v4 \($is_exit) \($ip)"
  elif ($ip | contains(":")) then
    "v6 \($is_exit) \($ip)"
  else
    empty
  end
' onionoo_raw.json > parsed_ips.tmp

rm -f onionoo_raw.json

# Sort and write lists
awk '$1=="v4" {print $3}' parsed_ips.tmp | sort -u > "${PREFIX}relays_v4.txt"
awk '$1=="v4" && $2=="true" {print $3}' parsed_ips.tmp | sort -u > "${PREFIX}exits_v4.txt"

awk '$1=="v6" {print $3}' parsed_ips.tmp | sort -u > "${PREFIX}relays_v6.txt"
awk '$1=="v6" && $2=="true" {print $3}' parsed_ips.tmp | sort -u > "${PREFIX}exits_v6.txt"

sort -u "${PREFIX}relays_v4.txt" "${PREFIX}relays_v6.txt" > "${PREFIX}relays.txt"
sort -u "${PREFIX}exits_v4.txt" "${PREFIX}exits_v6.txt" > "${PREFIX}exits.txt"

rm -f parsed_ips.tmp

echo "[*] Generating README.md stats..."

COUNT_RELAYS=$(wc -l < "${PREFIX}relays.txt" | tr -d ' ')
COUNT_RELAYS_V4=$(wc -l < "${PREFIX}relays_v4.txt" | tr -d ' ')
COUNT_RELAYS_V6=$(wc -l < "${PREFIX}relays_v6.txt" | tr -d ' ')
COUNT_EXITS=$(wc -l < "${PREFIX}exits.txt" | tr -d ' ')
COUNT_EXITS_V4=$(wc -l < "${PREFIX}exits_v4.txt" | tr -d ' ')
COUNT_EXITS_V6=$(wc -l < "${PREFIX}exits_v6.txt" | tr -d ' ')

GZ_SIZE_HR=$(du -h "${PREFIX}onionoo_details.json.gz" | awk '{print $1}')
GZ_SIZE_BYTES=$(wc -c < "${PREFIX}onionoo_details.json.gz" | tr -d ' ')
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")

cat << EOF > "${PREFIX}README.md"
# Tor Relay & Exit Node Lists

Automatically generated and updated list of online Tor network relay and exit node IP addresses parsed directly from the official [Tor Onionoo API](https://onionoo.torproject.org/).

* **Last Updated:** $TIMESTAMP
* **Raw Archive Size:** $GZ_SIZE_HR (\`$GZ_SIZE_BYTES\` bytes)

## 📊 Node Statistics

| Filename | Description | IP Protocol | Unique IP Count |
| :--- | :--- | :--- | :--- |
| \`relays.txt\` | All online Tor relays | IPv4 & IPv6 | \`$COUNT_RELAYS\` |
| \`relays_v4.txt\` | Online relays (IPv4 only) | IPv4 | \`$COUNT_RELAYS_V4\` |
| \`relays_v6.txt\` | Online relays (IPv6 only) | IPv6 | \`$COUNT_RELAYS_V6\` |
| \`exits.txt\` | All online Tor exit nodes | IPv4 & IPv6 | \`$COUNT_EXITS\` |
| \`exits_v4.txt\` | Online exit nodes (IPv4 only) | IPv4 | \`$COUNT_EXITS_V4\` |
| \`exits_v6.txt\` | Online exit nodes (IPv6 only) | IPv6 | \`$COUNT_EXITS_V6\` |
| \`onionoo_details.json.gz\` | Full compressed raw Onionoo payload | JSON / Gzip (Level 9) | N/A |

## 🛠️ Usage Example

\`\`\`bash
grep -Fxq "192.0.2.1" exits.txt && echo "Matched Tor Exit!"
\`\`\`
EOF

echo "[+] Success! Files and README.md generated in repository root."
