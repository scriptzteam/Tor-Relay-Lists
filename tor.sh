#!/usr/bin/env bash
set -euo pipefail

ONIONOO_URL="https://onionoo.torproject.org/details"
OUT_DIR=""

if [ -n "$OUT_DIR" ]; then
  mkdir -p "$OUT_DIR"
  PREFIX="$OUT_DIR/"
else
  PREFIX=""
fi

STATS_MD="${PREFIX}STATS.md"

echo "[*] Downloading Onionoo details..."
curl -sL "$ONIONOO_URL" | tee >(gzip -9 > "${PREFIX}onionoo_details.json.gz") > onionoo_raw.json

echo "[*] Parsing running and offline nodes..."

jq -r '
  .relays[] | 
  (.running // false) as $running |
  (.flags | index("Exit") != null) as $is_exit |
  ((.or_addresses // []) + (if $is_exit then (.exit_addresses // []) else [] end))[] as $addr |
  ($addr | sub("^\\["; "") | sub("]:[0-9]+$"; "") | sub(":[0-9]+$"; "")) as $ip |
  if ($ip | contains(".")) then
    "v4 \($running) \($is_exit) \($ip)"
  elif ($ip | contains(":")) then
    "v6 \($running) \($is_exit) \($ip)"
  else
    empty
  end
' onionoo_raw.json > parsed_ips.tmp

rm -f onionoo_raw.json

# --- ONLINE LISTS ---
awk '$1=="v4" && $2=="true" {print $4}' parsed_ips.tmp | sort -u > "${PREFIX}relays_v4.txt"
awk '$1=="v4" && $2=="true" && $3=="true" {print $4}' parsed_ips.tmp | sort -u > "${PREFIX}exits_v4.txt"
awk '$1=="v4" && $2=="true" && $3=="false" {print $4}' parsed_ips.tmp | sort -u > "${PREFIX}non_exits_v4.txt"

awk '$1=="v6" && $2=="true" {print $4}' parsed_ips.tmp | sort -u > "${PREFIX}relays_v6.txt"
awk '$1=="v6" && $2=="true" && $3=="true" {print $4}' parsed_ips.tmp | sort -u > "${PREFIX}exits_v6.txt"
awk '$1=="v6" && $2=="true" && $3=="false" {print $4}' parsed_ips.tmp | sort -u > "${PREFIX}non_exits_v6.txt"

sort -u "${PREFIX}relays_v4.txt" "${PREFIX}relays_v6.txt" > "${PREFIX}relays.txt"
sort -u "${PREFIX}exits_v4.txt" "${PREFIX}exits_v6.txt" > "${PREFIX}exits.txt"
sort -u "${PREFIX}non_exits_v4.txt" "${PREFIX}non_exits_v6.txt" > "${PREFIX}non_exits.txt"

# --- OFFLINE LISTS ---
awk '$1=="v4" && $2=="false" {print $4}' parsed_ips.tmp | sort -u > "${PREFIX}offline_relays_v4.txt"
awk '$1=="v4" && $2=="false" && $3=="true" {print $4}' parsed_ips.tmp | sort -u > "${PREFIX}offline_exits_v4.txt"
awk '$1=="v4" && $2=="false" && $3=="false" {print $4}' parsed_ips.tmp | sort -u > "${PREFIX}offline_non_exits_v4.txt"

awk '$1=="v6" && $2=="false" {print $4}' parsed_ips.tmp | sort -u > "${PREFIX}offline_relays_v6.txt"
awk '$1=="v6" && $2=="false" && $3=="true" {print $4}' parsed_ips.tmp | sort -u > "${PREFIX}offline_exits_v6.txt"
awk '$1=="v6" && $2=="false" && $3=="false" {print $4}' parsed_ips.tmp | sort -u > "${PREFIX}offline_non_exits_v6.txt"

sort -u "${PREFIX}offline_relays_v4.txt" "${PREFIX}offline_relays_v6.txt" > "${PREFIX}offline_relays.txt"
sort -u "${PREFIX}offline_exits_v4.txt" "${PREFIX}offline_exits_v6.txt" > "${PREFIX}offline_exits.txt"
sort -u "${PREFIX}offline_non_exits_v4.txt" "${PREFIX}offline_non_exits_v6.txt" > "${PREFIX}offline_non_exits.txt"

rm -f parsed_ips.tmp

echo "[*] Generating README.md stats..."

# Counts: Online
COUNT_RELAYS=$(wc -l < "${PREFIX}relays.txt" | tr -d ' ')
COUNT_RELAYS_V4=$(wc -l < "${PREFIX}relays_v4.txt" | tr -d ' ')
COUNT_RELAYS_V6=$(wc -l < "${PREFIX}relays_v6.txt" | tr -d ' ')
COUNT_EXITS=$(wc -l < "${PREFIX}exits.txt" | tr -d ' ')
COUNT_EXITS_V4=$(wc -l < "${PREFIX}exits_v4.txt" | tr -d ' ')
COUNT_EXITS_V6=$(wc -l < "${PREFIX}exits_v6.txt" | tr -d ' ')
COUNT_NON_EXITS=$(wc -l < "${PREFIX}non_exits.txt" | tr -d ' ')
COUNT_NON_EXITS_V4=$(wc -l < "${PREFIX}non_exits_v4.txt" | tr -d ' ')
COUNT_NON_EXITS_V6=$(wc -l < "${PREFIX}non_exits_v6.txt" | tr -d ' ')

# Counts: Offline
COUNT_OFFLINE_RELAYS=$(wc -l < "${PREFIX}offline_relays.txt" | tr -d ' ')
COUNT_OFFLINE_RELAYS_V4=$(wc -l < "${PREFIX}offline_relays_v4.txt" | tr -d ' ')
COUNT_OFFLINE_RELAYS_V6=$(wc -l < "${PREFIX}offline_relays_v6.txt" | tr -d ' ')
COUNT_OFFLINE_EXITS=$(wc -l < "${PREFIX}offline_exits.txt" | tr -d ' ')
COUNT_OFFLINE_EXITS_V4=$(wc -l < "${PREFIX}offline_exits_v4.txt" | tr -d ' ')
COUNT_OFFLINE_EXITS_V6=$(wc -l < "${PREFIX}offline_exits_v6.txt" | tr -d ' ')
COUNT_OFFLINE_NON_EXITS=$(wc -l < "${PREFIX}offline_non_exits.txt" | tr -d ' ')
COUNT_OFFLINE_NON_EXITS_V4=$(wc -l < "${PREFIX}offline_non_exits_v4.txt" | tr -d ' ')
COUNT_OFFLINE_NON_EXITS_V6=$(wc -l < "${PREFIX}offline_non_exits_v6.txt" | tr -d ' ')

GZ_SIZE_HR=$(du -h "${PREFIX}onionoo_details.json.gz" | awk '{print $1}')
GZ_SIZE_BYTES=$(wc -c < "${PREFIX}onionoo_details.json.gz" | tr -d ' ')
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")

cat << EOF > "${PREFIX}README.md"
# Tor Relay & Exit Node Lists

Automatically generated and updated list of online and offline Tor network relay, exit, and non-exit node IP addresses parsed directly from the official [Tor Onionoo API](https://onionoo.torproject.org/).

- **Last Updated:** $TIMESTAMP
- **Raw Archive Size:** $GZ_SIZE_HR (\`$GZ_SIZE_BYTES\` bytes)

## 📊 Node Statistics

| Filename | Description | IP Protocol | Status | Unique IP Count |
| :--- | :--- | :--- | :--- | :--- |
| \`relays.txt\` | All online Tor relays | IPv4 & IPv6 | Online | \`$COUNT_RELAYS\` |
| \`relays_v4.txt\` | Online relays (IPv4 only) | IPv4 | Online | \`$COUNT_RELAYS_V4\` |
| \`relays_v6.txt\` | Online relays (IPv6 only) | IPv6 | Online | \`$COUNT_RELAYS_V6\` |
| \`exits.txt\` | All online Tor exit nodes | IPv4 & IPv6 | Online | \`$COUNT_EXITS\` |
| \`exits_v4.txt\` | Online exit nodes (IPv4 only) | IPv4 | Online | \`$COUNT_EXITS_V4\` |
| \`exits_v6.txt\` | Online exit nodes (IPv6 only) | IPv6 | Online | \`$COUNT_EXITS_V6\` |
| \`non_exits.txt\` | All online Tor non-exit relays | IPv4 & IPv6 | Online | \`$COUNT_NON_EXITS\` |
| \`non_exits_v4.txt\` | Online non-exit relays (IPv4 only) | IPv4 | Online | \`$COUNT_NON_EXITS_V4\` |
| \`non_exits_v6.txt\` | Online non-exit relays (IPv6 only) | IPv6 | Online | \`$COUNT_NON_EXITS_V6\` |
| \`offline_relays.txt\` | All offline Tor relays | IPv4 & IPv6 | Offline | \`$COUNT_OFFLINE_RELAYS\` |
| \`offline_relays_v4.txt\` | Offline relays (IPv4 only) | IPv4 | Offline | \`$COUNT_OFFLINE_RELAYS_V4\` |
| \`offline_relays_v6.txt\` | Offline relays (IPv6 only) | IPv6 | Offline | \`$COUNT_OFFLINE_RELAYS_V6\` |
| \`offline_exits.txt\` | All offline Tor exit nodes | IPv4 & IPv6 | Offline | \`$COUNT_OFFLINE_EXITS\` |
| \`offline_exits_v4.txt\` | Offline exit nodes (IPv4 only) | IPv4 | Offline | \`$COUNT_OFFLINE_EXITS_V4\` |
| \`offline_exits_v6.txt\` | Offline exit nodes (IPv6 only) | IPv6 | Offline | \`$COUNT_OFFLINE_EXITS_V6\` |
| \`offline_non_exits.txt\` | All offline Tor non-exit relays | IPv4 & IPv6 | Offline | \`$COUNT_OFFLINE_NON_EXITS\` |
| \`offline_non_exits_v4.txt\` | Offline non-exit relays (IPv4 only) | IPv4 | Offline | \`$COUNT_OFFLINE_NON_EXITS_V4\` |
| \`offline_non_exits_v6.txt\` | Offline non-exit relays (IPv6 only) | IPv6 | Offline | \`$COUNT_OFFLINE_NON_EXITS_V6\` |
| \`onionoo_details.json.gz\` | Full compressed raw Onionoo payload | JSON / Gzip (Level 9) | N/A | N/A |

## 🛠️ Usage Example

\`\`\`bash
grep -Fxq "192.0.2.1" non_exits.txt && echo "Matched Tor Non-Exit Relay!"
\`\`\`
EOF

# --- STATS.md ---
NEW_STAT_ROW="| $TIMESTAMP | $COUNT_RELAYS | $COUNT_RELAYS_V4 | $COUNT_RELAYS_V6 | $COUNT_EXITS | $COUNT_EXITS_V4 | $COUNT_EXITS_V6 | $COUNT_NON_EXITS | $COUNT_NON_EXITS_V4 | $COUNT_NON_EXITS_V6 | $COUNT_OFFLINE_RELAYS | $COUNT_OFFLINE_RELAYS_V4 | $COUNT_OFFLINE_RELAYS_V6 | $COUNT_OFFLINE_EXITS | $COUNT_OFFLINE_EXITS_V4 | $COUNT_OFFLINE_EXITS_V6 | $COUNT_OFFLINE_NON_EXITS | $COUNT_OFFLINE_NON_EXITS_V4 | $COUNT_OFFLINE_NON_EXITS_V6 |"

if [ ! -f "$STATS_MD" ]; then
  cat << EOF > "$STATS_MD"
# Historical Tor Network Statistics

Log of historical IP counts for all generated text lists recorded during every automated update cycle.

| Timestamp (UTC) | Relays | Relays v4 | Relays v6 | Exits | Exits v4 | Exits v6 | Non-Exits | Non-Exits v4 | Non-Exits v6 | Off Relays | Off Relays v4 | Off Relays v6 | Off Exits | Off Exits v4 | Off Exits v6 | Off Non-Exits | Off Non-Exits v4 | Off Non-Exits v6 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
$NEW_STAT_ROW
EOF
else
  awk -v new_row="$NEW_STAT_ROW" '
    /\| :---/ {
      print
      print new_row
      next
    }
    {print}
  ' "$STATS_MD" > stats_tmp.md && mv stats_tmp.md "$STATS_MD"
fi

echo "[+] Success! Non-exit lists, README.md, and STATS.md generated."
