module "eks" {
  source = "terraform-aws-modules/eks/aws"
  cluster_name = var.cluster_name
  cluster_version = "1.20"
  subnets = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name = "worker-group"
      instance_type = "t2.small"
      asg_desired_capacity = 3
    }
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
