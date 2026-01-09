**1) Impact/Risk**
- Business disruption and revenue loss.
- Loss of data integrity and/or data duplication.
- Builds poor repution and customers may lose trust.

**2) What to check in the first 5 minutes** <br>
This should be the traffic flow Domain -> Public IP -> Firewall -> Ingress/Reverse proxy(TLS termination) -> Application Endpoint. 
   1. First, check where the requests are being terminated. I suspect a TLS/SSL certificate expiry issue, as all the webhooks failed.
   2. Use curl or other client libraries to test the connectivity. If not reachable, check whether the inbound/outbound ports have been blocked.
      Sometimes the reverse proxy and application endpoints face a deadlock due to resource constraints or a high spike in traffic. The WAF
      may block the IP(s). Sometimes it requires IP whitelisting and restarting the applications.
   3. From step 2, if reachable, check the recent logs of the reverse proxy and application endpoints in ELK or other systems, as well as the response codes (4xx, 5xx).
      Analyzing the logs will narrow the scope of the problem and pinpoint the exact source of the error(s). Check if recent updates(rollout) to the application has caused this issue.
   4. Check the queue and/or database status. The webhook may fail if the queue and/or database are not functional.
   5. For external webhooks, check their webhook status. They may be facing downtime or API rate limiting.
 
 **3) Top 3 root-cause hypotheses (prioritized) + verification steps**
   1. Webhooks can become unreachable due to various issues, including general network errors, a Web Application Firewall (WAF) blocking the IP address,
      blocked ports, an Ingress misconfiguration, or an expired TLS/SSL certificate.<br>
    ```$ curl https://codelabfzc.com/test-webhook/```<br>
    ``` $ openssl s_client -connect codelabfzc.com:443 -servername codelabfzc.com 2>/dev/null | grep "Verify return code" ```
   2. Application-Level failure or deadlock<br>
      Check application logs in the ELK or similar service. Other useful commands are<br>
      ``` $ docker logs <container-name> ```<br>
      ``` $ kubectl logs <pod_name> -n <namespace>```<br>
      ``` $ systemctl status <service_name>```<br>
      ``` $ tail -f /path_to_the_log_file```<br>
   3. External webhook provider or service downtime<br>
      Use Postman/Curl/Client libraries to test the APIs.

**4) Top 2 temporary mitigations**
   1. Restart the applications and/or the Ingress or reverse proxy to restore functionality.  If the problem is due to a recent deployment,
      roll back to a previous stable version. Additionally, restart dependent services-such as the database, message queue, or other backend components-if necessary.
   2. Whitelist the external webhook IPs and/or update your firewall or WAF rules. If the ingress is broken, bypass it temporarily using a proxy or tunnel.
      If available, redirect traffic to a secondary webhook endpoint.

**5) Top 2 permanent fixes**
   1. Implement idempotent, queue-based webhook processing with Dead Letter handling.
   2. Set up redundancy for reverse proxies and application endpoints, automate certificate renewals,
      and enable comprehensive monitoring across both the transport and application layers.

**6) Proposal for monitoring / alert additions**
   1. Continuously monitor the health of your infrastructure, ingress/reverse proxy, application endpoints, queues, and databases, and send alerts if any component fails. 
   2. Check for available upgrades to the external webhook, and monitor the health, response codes, and retry queue for both internal and external webhooks.

**7) Post-incident follow-up**<br><br>
   **Technical**
   1. Verify that all webhook events were successfully delivered or replayed from retry queues, ensuring no data duplication and no missing financial transactions.
   2. Root cause analysis.
   3. Set up monitoring and alerting to detect and notify you of any issues promptly.
   4. Create comprehensive documentation.

   **Business**
   1. Establish clear communication channels with partners, stakeholders, and clients or end users to ensure transparency and consistency.
   2. Follow up on support tickets from clients or end users related to this incident to ensure timely resolution.
   3. Create a simple critical incident document with key steps, contacts, and actions to take during an outage or major issue.
   4. Prepare for audits and maintain compliance with relevant standards.

**Include how to restore consistency after recovery**
   1. Verify that all webhook events were successfully delivered or replayed from retry queues.
   2. Use custom scripts to check for data deduplication.
   3. Compare the financial transactions recorded in the system with the total payments reported by the payment gateway to ensure consistency and detect discrepancies.
