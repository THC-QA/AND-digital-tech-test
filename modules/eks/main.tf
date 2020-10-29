############################################################## EKS CLUSTER + EKS CLUSTER IAM ROLE ##############################################################

resource "aws_eks_cluster" "nginx_eks" {
  name     = "nginx"
  role_arn = aws_iam_role.nginxrole.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    public_access_cidrs = ["0.0.0.0/0"]
    security_group_ids = var.secgroups
    subnet_ids = var.subnets
  }

    depends_on = [
    aws_iam_role_policy_attachment.nginx-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.nginx-AmazonEKSServicePolicy,
  ]
}


resource "aws_iam_role" "nginxrole" {
  name = "eks-nginxrole"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "nginx-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.nginxrole.name
}

resource "aws_iam_role_policy_attachment" "nginx-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.nginxrole.name
}

############################################################## EKS NODE GROUP + EKS NODE GROUP IAM ROLE ##############################################################

resource "aws_eks_node_group" "nginx_eks_nodegrp" {
  cluster_name    = aws_eks_cluster.nginx_eks.name
  node_group_name = "nginx_Node_Groups"
  node_role_arn   = aws_iam_role.nginx_role_node.arn
  subnet_ids      = var.subnets
  instance_types  = var.instance-type #e.g. ["t3a.small"]

  scaling_config {
    min_size     = 1
    max_size     = 3
    desired_size = 1
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.nginx-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nginx-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nginx-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_role" "nginx_role_node" {
  name = "eks-nginx-role-node"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nginx-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nginx_role_node.name
}

resource "aws_iam_role_policy_attachment" "nginx-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nginx_role_node.name
}

resource "aws_iam_role_policy_attachment" "nginx-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nginx_role_node.name
}