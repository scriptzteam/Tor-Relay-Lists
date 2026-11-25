# Tor Relay & Exit Node Lists

Automatically generated and updated list of online and offline Tor network relay and exit node IP addresses parsed directly from the official [Tor Onionoo API](https://onionoo.torproject.org/).

* **Last Updated:** 2026-11-25 07:23:11 UTC
* **Raw Archive Size:** 37M (`38190795` bytes)

## 📊 Node Statistics

| Filename | Description | IP Protocol | Status | Unique IP Count |
| :--- | :--- | :--- | :--- | :--- |
| `relays.txt` | All online Tor relays | IPv4 & IPv6 | Online | `9412` |
| `relays_v4.txt` | Online relays (IPv4 only) | IPv4 | Online | `7038` |
| `relays_v6.txt` | Online relays (IPv6 only) | IPv6 | Online | `2374` |
| `exits.txt` | All online Tor exit nodes | IPv4 & IPv6 | Online | `1640` |
| `exits_v4.txt` | Online exit nodes (IPv4 only) | IPv4 | Online | `1249` |
| `exits_v6.txt` | Online exit nodes (IPv6 only) | IPv6 | Online | `391` |
| `offline_relays.txt` | All offline Tor relays | IPv4 & IPv6 | Offline | `913` |
| `offline_exits.txt` | All offline Tor exit nodes | IPv4 & IPv6 | Offline | `206` |
| `onionoo_details.json.gz` | Full compressed raw Onionoo payload | JSON / Gzip (Level 9) | N/A | N/A |

## 🛠️ Usage Example

```bash
grep -Fxq "192.0.2.1" exits.txt && echo "Matched Tor Exit!"
```
