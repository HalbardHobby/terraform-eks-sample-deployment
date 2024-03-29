data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.66.0"

  name                 = "pipeline-vpc"
  cidr                 = "32.16.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["32.16.1.0/24", "32.16.2.0/24", "32.16.3.0/24"]
  public_subnets       = ["32.16.4.0/24", "32.16.5.0/24", "32.16.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
