# README

---

# AND Digital Tech Test

Written in reference to the brief provided during the AND Digital interview process. This project aims to demonstrate competency and flexibility with Terraform and AWS through the deployment of a simple web front end.

## Table of Contents

1. [The Brief](#the-brief)
2. [Breakdown](#breakdown-and-moscow-prioritisation)
    + [Load Balancer](#load-balanced-web-front-end)
    + [Elements](#a-number-of-elements)
    + [Security](#secure-web-page)
    + [Core](#core-requirements)
3. [Architecture Diagrams](#architecture)
    + [MVP](#minimum-viable-product)
    + [Containers](#containerised-architecture)
    + [Serverless](#extension:-serverless-architecture)
4. [Requirements](#what-do-you-need-to-run-this?)

## The Brief

+ Terraform a load balanced web front end in AWS, GCP or Azure.
+ The solution should incorporate a number of elements
+ There should be a minimum of 2 instances and they need to be able to scale across availability zones.
+ Ideally the web page should be secure.
+ The Vpc should be appropriately split into the required subnets.
+ The hosts should be running Linux and the choice of web server is down to the individual.
+ The use of modules would be a good step but the focus should be on good terraform structure.

## Breakdown and MoSCoW Prioritisation

### Load balanced web front end

**Must:** The app or page must be open to the web, and must be load balanced.

**Should:** Make use of the advantages of cloud technology to showcase Terraform skill. Possible use of Elastic Load Balancer or Application Load Balancer on AWS.

**Could:** Integrate into a networking system that makes the best use of ancilliary offerings eg. Route53.

**Would:** Fully integrate a backend and extended functionality for the website.

### A Number of Elements

This requirement was extremely open to interpretation, and applying prioritisation to it was somewhat difficult. This being the case, I've split the MoSCoW metric into seperate interpretations of what this requirement entiails.

**Must:** Make use of several cloud elements, eg; EC2, ELB, ASG etc.

**Should:** Make use of several architecture layouts to showcase skill with Terraform.

**Could:** More broadly interpret the spirit of the requirements to analyse use-cases and costs and suggest extensions.

**Would:** More accurately represent a cloud engineering / DevOps production environment by integrating monitoring and analysis tools.

### Secure Web Page

**Must:** Make use of a web server with proxy or obfuscation capabilities. In this instance, NGINX.

**Should:** Be networked to enable https traffic. Use of Route53 and AWS Certificate Manager likely.

**Could:** Enable encryption between web elements using AppMesh or similar microcontroller.

**Would:** Enable dynamic trafic monitoring and policing.

### Core requirements

Outside of the prioritisation metric, I've chosen to consider the remaining requirements to be core to the success of the project. Despite the 'modules' requirement being optional, it's how I've been taught to build terraform structure.

## Architecture

Due to the week provided to complete the technical test, I chose to approach the architecture of the project in three seperate ways.

1. The first layout fulfils the minimum viable product requirements of the brief.
2. The second starts to involve containerisation and provides a CI/CD server. This enables the project to be more extensible.
3. The third layout pulls away from the specifics of the brief to approach the 'spirit' of a single page web deployment from a completely different angle, whilst still showcasing Terraform skills. Whilst not necessary for the task, I felt it would be interesting to compare a serverless layout of the same project to traditional architecture, particularly through the metrics of cost and simplicity.

### Minimum Viable Product

![alt text](https://i.imgur.com/MezyNI5.png "Minimum Viable Product Architecture for AND Digital Tech Test")

### Containerised Architecture

![alt text](https://i.imgur.com/is3MBKC.png "Containerised Architecture for AND Digital Tech Test")

### Extension: Serverless Architecture

![alt text](https://i.imgur.com/5uZvx6q.png "Serverless Architecture for AND Digital Tech Test")

## What Do You Need To Run This?

The various versions of this project will ask you for some information after navigating to the respective /eu_west_2/ folders and running `terraform init`, `terraform plan` and finally ```terraform apply`

All three versions will require you to input:

1. Your AWS account ID
2. The name of a key or key-path which you have created on the web interface
3. A domain name which you can prove ownership of

The 'Containerised Architecture' version of this project requires a somewhat more complicated installation and setup process, due to the inclusion of a CI/CD server and use of kubernetes.

1. Clone down this repository.
2. Create or login to your AWS account.
3. Generate an AWS .pem key, downloading your copy and noting the name. Note: YOUR KEY MUST BE CREATED IN THE REGION YOU INTEND TO DEPLOY TO.
4. Navigate to the containerised_architecture/environments/eu-west-2 folder of this directory, and place your copy of the AWS key here.
5. Install terraform following [this guide](https://learn.hashicorp.com/terraform/getting-started/install.html).
6. In the same folder, run the command `terraform init` followed by `terraform plan`.
7. Provide the variables as requested by terraform, and check that no errors are thrown.
8. Still in the folder, run the command `terraform apply`.
9. Navigate to your AWS web console and follow the instructions to ssh to your newly created EC2 instance. This can be found by searching EC2 in the upper right search bar.
10. On the EC2 server, run the command `sudo su jenkins`.
    + Run the command `aws configure` inserting the credentials you used for terraform.
11. Get the IP address of the instance that you're on.
12. Open a web browser and paste it in the address bar using the format `ipaddress:8080`.
    + `cat` initial password as directed on the Jenkins welcome page
    + Install plugins and sign up to Jenkins as directed.
    + Name the pipeline 'ANDskilstest'
13. Using the guide found [here](https://embeddedartistry.com/blog/2017/12/21/jenkins-kick-off-a-ci-build-with-github-push-notifications/) configure your copy of the repository to allow webhooks.
15. Completing the procedure, use the guide found [here](https://dzone.com/articles/adding-a-github-webhook-in-your-jenkins-pipeline) to add the webhook to your Jenkins server.

The 'Serverless Architecture' version of this project requires a few additional pieces of information from the user, in the form of access and secret keys, in addition to editing of the inputs.tf file to reflect the domain that you own. Conflict is potential, if unlikely, due to the globally unique requirement for bucket names.
