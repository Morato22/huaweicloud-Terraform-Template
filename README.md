# Terraform-HuaweiCloud-Template
 
This repository contains terraform codes to create services in Huawei Cloud Provider, with the possibility to create more than 1 instance with different requirements at the same time.

# DISCLAIMER

The developer of this project is not responsible for data loss neither for unexpected cost increases. You, the user of this project, are the sole responsible for checking the Terraform code output and the Terraform execution plan, and you are the sole responsible for the infrastructure updates consequences after you type yes when running the Terraform apply command.

Always do a double check on the Terraform plan, especially when there are resources to be changed and/or destroyed.

# Requirements

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Huawei Cloud Console](https://console-intl.huaweicloud.com/?locale=en-us)

# How to use

First, you need to put the region that you want and your AK/SK in the first lines in "variables.tf" file. After that, determine the specific service you wish to create within Huawei Cloud. Next, navigate to the "variables.tf" file and locate the variable named like "create_service_example". Set this variable to "true" to create the resource. Then, if you intend to create multiple resources with different specifications, go to the "terraform.tfvars" file. Within this file, adjust the specifications and quantity of resources according to your requirements. Additionally, you'll find examples for creating more than one resource of the same type, which you can replicate as needed. If you're unsure about the desired specifications, you can reference the Huawei Cloud Console for guidance.