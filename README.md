# Tor Relay & Exit Node Lists

Automatically generated and updated list of online and offline Tor network relay, exit, and non-exit node IP addresses parsed directly from the official [Tor Onionoo API](https://onionoo.torproject.org/).

- **Last Updated:** 2026-11-25 16:23:42 UTC
- **Raw Archive Size:** 40M (`41768975` bytes)

## 📊 Node Statistics

| Filename | Description | IP Protocol | Status | Unique IP Count |
| :--- | :--- | :--- | :--- | :--- |
| `relays.txt` | All online Tor relays | IPv4 & IPv6 | Online | `9338` |
| `relays_v4.txt` | Online relays (IPv4 only) | IPv4 | Online | `6977` |
| `relays_v6.txt` | Online relays (IPv6 only) | IPv6 | Online | `2361` |
| `exits.txt` | All online Tor exit nodes | IPv4 & IPv6 | Online | `1633` |
| `exits_v4.txt` | Online exit nodes (IPv4 only) | IPv4 | Online | `1245` |
| `exits_v6.txt` | Online exit nodes (IPv6 only) | IPv6 | Online | `388` |
| `non_exits.txt` | All online Tor non-exit relays | IPv4 & IPv6 | Online | `7810` |
| `non_exits_v4.txt` | Online non-exit relays (IPv4 only) | IPv4 | Online | `5825` |
| `non_exits_v6.txt` | Online non-exit relays (IPv6 only) | IPv6 | Online | `1985` |
| `offline_relays.txt` | All offline Tor relays | IPv4 & IPv6 | Offline | `1009` |
| `offline_relays_v4.txt` | Offline relays (IPv4 only) | IPv4 | Offline | `769` |
| `offline_relays_v6.txt` | Offline relays (IPv6 only) | IPv6 | Offline | `240` |
| `offline_exits.txt` | All offline Tor exit nodes | IPv4 & IPv6 | Offline | `221` |
| `offline_exits_v4.txt` | Offline exit nodes (IPv4 only) | IPv4 | Offline | `169` |
| `offline_exits_v6.txt` | Offline exit nodes (IPv6 only) | IPv6 | Offline | `52` |
| `offline_non_exits.txt` | All offline Tor non-exit relays | IPv4 & IPv6 | Offline | `790` |
| `offline_non_exits_v4.txt` | Offline non-exit relays (IPv4 only) | IPv4 | Offline | `601` |
| `offline_non_exits_v6.txt` | Offline non-exit relays (IPv6 only) | IPv6 | Offline | `189` |
| `onionoo_details.json.gz` | Full compressed raw Onionoo payload | JSON / Gzip (Level 9) | N/A | N/A |

## 🛠️ Usage Example

```bash
grep -Fxq "192.0.2.1" non_exits.txt && echo "Matched Tor Non-Exit Relay!"
```
