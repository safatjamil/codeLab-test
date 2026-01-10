## Proposal ##
  **Document the improvement idea clearly, including:**<br>
  - Current pain points, drawbacks, or limitations.<br>
  - Proposed new structure and objective.<br>
  - What problems the new architecture will solve (benifits).<br>
  - Impact analysis across dev/stg/prod environments.<br>
  - High level desing and technical details.<br>
  - An implementation plan defining project members, managers, and stakeholders.<br>
  - Risks and mitigation strategies.<br>

## Agreement ##
 - The proopsal must be reviewed by stakeholders (PMs, Tech leads, and/or Business owners).<br>
 - Conduct a detailed review of existing policies, associated risks, potential outcomes, and compliance requirements.<br>
 - In some cases, external auditors may need to be engaged to ensure and enforce compliance requirements.<br>
 - Explicit written approval (Jira, Confluence, or email) is required before proceeding.<br>

## Implementation ##
 - Changes should be implemented only after approval.<br>
 - Code/config changes (Build configs, Terraform modules, CI/CD pipelines) should be version-controlled.<br>
 - Changes should be applied in the proper order dev -> stage -> production.

## Are there cases where changes are made before approval? ##
No for specifications / architecture / IaC / security settings. In the event of a critical incident, severe security vulnerability,<br>
or outage, changes must be reviewed promptly by stakeholders before implementation. However, during time-critical situations when business leads
are unavailable, senior engineers may apply minor, necessary changes to restore system or application functionality.<br>
These actions must be clearly documented and promptly reported to the relevant product owners.
