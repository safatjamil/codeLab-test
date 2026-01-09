**1) Impact/Risk**
- Business disruption and revenue loss.
- Loss of data integrity and/or data duplication.
- Builds poor repution and customers may lose trust.

**2) What to check in the first 5 minutes (max 5 items)** <br>
This should be the traffic flow Domain -> Public IP -> Firewall -> Ingress/Reverse proxy(TLS termination) -> Application Endpoint. 
   1. First, check where the requests are being terminated. I suspect a TLS/SSL certificate expiry issue, as all the webhooks failed.
   2. Use curl or other client libraries to test the connectivity. If not reachable, check whether the inbound/outbound ports have been blocked.
      Sometimes the reverse proxy and application endpoints face a deadlock due to resource constraints or a high spike in traffic. The WAF
      may block the IP(s). Sometimes it requires IP whitelisting and restarting the applications.
   3. From step 2, if reachable, check the recent logs of the reverse proxy and application endpoints in ELK or other systems, as well as the response codes (4xx, 5xx).
      Analyzing the logs will narrow the scope of the problem and pinpoint the exact source of the error(s).
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
