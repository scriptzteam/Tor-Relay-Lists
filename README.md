# Tor Relay & Exit Node Lists

Automatically generated and updated list of online Tor network relay and exit node IP addresses parsed directly from the official [Tor Onionoo API](https://onionoo.torproject.org/).

* **Last Updated:** 2026-11-25 07:19:39 UTC
* **Raw Archive Size:** 37M (`38190795` bytes)

## 📊 Node Statistics

| Filename | Description | IP Protocol | Unique IP Count |
| :--- | :--- | :--- | :--- |
| `relays.txt` | All online Tor relays | IPv4 & IPv6 | `9412` |
| `relays_v4.txt` | Online relays (IPv4 only) | IPv4 | `7038` |
| `relays_v6.txt` | Online relays (IPv6 only) | IPv6 | `2374` |
| `exits.txt` | All online Tor exit nodes | IPv4 & IPv6 | `1640` |
| `exits_v4.txt` | Online exit nodes (IPv4 only) | IPv4 | `1249` |
| `exits_v6.txt` | Online exit nodes (IPv6 only) | IPv6 | `391` |
| `onionoo_details.json.gz` | Full compressed raw Onionoo payload | JSON / Gzip (Level 9) | N/A |

## 🛠️ Usage Example

```bash
grep -Fxq "192.0.2.1" exits.txt && echo "Matched Tor Exit!"
```
