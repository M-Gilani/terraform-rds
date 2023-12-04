# terraform-rds
rds in terrraform code
Before I even started the code I drew a quick diagram on paper so I could make sure I was properly visualizing and understanding what I wanted to make


First I had to create a VPC to hold any resources I would need.
I interpreted the task as creating just an RDS that would be able to handle an EC2 cluster, not also make the cluster.
There is still a public subnet if the cluster needs to be added. All that is needed is a security group with the correct rules, a route table, and an internet gateway so it can be accessed through the internet.
Of course, you could your own code or ami image to bootstrap the instances, so it is prepared and the e-commerce site when it has loaded. However, this may increase the start-up time.
The private subnets are in different AZs to host for increased availability and fault tolerance. Also, it would host the multi-AZ deployment of the RDS.



This is some Terraform code to create an RDS database in AWS. It was created to meet specific parameters that were provided.
The instance type is db.m5.large to handle large amounts of requests from a cluster of EC2 instances.
Multi-az deployment is set to true, so it is highly available as the task requested.
It is MySQL-compatible.
Placed in a private subnet and attached a security group with the correct rules. so nothing outside of the VPC can communicate with it. only services inside of it. Also added AWS-managed encrypted keys so the data cannot be read therefore even more secure. 
The data that would be stored was said to be high profile, so I thought it would be necessary or beneficial.
I also decided to add backups just in case anything is lost. it can be recovered.


My Research:

This mainly consisted of my knowledge and then official documentation of AWS/Terraform. Videos and Error code logs.
Any error codes I got were easy to fix as there is always something online or I could paste the error into Chat-GPT and it would instantly tell me why it was happening if I wasn't sure myself. It was much quicker and more efficient to use this as a tool.
After I compiled my code, I used terraform init, fmt, plan then apply. If there were any issues I'd try to solve them or use Chat-GPT as a tool to double-check. Of course, leaving out passwords, etc, because I know that can sometimes be a security issue even with AI.
I had to adjust my CIDR blocks a few times to make sure they fit for a public/private subnet use while also not overlapping because that didn't allow the code to run.
Like with every coding project, there was a lot of trial and error to get to the final result.
