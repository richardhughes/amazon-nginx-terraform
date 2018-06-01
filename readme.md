# Terraform & Ansible EC2

A simple repository to create and provision an EC2 instance using Terraform & Ansible.

## Install 
In the root directory run `terraform init` to pull in the dependencies needed.

## Configure

### Environments
When constructing non-production servers, you need to set the `env` variable in the `group_vars` file to `staging`. This will install a fake SSL certificate and allow you to test the webserver. When using it for production infastructure, you need to set this as `live` and will setup the real SSL and the HSTS header 

### Nginx
Change the `ansible/group_vars/all` file and add a domain which will be passed into the nginx config.

### Fluentd
Fluentd will be installed by default, this currently tails your nginx access log and pushes the results to Logz.io. This means
you don't need access to the server and can easily visualise and search the logs on Logz.io platform (Other platforms available).

Sign up for a free account on Logz.io and add your key to `ansible/group_vars/all` and hit the IP address and you'll see the log appear within 5 minutes.

### SSL Certificate
This takes the domain variable in the `group_vars` file and the sslemail variable. We'll automatically have a lets encrypt 
certificate that's rated A+ on the SSL Labs checker.

## Run
`terraform apply` will prompt you for some details regarding the new EC2 setup. 
Once this is completed you should have a fully provisioned EC2 instance with PHP7.2 & Nginx. Hit the IP address in the console
and you should see the PHP Info page confirming that PHP7.2 was installed.

## Destroy
`terraform destroy`

## Todo
- [ ] Install Fail2Ban for SSH and Nginx
- [ ] Setup Collectd to send logs to Grafana
