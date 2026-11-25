# Tor Relay & Exit Node Lists

Automatically generated and updated list of online and offline Tor network relay, exit, and non-exit node IP addresses parsed directly from the official [Tor Onionoo API](https://onionoo.torproject.org/).

- **Last Updated:** 2026-11-25 07:51:06 UTC
- **Raw Archive Size:** 37M (`38190795` bytes)

## 📊 Node Statistics

| Filename | Description | IP Protocol | Status | Unique IP Count |
| :--- | :--- | :--- | :--- | :--- |
| `relays.txt` | All online Tor relays | IPv4 & IPv6 | Online | `9412` |
| `relays_v4.txt` | Online relays (IPv4 only) | IPv4 | Online | `7038` |
| `relays_v6.txt` | Online relays (IPv6 only) | IPv6 | Online | `2374` |
| `exits.txt` | All online Tor exit nodes | IPv4 & IPv6 | Online | `1640` |
| `exits_v4.txt` | Online exit nodes (IPv4 only) | IPv4 | Online | `1249` |
| `exits_v6.txt` | Online exit nodes (IPv6 only) | IPv6 | Online | `391` |
| `non_exits.txt` | All online Tor non-exit relays | IPv4 & IPv6 | Online | `7879` |
| `non_exits_v4.txt` | Online non-exit relays (IPv4 only) | IPv4 | Online | `5884` |
| `non_exits_v6.txt` | Online non-exit relays (IPv6 only) | IPv6 | Online | `1995` |
| `offline_relays.txt` | All offline Tor relays | IPv4 & IPv6 | Offline | `913` |
| `offline_relays_v4.txt` | Offline relays (IPv4 only) | IPv4 | Offline | `697` |
| `offline_relays_v6.txt` | Offline relays (IPv6 only) | IPv6 | Offline | `216` |
| `offline_exits.txt` | All offline Tor exit nodes | IPv4 & IPv6 | Offline | `206` |
| `offline_exits_v4.txt` | Offline exit nodes (IPv4 only) | IPv4 | Offline | `160` |
| `offline_exits_v6.txt` | Offline exit nodes (IPv6 only) | IPv6 | Offline | `46` |
| `offline_non_exits.txt` | All offline Tor non-exit relays | IPv4 & IPv6 | Offline | `709` |
| `offline_non_exits_v4.txt` | Offline non-exit relays (IPv4 only) | IPv4 | Offline | `538` |
| `offline_non_exits_v6.txt` | Offline non-exit relays (IPv6 only) | IPv6 | Offline | `171` |
| `onionoo_details.json.gz` | Full compressed raw Onionoo payload | JSON / Gzip (Level 9) | N/A | N/A |

## 🛠️ Usage Example

```bash
grep -Fxq "192.0.2.1" non_exits.txt && echo "Matched Tor Non-Exit Relay!"
```
