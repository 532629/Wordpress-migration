## Terraform file  Structure


```
.
├── backend
│   ├── backend_dev.tf
│   ├── backend_preprod.tf
│   └── backend_prod.tf
├── env_vars
│   ├── terraform_dev.tfvars
│   ├── terraform_preprod.tfvars
│   └── terraform_prod.tfvars
├── main.tf
├── output.tf
├── provider.tf
├── ssh.tf
├── terraform.tfstate
├── terraform.tfstate.backup
├── tfplan
│   ├── wp-preprod.apply.tfplan
│   ├── wp-preprod.destroy.tfplan
│   └── wp-prod.apply.tfplan
└── variables.tf

```


- `backend/`: directory containing key,storage account details to store the terraform tfstate file.
- `env_vars/`: directory containing the environment related variable.

## Running this terraform  will create the following Azure cloud resources:

```
- 1. Resource Group, 
- 2. VNet, 
- 3. Subnet,
- 4. Network Interface
- 5. Public IP, 
- 6. Network Security Group,
- 7. Virtual Machine
- 8. Public and Private key

```

## Terraform Commands-
```

PREPROD -
terraform init -backend=true \
-force-copy \
-input=false \
-backend-config=backend/backend_preprod.tf

terraform plan -var-file="env_vars/terraform_preprod.tfvars" -out "tfplan/wp-preprod.apply.tfplan"
terraform apply "tfplan/wp-preprod.apply.tfplan"

PROD
terraform init -backend=true \
-force-copy \
-input=false \
-backend-config=backend/backend_prod.tf


terraform plan -var-file="env_vars/terraform_prod.tfvars" -out "tfplan/wp-prod.apply.tfplan"
terraform apply "tfplan/wp-prod.apply.tfplan"

terraform plan -destroy -var-file="env_vars/terraform_prod.tfvars" -out "tfplan/wp-prod.destroy.tfplan"
terraform apply "tfplan/wp-prod.destroy.tfplan"

```
