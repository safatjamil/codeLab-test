## How to run
**Prerequisites**<br>
- git
- Terraform
- AWS credentials configured
- Terraform workspaces are created

**Deployment**<br>
Let's assume we're deploying to the dev environment.
```
git clone <repository>
cd iac/terraform
terraform workspace select dev
terraform init  -backend-config="key=dev/terraform.tfstate"
terraform plan
terraform apply
```

## Design intent
**Modularity:** Reusable Terraform modules for consistent resource provisioning.<br>
**State isolation and locking:** Separate Terraform state files per environment stored in S3 with native locking.<br>
**Immutable Infrastructure:** All deployments are versioned and stored in a SCM; manual changes are discouraged.<br>
**Observability:** Integrated monitoring using Zabbix and Prometheus/Grafana stacks.<br>
**Tightened Security:** Least-privilege IAM roles, hardened network configurations, and Wazuh-based vulnerability detection.

## Policy for different environments
**Development**
- For rapid development & testing.<br>
- Access to developers, DevOps/SREs, and QA engineers(partial).<br>
- Minimal resource allocation (t2.small).<br>
- Automated and frequent deployments<br>
- Least monitoing and alerting.<br>
- Less data retention periods.<br>
- Less security constraints.

**Stage**
- Pre-production validation and UAT testing.<br>
- Access to QAs, DevOps/SREs, Support team, and Business leads.<br>
- Near production scale resource.<br>
- Automated or manual deployment.<br>
- Comprehensive monitoring and alerting.<br>
- Near production retention periods.<br>
- Enhanced security but less than the production environment.<br>

**Production**
- Serve end users workloads.<br>
- Access to end users, DevOps, and the support team.<br>
- Highly availability, replication, and failover.<br>
- Automated or manual deployment with approval.<br>
- Comprehensive monitoring and alerting.<br>
- Retention periods to comply with the SLA.<br>
- Maximum security (WAF, vulnerability detection, hardened os and applications).<br>
