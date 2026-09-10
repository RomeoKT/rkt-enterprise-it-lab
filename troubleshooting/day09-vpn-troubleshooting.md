# Day 09 — VPN Troubleshooting

## Objective

Structured troubleshooting methodology for an IPsec Site-to-Site VPN that is down or not passing traffic. Documented scenario only.

---

## Scenario

Two networks should communicate through an IPsec Site-to-Site VPN.
SITE A 10.10.0.0/16
|
Firewall A
|
Internet
|
Firewall B
|
SITE B 10.20.0.0/16


Users at Site A cannot reach Site B resources.

---

## Troubleshooting Steps

### Step 1 — Local Connectivity
Verify client has valid IP, subnet mask, gateway. Can the client reach its local firewall? If no, VPN is not the issue yet.

### Step 2 — Internet Connectivity
Both firewalls must reach each other over the Internet. Test with ping from each WAN.

### Step 3 — VPN Peer Addresses
Check that Firewall A points to Firewall B's WAN IP, and vice versa. Wrong peer IP breaks IKE.

### Step 4 — IKE (UDP 500 / UDP 4500)
Verify:
- peer addresses
- authentication method
- pre-shared key or certificates
- IKE version
- encryption and integrity settings

Both sides must match.

### Step 5 — Authentication
If using Pre-Shared Key, both peers need the same key. A mismatch blocks the tunnel. Never commit real secrets to Git.

### Step 6 — IPsec Parameters
Check local network, remote network, encryption, integrity, traffic selectors on both sides.

Example:
- Site A local: 10.10.0.0/16 → Site A remote: 10.20.0.0/16
- Site B local: 10.20.0.0/16 → Site B remote: 10.10.0.0/16

### Step 7 — VPN Status
Check status: DOWN / CONNECTING / ESTABLISHED.

If UP but traffic fails, continue to routing and firewall.

### Step 8 — Routing
Site A must know how to reach 10.20.0.0/16. Site B must know 10.10.0.0/16.

A tunnel UP does not mean routing is correct.

### Step 9 — Firewall Policies
Verify rules allow traffic between 10.10.0.0/16 and 10.20.0.0/16 on both sides.

A VPN can be UP while a firewall policy blocks traffic.

### Step 10 — NAT
Internal VPN traffic should not be translated as normal Internet traffic. Wrong NAT can break return routing.

### Step 11 — Logs
Check firewall and VPN logs for:
- IKE failure
- authentication failure
- proposal mismatch
- peer unreachable
- traffic selector mismatch
- IPsec SA creation

Use logs to find the real problem, not guess.

### Step 12 — Test Traffic
Test the service the user needs:
- DNS TCP 53
- HTTPS TCP 443
- SMB TCP 445
- RDP TCP 3389

### Step 13 — Return Traffic
Check that the response path works on both sides: routes, firewall rules, VPN selectors, NAT.

---

## Common Root Causes
- Wrong peer IP
- Internet down
- Wrong pre-shared key
- IKE mismatch
- IPsec proposal mismatch
- Wrong local or remote network
- Firewall blocking
- Wrong route
- Wrong NAT
- Expired certificate
- Remote firewall down

---

## Decision Flow
Cannot reach remote site
↓
Local network OK?
├── NO → fix local network
└── YES
↓
Peer reachable?
├── NO → fix WAN/routing
└── YES
↓
IKE OK?
├── NO → check peer, auth, IKE params
└── YES
↓
IPsec UP?
├── NO → check IPsec params/selectors
└── YES
↓
Routes OK?
├── NO → fix routing
└── YES
↓
Firewall allows?
├── NO → fix policy
└── YES
↓
NAT OK?
├── NO → fix NAT
└── YES
↓
Test service
↓
Check return path
↓
Validate



---

## Validation

Resolved only if:
- Tunnel is UP
- Required traffic passes
- Return traffic works
- User reaches the resource

A tunnel UP alone is not enough.

---

## Escalation

Escalate if:
- ISP or WAN failure suspected
- Peer managed by another company
- Certificate/PKI issues
- Configuration needs higher privileges
- Security policy changes need approval

---

## Key Lesson

Order to follow:
Local → Internet → Peer → IKE → Auth → IPsec → Routing → Firewall → NAT → Logs → Test → Return path → Validate

Do not change encryption or routing randomly. Identify the failing layer first.