# Prerequisites

Following prerequisites versions or higher needed to be installed and configured.
- terraform >= 0.15
- aws-cli >= 2.1.17

# IaC Deployment

Following AWS service will create through **Terraform**
| Service | Version |
| :---: | :---: |
| vpc | |
| eks | 1.20 |
| rds | 5.7.12 |

1. Config Terraform Provider
   
   - Change terraform `provider "aws" {}` block according to the `aws configure` in `terraform/provider.tf` file.
    - You can use an AWS credentials or configuration file to specify your credentials. The default location is `$HOME/.aws/credentials`. You can optionally specify a different location in the Terraform configuration by providing the `shared_credentials_file` argument or using the `AWS_SHARED_CREDENTIALS_FILE` environment variable. This method also supports a `profile` configuration and matching `AWS_PROFILE` environment variable

    ```terraform
    provider "aws" {
    region                  = [REGION]
    shared_credentials_file = "/home/[USER]/.aws/credentials"
    profile                 = [PROFILE]
    }
    ```

2. Deploy ***`terraform`*** code while changing the `variables.tf` according the requirement.

   - `cd terraform`
   - `terraform init`
   - `terraform plan`
   - `terraform apply -auto-approve`

# Installing EKS Addons
Using EFS and ALB as addons, need to install those service on EKS cluster after cluster provisioned.
1. Install EFS

   ```shell
   cd addons
   sh efs-csi.sh
   ```
2. Install ALB
   ```shell
   cd addons
   sh alb.sh
   ```
# Application Deployment

Using ***`helm`*** chart to deploy but **secrets** has created manually

```shell
helm upgrade -i shp-drupal ./helm/drupal --debug
```