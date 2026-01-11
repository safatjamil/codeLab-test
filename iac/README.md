## Workspace ##
Create three workspaces. Exactly the same that are in the env directory.<br>
``` terraform workspace new dev|stage|prod ``` <br>
To switch to the dev workspace<br>
``` terraform workspace select dev ```

## Initialization ##
We’ll use the same S3 bucket but separate keys for each environment.<br>
``` terraform init  -backend-config="key=dev/terraform.tfstate" ```

## Plan ##
``` terraform plan ```

## Apply or Destroy ##
``` terraform apply ```<br>
``` terraform destroy ```

## Handling of state ##
- One state file per environment/workspace.
- Use state locking.
- Avoid manual changes.

## Drift detection ##
Use terraform plan to find what changes will be applied.

