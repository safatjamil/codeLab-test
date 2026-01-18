# System Overview

This platform offers dedicated admin and merchant portals to manage blockchain-powered payment operations.

## Key Design Principles
- **Strict isolation**: Admin and merchant data are fully separated.
- **Access restriction**: Admins can't directly access the Blockchain network. Merchants can't directly access the Indexer/Bitcoin node.
- **No public exposure**: APIs, DBs, and Blockchain components are in private subnets.
- **Defense in depth**: HTTPS, OAuth, mTLS, JWT, IP allowlists, row-level security, and WAF.
- **Single Merchant DB**: Logical separation via `merchant_id` with enforced RLS.
- **Egress for p2p/public access**: Blockchain nodes use a NAT gateway for P2P connection and internet access.
- **Compliance-ready**: Audit trails, least-privilege access, and hardened components.


## Security Highlights
- **Internet facing components**: Uses HTTPS and integrated with open source/cloud WAF.
- **Admin API**: IP allowlist and strong WAF.
- **Merchant API**: Validates hostname and merchant_id. Limited access to the Admin API.
- **Strict NACLs**: Each private subnet will allow access from specific subnets.
- **Inter-service auth**: OAuth2 + mTLS between Admin and Merchant backends.
- **DB access**: Each DB access is security group restricted.
- **Secrets**: Stored in Vault; never shared across containers.


## Network Flow
Admin/Merchant → Public UI → Private API → (Private DB or Payment Processor) → Indexer → Blockchain Node
