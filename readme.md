# Terraform & Ansible EC2

A simple repository to create and provision an EC2 instance using Terraform & Ansible.

## Install 
In the root directory run `terraform init` to pull in the dependencies needed.

## Run
`terraform apply` will prompt you for some details regarding the new EC2 setup. 
Once this is completed you should have a fully provisioned EC2 instance with PHP7.2 & Nginx. Hit the IP address in the console
and you should see the PHP Info page confirming that PHP7.2 was installed.

### Domain
To use a domain, you need to change the `roles/nginx/defaults/main.yml` file.

### Fluentd
Fluentd will be installed by default, this currently tails your nginx access log and pushes the results to Logz.io. This means
you don't need access to the server and can easily visualise and search the logs on Logz.io platform (Other platforms available).

Sign up for a free account on Logz.io and add your key to `roles/fluentd/defaults/main.yml` and hit the IP address and you'll see the log
appear within 5 minutes.

## Destroy
`terraform destroy`

## Todo
- [ ] SSL Certificate (A+ on SSL Labs) with Lets Encrypt