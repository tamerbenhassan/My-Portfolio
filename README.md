# Tamer Benhassan's Portfolio Website

## Overview

This repository contains the code for my personal portfolio website, which showcases my professional journey and skills in DevOps and Cloud Engineering. The frontend is crafted with Webflow and exported to GitHub. The backend infrastructure is hosted on AWS, provisioned with Terraform.

![Architecture Diagram](Architecture.png)


## Architecture

The website operates on AWS and utilizes the following services:

- **Amazon S3**:
  - `s3-bucket-resume`: Stores my resume in PDF format.
  - `s3-bucket-website`: Hosts the static files for the website.
- **Amazon CloudFront**: Distributes the website content globally with an S3 endpoint.
- **AWS Certificate Manager (ACM)**: Provides a TLS certificate to secure the website.
- **Amazon Route 53**: Manages the DNS settings with Alias records for CloudFront distribution to support `tamerbenhassan.com` and `www.tamerbenhassan.com`.
- **Amazon Simple Notification Service (SNS)**: Sends real-time notifications on the AWS CodePipeline's status via email.

## CI/CD

- **AWS CodePipeline**: Automates the deployment process, triggered by any push to the `main` branch of this GitHub repository.
- **AWS CodeBuild**: Executes build specifications to exclude Terraform and buildspec files from being uploaded to the S3 website bucket.

## Notifications

- Real-time notifications are sent through an SNS topic, keeping subscribers updated on the deployment process.

## DNS Configuration

- **Route 53**:
  - Two Alias records point to the CloudFront distribution.
  - Two CNAME records are configured for ACM DNS validation.

## Security

- The website is served over HTTPS, enforced by CloudFront's viewer protocol policy.
- The ACM certificate is attached to the CloudFront distribution to secure communication.

## Usage

### Prerequisites

- AWS CLI configured with appropriate permissions.
- Terraform installed locally.

### Deployment

To deploy the infrastructure, run:

terraform init 

terraform apply
