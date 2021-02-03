# Concourse for cloud.gov pages

This will be our first hosted concourse not for our direct use. The goal is to pipeline the full creation and management of this concourse instance. The pipeline for this and any other concourse instances will live in ci.fr.cloud.gov and will be managed by cloud.gov operators.

## Requirements

Use the same:
- Bosh release for concourse
- Ops files:
  - base-resource-defaults.yml
  - compliance.yml
  - driver.yml
  - external-postgres-tls.yml
  - prometheus.yml
  - set-garbage-collection.yml
  - update-strategy.yml

Customize ops files (not included in actions below):
  - config.yml

1. Deploy to a Pages AWS account (we want to keep it seperate from our concourse and our VPCs)

    - [ ] Terraform a VPC
    - [ ] Terraform an IAM User
    - [ ] Install bosh

2. A postgres DB for Concourse

    - [ ] Terraform a postgres instance
    - [ ] Ops file it

3. A secure credential store. We can deploy credhub collocated with concourse for this purpose based on this ops file: https://github.com/concourse/concourse-bosh-deployment/blob/master/cluster/operations/credhub-colocated.yml.  However, we need to use our hardened credhub release in place of the referenced URL.

    - [ ] Build hardened credhub release in cg-harden-boshrelease
    - [ ] Add ops file to install colocated credhub

4. Authentication via cloud.gov IDP. 
  
    - [ ] Set up a client in UAA
    - [ ] Configure an ops file similar to operations/generic-oauth.yml

5. Authorization via concourse team configuration

    - [ ] Add core pages team to the main team auth'd via oauth provider via https://github.com/concourse/concourse-bosh-deployment/blob/master/cluster/operations/add-main-team-oauth-users.yml 

6. Artifact bucket

    - [ ] Create an S3 bucket for artifacts

7. Domain: pages-ci.fr.cloud.gov

    - [ ] Use the same *.fr.cloud.gov certificate
    - [ ] Terraform Route 53

VPN access is not required

