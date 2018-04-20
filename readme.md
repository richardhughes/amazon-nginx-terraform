# Terraform & Ansible EC2

## Install 
In the root directory run `terraform init` to pull in the dependencies needed.

## Run
`terraform apply` will prompt you for some details regarding the new EC2 setup. 
Once this is completed you should have a fully provisioned EC2 instance with PHP7.2 & Nginx

## Destroy
`terraform destroy`