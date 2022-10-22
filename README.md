AWS Cloud Automation Using Terraform!

Step 1: 
Let`s save our 'aws_access_key_id' and 'aws_secret_access_key' in ~/.aws/credentials. Then we good to go! 
example:
[default]
aws_access_key_id = dr...go
aws_secret_access_key = iv...ov
p.s. To SSH into instances add your 'ssh-key.pem' file inside /modules/alb-web/variables.tf file

Step 2: 
terraform init
terrafrom plan
terraform apply --auto-approve

... wait for 3 or 4 minutes (because the database will took some time, grab a coffee or beer) ... vuala! All the services are up and running!   


The script will create (from alb-web) Elastic Load Balancer and three web servers (Apache2) installed on linux instances (Amazon Linux 2 Kernel 5.10 AMI 2.0.20221004.0 x86_64 HVM gp2) with 'Security Group', 'Target Group', 'Load Balancer', 'Listeners'. We will use the defailt VPC and Subnets. 'Cloudwatch' module will create a Dashboards with EC2 CPU and CloudWatch alarm metric. 'Rds' will create mariaDB database (version 10.6.10).
