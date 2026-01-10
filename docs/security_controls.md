# Security Controls

## 1) Control List
  **1. WAF / Rate Limit / IP restrictions**<br>
    &nbsp;&nbsp;&nbsp;- Deploy vendor-agnostic WAF rules to block common OWASP threats like SQL injection, cross-site scripting (XSS), and path traversal.<br>
    &nbsp;&nbsp;&nbsp;- Enforce rate limits per endpoint, HTTP method, or user to help prevent DDoS and brute-force attacks.<br>
    &nbsp;&nbsp;&nbsp;- Apply IP allowlists or denylists at the edge (Cloudflare-like service) to restrict access to admin or sensitive APIs.<br>

  **2. SSH / OS hardening operations**<br>
    &nbsp;&nbsp;&nbsp;- Disable password-based SSH; enforce key-based authentication only.<br>
    &nbsp;&nbsp;&nbsp;- Restrict SSH access to a non-standard port (e.g. 1900) via firewall rules.<br>
    &nbsp;&nbsp;&nbsp;- Avoid shared user accounts and prohibit direct access to the root user.<br>
    &nbsp;&nbsp;&nbsp;- Monitor for unauthorized user login attempts and alert on suspicious activity.<br>
    &nbsp;&nbsp;&nbsp;- Implement automated fail2ban-like intrusion prevention.<br>
    &nbsp;&nbsp;&nbsp;- Enforce monthly patching of OS and critical packages via automated update policies.<br>
    &nbsp;&nbsp;&nbsp;- Deploy Wazuh to detect and alert on security vulnerabilities across your systems.<br>
    &nbsp;&nbsp;**To protect**<br>
    &nbsp;&nbsp;&nbsp;- These measures prevent unauthorized access, limit actions by unprivileged users, and protect the system from common attacks and vulnerabilities.

  **3. TLS certificate operations**<br>
    &nbsp;&nbsp;&nbsp;- All public endpoints require valid TLS certificates.<br>
    &nbsp;&nbsp;&nbsp;- Prefer using certificates for internal communication as well.<br>
    &nbsp;&nbsp;&nbsp;- Certificates are automatically renewed using ACME (Let’s Encrypt + certbot).<br>
    &nbsp;&nbsp;&nbsp;- Revoke certificates immediately if they are compromised.<br>
    &nbsp;&nbsp;**To protect**<br>
    &nbsp;&nbsp;&nbsp;- Ensure secure communication between clients and the server, including all internal server-to-server traffic.<br>
    &nbsp;&nbsp;&nbsp;- Ensure transmitted data is secure-whether over the internet or internal networks.<br>

  **4. Secret management**<br>
    &nbsp;&nbsp;&nbsp;- API keys, passwords, TLS private keys, and other secrets are stored in a centralized secrets vault (HashiCorp Vault/AWS Secrets Manager/Keeper).<br>
    &nbsp;&nbsp;&nbsp;- Secrets are never hardcoded or committed to source control.<br>
    &nbsp;&nbsp;&nbsp;- Rotation is automated or triggered on-demand with zero-downtime workflows.<br>
    &nbsp;&nbsp;&nbsp;- Remove a secret on compromise.<br>
    &nbsp;&nbsp;&nbsp;- Monitor secret usage and remove any that are no longer needed.<br>
    &nbsp;&nbsp;**To protect**<br>
    &nbsp;&nbsp;&nbsp;- Ensure secrets are not accessible to unprivileged users.<br>

  **5. Audit log policy**<br>
    &nbsp;&nbsp;&nbsp;- All user and system actions are logged with proper fields (user Id, timestamp, action performed).<br>
    &nbsp;&nbsp;&nbsp;- Logs are shipped to a write-once, immutable SIEM (ELK or cloud native).<br>
    &nbsp;&nbsp;&nbsp;- Review logs regularly-weekly or monthly, depending on log volume and activity frequency.<br>

  **6. Cookies / Sessions operations**<br>
   &nbsp;&nbsp;&nbsp;- All session cookies enforce same attributes such as secure and samesite.<br>
   &nbsp;&nbsp;&nbsp;- Use strong, unpredictable cookie names and session IDs to enhance security.<br>
   &nbsp;&nbsp;&nbsp;- Use short-lived session tokens.<br>
   &nbsp;&nbsp;**To protect**<br>
   &nbsp;&nbsp;&nbsp;- Protect user sessions from hijacking, XSS, and CSRF attacks.<br>

  **7. CORS policy**<br>
  &nbsp;&nbsp;&nbsp;- Explicitly list allowed origins for each environment to prevent unauthorized cross-origin requests.<br>
  &nbsp;&nbsp;&nbsp;- Explicitly list allowed request headers.<br>
  &nbsp;&nbsp;&nbsp;- Set preflight caching (Access-Control-Max-Age) to a relatively low value, such as 600 seconds.<br>
  &nbsp;&nbsp;**To protect**<br>
  &nbsp;&nbsp;&nbsp;- Applications from unauthorized cross-origin access.<br> 

  **8. CSP policy**<br>
  &nbsp;&nbsp;&nbsp;- Sources are restricted to known domains.<br>
  &nbsp;&nbsp;&nbsp;- Avoid using unsafe-inline and unsafe-eval.<br>
  &nbsp;&nbsp;&nbsp;- Enforce a strict Content Security Policy (CSP) with allowlists for scripts (JS/CSS) and other resources.<br>
  &nbsp;&nbsp;**To protect**<br>
  &nbsp;&nbsp;&nbsp;- Applications from Cross-Site Scripting (XSS), clickjacking, and data injection.<br>

  **9. Webhook hardening**<br>
  &nbsp;&nbsp;&nbsp;- Cryptographic signature (HMAC-SHA256) verified against a shared secret.<br>
  &nbsp;&nbsp;&nbsp;- Unique request ID for replay protection.<br>
  &nbsp;&nbsp;&nbsp;- Idempotency key to safely retry failed deliveries.<br>
  
## 2) Configuration Example##
  Below is the Terraform configuration to allow and block IPs in Cloudflare.<br>
  Reference: https://registry.terraform.io/providers/jalmonter/lt-cloudflare/latest/docs/resources/access_application
  ```
  resource "cloudflare_access_application" "dev_auth_api" {
    name       = "DEV Auth API"
    domain     = "dev-auth.codelabfzc.com"
    type       = "self_hosted"
  
    # Allow, Developers, QAs, and DevOps/SREs
    ip_rules = [
      { ip = "103.72.212.33/24", action = "allow" }, # Developers and QA
      { ip = "192.168.0.105/32", action = "allow" }, # DevOps bastion
      { ip = "0.0.0.0/0", action = "block" }         # Block all others
    ]
  
    # rate limit
    rate_limit {
      threshold = 10
      period    = 60
      action    = "block"
    }
  }
```

## 3) Operational Procedures##

**Secret Rotation**<br>
&nbsp;&nbsp;- **Creation**: Created automatically by secrets manager or manually via incident response.<br>
&nbsp;&nbsp;- **Versioning**: New secret version is generated.<br>
&nbsp;&nbsp;- **Deployment**: Update applications to accept the new secrets temporarily (Blue/green deployment).<br>
&nbsp;&nbsp;- **Verification**: Verify applications functionality.<br>
&nbsp;&nbsp;- **Deprecation**: Deprecate the old secret.<br>
&nbsp;&nbsp;- **Logging**: Update the audit logs.<br>

**Access permission review**<br>
&nbsp;&nbsp;- Follow the principle of least privilege by using fine-grained roles and policies.<br>
&nbsp;&nbsp;- Quarterly access reviews for all human users and service accounts.<br>
&nbsp;&nbsp;- Monitor usage and remove inactive entities.<br>

**Exception handling**<br>
&nbsp;&nbsp;- All exceptions are logged and flagged for post-expiry audit.<br>
&nbsp;&nbsp;- Must be approved by the security team or platform owner.



    

