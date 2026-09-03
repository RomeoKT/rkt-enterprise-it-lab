# Day 03 — pfSense Network Segmentation

## Objective
Build a segmented enterprise-style network using pfSense.

## Networks

| Zone | Network | Gateway |
|---|---|---|
| USERS | 10.10.10.0/24 | 10.10.10.1 |
| SERVERS | 10.10.20.0/24 | 10.10.20.1 |
| MGMT | 10.10.30.0/24 | 10.10.30.1 |
| SECURITY | 10.10.40.0/24 | 10.10.40.1 |

## Services
- DHCP on USERS
- pfSense DNS Resolver
- Automatic Outbound NAT

## Firewall Design
- USERS to Internet: allowed
- USERS to SERVERS: limited
- USERS to other internal networks: blocked
- MGMT to internal networks: allowed
- SERVERS outbound: limited
- SECURITY outbound/internal: limited

## Concepts
- stateful firewall
- implicit deny
- aliases
- source
- destination
- protocol
- ports
- outbound NAT
- segmentation
- least privilege
- firewall logs
- state table