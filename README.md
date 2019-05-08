[![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-compute-firewall/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-compute-firewall/job/master/)
# DC/OS Network Firewall Rules

The firewall module creates four different policies to be used by provisioning DC/OS Infrastructure

## EXAMPLE

```hcl
module "dcos-compute-firewall" {
  source  = "dcos-terraform/compute-firewall/gcp"
  version = "~> 0.1.0"

  network = "network_self_link"
  internal_subnets = "172.12.0.0/16"
  admin_ips = ["1.2.3.4/32"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin\_ips | List of CIDR admin IPs | list | n/a | yes |
| cluster\_name | Name of the DC/OS cluster | string | n/a | yes |
| internal\_subnets | List of internal subnets to allow traffic between them | list | n/a | yes |
| network | Network Name | string | n/a | yes |
| public\_agents\_additional\_ports | List of additional ports allowed for public access on public agents (80 and 443 open by default) | list | `<list>` | no |
| public\_agents\_ips | List of ips allowed access to public agents. admin_ips are joined to this list | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| name\_prefix | Cluster Name |
| network | Network Name |

