# Tor Relay & Exit Node Lists

Automatically generated and updated list of online and offline Tor network relay, exit, and non-exit node IP addresses parsed directly from the official [Tor Onionoo API](https://onionoo.torproject.org/).

- **Last Updated:** 2026-11-27 11:36:21 UTC
- **Raw Archive Size:** 34M (`34988760` bytes)

## 📊 Node Statistics

| Filename | Description | IP Protocol | Status | Unique IP Count |
| :--- | :--- | :--- | :--- | :--- |
| `relays.txt` | All online Tor relays | IPv4 & IPv6 | Online | `9428` |
| `relays_v4.txt` | Online relays (IPv4 only) | IPv4 | Online | `7091` |
| `relays_v6.txt` | Online relays (IPv6 only) | IPv6 | Online | `2337` |
| `exits.txt` | All online Tor exit nodes | IPv4 & IPv6 | Online | `1645` |
| `exits_v4.txt` | Online exit nodes (IPv4 only) | IPv4 | Online | `1254` |
| `exits_v6.txt` | Online exit nodes (IPv6 only) | IPv6 | Online | `391` |
| `non_exits.txt` | All online Tor non-exit relays | IPv4 & IPv6 | Online | `7888` |
| `non_exits_v4.txt` | Online non-exit relays (IPv4 only) | IPv4 | Online | `5930` |
| `non_exits_v6.txt` | Online non-exit relays (IPv6 only) | IPv6 | Online | `1958` |
| `offline_relays.txt` | All offline Tor relays | IPv4 & IPv6 | Offline | `900` |
| `offline_relays_v4.txt` | Offline relays (IPv4 only) | IPv4 | Offline | `651` |
| `offline_relays_v6.txt` | Offline relays (IPv6 only) | IPv6 | Offline | `249` |
| `offline_exits.txt` | All offline Tor exit nodes | IPv4 & IPv6 | Offline | `164` |
| `offline_exits_v4.txt` | Offline exit nodes (IPv4 only) | IPv4 | Offline | `120` |
| `offline_exits_v6.txt` | Offline exit nodes (IPv6 only) | IPv6 | Offline | `44` |
| `offline_non_exits.txt` | All offline Tor non-exit relays | IPv4 & IPv6 | Offline | `738` |
| `offline_non_exits_v4.txt` | Offline non-exit relays (IPv4 only) | IPv4 | Offline | `532` |
| `offline_non_exits_v6.txt` | Offline non-exit relays (IPv6 only) | IPv6 | Offline | `206` |
| `onionoo_details.json.gz` | Full compressed raw Onionoo payload | JSON / Gzip (Level 9) | N/A | N/A |

## 🛠️ Usage Example

```bash
grep -Fxq "192.0.2.1" non_exits.txt && echo "Matched Tor Non-Exit Relay!"
```
