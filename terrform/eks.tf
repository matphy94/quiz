provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 18.0"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids         = module.vpc.public_subnets

  vpc_id = module.vpc.vpc_id


  eks_managed_node_groups = {
    one = {
      min_size     = 1
      max_size     = 4
      desired_size = 2
      instance_types = ["t3.micro"]
      create_security_group = false
    }
  }

    cluster_security_group_id = aws_security_group.worker_group_mgmt_one.id

}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
