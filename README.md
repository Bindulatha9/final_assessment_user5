This terraform code helps us to create an ec2 instance which is connected to VPC and security group created through terraform only.
Here we use modules for the creation of VPC and Security groups and ec2 instance.
Modules help us to reuse the code and reduce deplication.
In main.tf file, we can call the modules and pass the values of variables which are declared in the variables.tf of each module folder.
Here we also used workspaces, test and prod so that based on the environment, we can pass the .tfvars file which applying the code.
Create the workspaces test and prod
terraform workspace new test
terraform workspace new prod

Now based on the environment, we need to pass the .tfvars file while creating the ec2 instance.
terraform apply -var-file="test.tfvars"
terraform apply -var-file="prod.tfvars"
