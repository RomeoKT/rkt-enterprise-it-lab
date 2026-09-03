# Day 03 — pfSense Break/Fix

## INC-01 — DNS Failure

### Symptom
- ping IP works
- domain names fail

### Root Cause
- wrong DNS server

### Fix
- DNS restored to 10.10.10.1

### Validation
- nslookup google.com OK

## INC-02 — Firewall Rule Disabled

### Symptom
- USERS cannot access Internet

### Evidence
- firewall logs show blocked traffic

### Root Cause
- Internet pass rule disabled

### Fix
- enabled ALLOW USERS TO INTERNET

### Validation
- Internet access OK

## INC-03 — Outbound NAT Disabled

### Symptom
- local gateway reachable
- Internet unavailable

### Root Cause
- private source IP not translated to WAN

### Fix
- restored Automatic Outbound NAT

### Validation
- Internet access OK

## INC-04 — Wrong Gateway

### Symptom
- local network works
- remote network fails

### Root Cause
- wrong default gateway

### Fix
- restored 10.10.10.1

### Validation
- external connectivity OK