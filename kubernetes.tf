locals {
  bastion_autoscaling_group_ids     = [aws_autoscaling_group.bastions-kops-renanfenrich-xyz.id]
  bastion_security_group_ids        = [aws_security_group.bastion-kops-renanfenrich-xyz.id]
  bastions_role_arn                 = aws_iam_role.bastions-kops-renanfenrich-xyz.arn
  bastions_role_name                = aws_iam_role.bastions-kops-renanfenrich-xyz.name
  cluster_name                      = "kops.renanfenrich.xyz"
  master_autoscaling_group_ids      = [aws_autoscaling_group.master-us-east-1a-masters-kops-renanfenrich-xyz.id]
  master_security_group_ids         = [aws_security_group.masters-kops-renanfenrich-xyz.id]
  masters_role_arn                  = aws_iam_role.masters-kops-renanfenrich-xyz.arn
  masters_role_name                 = aws_iam_role.masters-kops-renanfenrich-xyz.name
  node_autoscaling_group_ids        = [aws_autoscaling_group.nodes-us-east-1a-kops-renanfenrich-xyz.id]
  node_security_group_ids           = [aws_security_group.nodes-kops-renanfenrich-xyz.id]
  node_subnet_ids                   = [aws_subnet.us-east-1a-kops-renanfenrich-xyz.id]
  nodes_role_arn                    = aws_iam_role.nodes-kops-renanfenrich-xyz.arn
  nodes_role_name                   = aws_iam_role.nodes-kops-renanfenrich-xyz.name
  region                            = "us-east-1"
  route_table_private-us-east-1a_id = aws_route_table.private-us-east-1a-kops-renanfenrich-xyz.id
  route_table_public_id             = aws_route_table.kops-renanfenrich-xyz.id
  subnet_us-east-1a_id              = aws_subnet.us-east-1a-kops-renanfenrich-xyz.id
  subnet_utility-us-east-1a_id      = aws_subnet.utility-us-east-1a-kops-renanfenrich-xyz.id
  vpc_cidr_block                    = aws_vpc.kops-renanfenrich-xyz.cidr_block
  vpc_id                            = aws_vpc.kops-renanfenrich-xyz.id
}

output "bastion_autoscaling_group_ids" {
  value = [aws_autoscaling_group.bastions-kops-renanfenrich-xyz.id]
}

output "bastion_security_group_ids" {
  value = [aws_security_group.bastion-kops-renanfenrich-xyz.id]
}

output "bastions_role_arn" {
  value = aws_iam_role.bastions-kops-renanfenrich-xyz.arn
}

output "bastions_role_name" {
  value = aws_iam_role.bastions-kops-renanfenrich-xyz.name
}

output "cluster_name" {
  value = "kops.renanfenrich.xyz"
}

output "master_autoscaling_group_ids" {
  value = [aws_autoscaling_group.master-us-east-1a-masters-kops-renanfenrich-xyz.id]
}

output "master_security_group_ids" {
  value = [aws_security_group.masters-kops-renanfenrich-xyz.id]
}

output "masters_role_arn" {
  value = aws_iam_role.masters-kops-renanfenrich-xyz.arn
}

output "masters_role_name" {
  value = aws_iam_role.masters-kops-renanfenrich-xyz.name
}

output "node_autoscaling_group_ids" {
  value = [aws_autoscaling_group.nodes-us-east-1a-kops-renanfenrich-xyz.id]
}

output "node_security_group_ids" {
  value = [aws_security_group.nodes-kops-renanfenrich-xyz.id]
}

output "node_subnet_ids" {
  value = [aws_subnet.us-east-1a-kops-renanfenrich-xyz.id]
}

output "nodes_role_arn" {
  value = aws_iam_role.nodes-kops-renanfenrich-xyz.arn
}

output "nodes_role_name" {
  value = aws_iam_role.nodes-kops-renanfenrich-xyz.name
}

output "region" {
  value = "us-east-1"
}

output "route_table_private-us-east-1a_id" {
  value = aws_route_table.private-us-east-1a-kops-renanfenrich-xyz.id
}

output "route_table_public_id" {
  value = aws_route_table.kops-renanfenrich-xyz.id
}

output "subnet_us-east-1a_id" {
  value = aws_subnet.us-east-1a-kops-renanfenrich-xyz.id
}

output "subnet_utility-us-east-1a_id" {
  value = aws_subnet.utility-us-east-1a-kops-renanfenrich-xyz.id
}

output "vpc_cidr_block" {
  value = aws_vpc.kops-renanfenrich-xyz.cidr_block
}

output "vpc_id" {
  value = aws_vpc.kops-renanfenrich-xyz.id
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "files"
  region = "us-east-1"
}

resource "aws_autoscaling_group" "bastions-kops-renanfenrich-xyz" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.bastions-kops-renanfenrich-xyz.id
    version = aws_launch_template.bastions-kops-renanfenrich-xyz.latest_version
  }
  load_balancers        = [aws_elb.bastion-kops-renanfenrich-xyz.id]
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "bastions.kops.renanfenrich.xyz"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "kops.renanfenrich.xyz"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "bastions.kops.renanfenrich.xyz"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "bastions"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"
    propagate_at_launch = true
    value               = "node"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/bastion"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "bastions"
  }
  tag {
    key                 = "kubernetes.io/cluster/kops.renanfenrich.xyz"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-east-1a-kops-renanfenrich-xyz.id]
}

resource "aws_autoscaling_group" "master-us-east-1a-masters-kops-renanfenrich-xyz" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.master-us-east-1a-masters-kops-renanfenrich-xyz.id
    version = aws_launch_template.master-us-east-1a-masters-kops-renanfenrich-xyz.latest_version
  }
  load_balancers        = [aws_elb.api-kops-renanfenrich-xyz.id]
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "master-us-east-1a.masters.kops.renanfenrich.xyz"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "kops.renanfenrich.xyz"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "master-us-east-1a.masters.kops.renanfenrich.xyz"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "master-us-east-1a"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"
    propagate_at_launch = true
    value               = "master"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/master"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/master"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "master-us-east-1a"
  }
  tag {
    key                 = "kubernetes.io/cluster/kops.renanfenrich.xyz"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-east-1a-kops-renanfenrich-xyz.id]
}

resource "aws_autoscaling_group" "nodes-us-east-1a-kops-renanfenrich-xyz" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.nodes-us-east-1a-kops-renanfenrich-xyz.id
    version = aws_launch_template.nodes-us-east-1a-kops-renanfenrich-xyz.latest_version
  }
  max_size              = 3
  metrics_granularity   = "1Minute"
  min_size              = 3
  name                  = "nodes-us-east-1a.kops.renanfenrich.xyz"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "kops.renanfenrich.xyz"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "nodes-us-east-1a.kops.renanfenrich.xyz"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "nodes-us-east-1a"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"
    propagate_at_launch = true
    value               = "node"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/node"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "nodes-us-east-1a"
  }
  tag {
    key                 = "kubernetes.io/cluster/kops.renanfenrich.xyz"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-east-1a-kops-renanfenrich-xyz.id]
}

resource "aws_ebs_volume" "a-etcd-events-kops-renanfenrich-xyz" {
  availability_zone = "us-east-1a"
  encrypted         = true
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "a.etcd-events.kops.renanfenrich.xyz"
    "k8s.io/etcd/events"                          = "a/a"
    "k8s.io/role/master"                          = "1"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_ebs_volume" "a-etcd-main-kops-renanfenrich-xyz" {
  availability_zone = "us-east-1a"
  encrypted         = true
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "a.etcd-main.kops.renanfenrich.xyz"
    "k8s.io/etcd/main"                            = "a/a"
    "k8s.io/role/master"                          = "1"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_eip" "us-east-1a-kops-renanfenrich-xyz" {
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "us-east-1a.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
  vpc = true
}

resource "aws_elb" "api-kops-renanfenrich-xyz" {
  connection_draining         = true
  connection_draining_timeout = 300
  cross_zone_load_balancing   = false
  health_check {
    healthy_threshold   = 2
    interval            = 10
    target              = "SSL:443"
    timeout             = 5
    unhealthy_threshold = 2
  }
  idle_timeout = 300
  listener {
    instance_port     = 443
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }
  name            = "api-kops-renanfenrich-xyz-m3dqbf"
  security_groups = [aws_security_group.api-elb-kops-renanfenrich-xyz.id]
  subnets         = [aws_subnet.utility-us-east-1a-kops-renanfenrich-xyz.id]
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "api.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
}

resource "aws_elb" "bastion-kops-renanfenrich-xyz" {
  health_check {
    healthy_threshold   = 2
    interval            = 10
    target              = "TCP:22"
    timeout             = 5
    unhealthy_threshold = 2
  }
  idle_timeout = 300
  listener {
    instance_port     = 22
    instance_protocol = "TCP"
    lb_port           = 22
    lb_protocol       = "TCP"
  }
  name            = "bastion-kops-renanfenrich-toqck5"
  security_groups = [aws_security_group.bastion-elb-kops-renanfenrich-xyz.id]
  subnets         = [aws_subnet.utility-us-east-1a-kops-renanfenrich-xyz.id]
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "bastion.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
}

resource "aws_iam_instance_profile" "bastions-kops-renanfenrich-xyz" {
  name = "bastions.kops.renanfenrich.xyz"
  role = aws_iam_role.bastions-kops-renanfenrich-xyz.name
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "bastions.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-kops-renanfenrich-xyz" {
  name = "masters.kops.renanfenrich.xyz"
  role = aws_iam_role.masters-kops-renanfenrich-xyz.name
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "masters.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
}

resource "aws_iam_instance_profile" "nodes-kops-renanfenrich-xyz" {
  name = "nodes.kops.renanfenrich.xyz"
  role = aws_iam_role.nodes-kops-renanfenrich-xyz.name
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "nodes.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
}

resource "aws_iam_role" "bastions-kops-renanfenrich-xyz" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_bastions.kops.renanfenrich.xyz_policy")
  name               = "bastions.kops.renanfenrich.xyz"
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "bastions.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
}

resource "aws_iam_role" "masters-kops-renanfenrich-xyz" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_masters.kops.renanfenrich.xyz_policy")
  name               = "masters.kops.renanfenrich.xyz"
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "masters.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
}

resource "aws_iam_role" "nodes-kops-renanfenrich-xyz" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_nodes.kops.renanfenrich.xyz_policy")
  name               = "nodes.kops.renanfenrich.xyz"
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "nodes.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
}

resource "aws_iam_role_policy" "bastions-kops-renanfenrich-xyz" {
  name   = "bastions.kops.renanfenrich.xyz"
  policy = file("${path.module}/data/aws_iam_role_policy_bastions.kops.renanfenrich.xyz_policy")
  role   = aws_iam_role.bastions-kops-renanfenrich-xyz.name
}

resource "aws_iam_role_policy" "masters-kops-renanfenrich-xyz" {
  name   = "masters.kops.renanfenrich.xyz"
  policy = file("${path.module}/data/aws_iam_role_policy_masters.kops.renanfenrich.xyz_policy")
  role   = aws_iam_role.masters-kops-renanfenrich-xyz.name
}

resource "aws_iam_role_policy" "nodes-kops-renanfenrich-xyz" {
  name   = "nodes.kops.renanfenrich.xyz"
  policy = file("${path.module}/data/aws_iam_role_policy_nodes.kops.renanfenrich.xyz_policy")
  role   = aws_iam_role.nodes-kops-renanfenrich-xyz.name
}

resource "aws_internet_gateway" "kops-renanfenrich-xyz" {
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
  vpc_id = aws_vpc.kops-renanfenrich-xyz.id
}

resource "aws_launch_template" "bastions-kops-renanfenrich-xyz" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 32
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.bastions-kops-renanfenrich-xyz.id
  }
  image_id      = "ami-0fd63e471b04e22d0"
  instance_type = "t3.micro"
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "bastions.kops.renanfenrich.xyz"
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.bastion-kops-renanfenrich-xyz.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                          = "kops.renanfenrich.xyz"
      "Name"                                                                       = "bastions.kops.renanfenrich.xyz"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"    = "bastions"
      "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"           = "node"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/bastion"                                                        = "1"
      "kops.k8s.io/instancegroup"                                                  = "bastions"
      "kubernetes.io/cluster/kops.renanfenrich.xyz"                                = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                          = "kops.renanfenrich.xyz"
      "Name"                                                                       = "bastions.kops.renanfenrich.xyz"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"    = "bastions"
      "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"           = "node"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/bastion"                                                        = "1"
      "kops.k8s.io/instancegroup"                                                  = "bastions"
      "kubernetes.io/cluster/kops.renanfenrich.xyz"                                = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                          = "kops.renanfenrich.xyz"
    "Name"                                                                       = "bastions.kops.renanfenrich.xyz"
    "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"    = "bastions"
    "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"           = "node"
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
    "k8s.io/role/bastion"                                                        = "1"
    "kops.k8s.io/instancegroup"                                                  = "bastions"
    "kubernetes.io/cluster/kops.renanfenrich.xyz"                                = "owned"
  }
}

resource "aws_launch_template" "master-us-east-1a-masters-kops-renanfenrich-xyz" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 64
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.masters-kops-renanfenrich-xyz.id
  }
  image_id      = "ami-0fd63e471b04e22d0"
  instance_type = "t3.micro"
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 3
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "master-us-east-1a.masters.kops.renanfenrich.xyz"
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.masters-kops-renanfenrich-xyz.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                                                     = "kops.renanfenrich.xyz"
      "Name"                                                                                                  = "master-us-east-1a.masters.kops.renanfenrich.xyz"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"                               = "master-us-east-1a"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"                                      = "master"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/master"                          = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "master-us-east-1a"
      "kubernetes.io/cluster/kops.renanfenrich.xyz"                                                           = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                                                     = "kops.renanfenrich.xyz"
      "Name"                                                                                                  = "master-us-east-1a.masters.kops.renanfenrich.xyz"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"                               = "master-us-east-1a"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"                                      = "master"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/master"                          = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "master-us-east-1a"
      "kubernetes.io/cluster/kops.renanfenrich.xyz"                                                           = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                                                     = "kops.renanfenrich.xyz"
    "Name"                                                                                                  = "master-us-east-1a.masters.kops.renanfenrich.xyz"
    "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"                               = "master-us-east-1a"
    "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
    "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"                                      = "master"
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/master"                          = ""
    "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
    "k8s.io/role/master"                                                                                    = "1"
    "kops.k8s.io/instancegroup"                                                                             = "master-us-east-1a"
    "kubernetes.io/cluster/kops.renanfenrich.xyz"                                                           = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_master-us-east-1a.masters.kops.renanfenrich.xyz_user_data")
}

resource "aws_launch_template" "nodes-us-east-1a-kops-renanfenrich-xyz" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 128
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.nodes-kops-renanfenrich-xyz.id
  }
  image_id      = "ami-0fd63e471b04e22d0"
  instance_type = "t3.micro"
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "nodes-us-east-1a.kops.renanfenrich.xyz"
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.nodes-kops-renanfenrich-xyz.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                          = "kops.renanfenrich.xyz"
      "Name"                                                                       = "nodes-us-east-1a.kops.renanfenrich.xyz"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"    = "nodes-us-east-1a"
      "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"           = "node"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1a"
      "kubernetes.io/cluster/kops.renanfenrich.xyz"                                = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                          = "kops.renanfenrich.xyz"
      "Name"                                                                       = "nodes-us-east-1a.kops.renanfenrich.xyz"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"    = "nodes-us-east-1a"
      "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"           = "node"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1a"
      "kubernetes.io/cluster/kops.renanfenrich.xyz"                                = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                          = "kops.renanfenrich.xyz"
    "Name"                                                                       = "nodes-us-east-1a.kops.renanfenrich.xyz"
    "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"    = "nodes-us-east-1a"
    "k8s.io/cluster-autoscaler/node-template/label/kubernetes.io/role"           = "node"
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
    "k8s.io/role/node"                                                           = "1"
    "kops.k8s.io/instancegroup"                                                  = "nodes-us-east-1a"
    "kubernetes.io/cluster/kops.renanfenrich.xyz"                                = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_nodes-us-east-1a.kops.renanfenrich.xyz_user_data")
}

resource "aws_nat_gateway" "us-east-1a-kops-renanfenrich-xyz" {
  allocation_id = aws_eip.us-east-1a-kops-renanfenrich-xyz.id
  subnet_id     = aws_subnet.utility-us-east-1a-kops-renanfenrich-xyz.id
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "us-east-1a.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
}

resource "aws_route" "route-0-0-0-0--0" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.kops-renanfenrich-xyz.id
  route_table_id         = aws_route_table.kops-renanfenrich-xyz.id
}

resource "aws_route" "route-__--0" {
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.kops-renanfenrich-xyz.id
  route_table_id              = aws_route_table.kops-renanfenrich-xyz.id
}

resource "aws_route" "route-private-us-east-1a-0-0-0-0--0" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.us-east-1a-kops-renanfenrich-xyz.id
  route_table_id         = aws_route_table.private-us-east-1a-kops-renanfenrich-xyz.id
}

resource "aws_route53_record" "api-kops-renanfenrich-xyz" {
  alias {
    evaluate_target_health = false
    name                   = aws_elb.api-kops-renanfenrich-xyz.dns_name
    zone_id                = aws_elb.api-kops-renanfenrich-xyz.zone_id
  }
  name    = "api.kops.renanfenrich.xyz"
  type    = "A"
  zone_id = "/hostedzone/Z01210839B1WRBUMRAWY"
}

resource "aws_route53_record" "bastion-kops-renanfenrich-xyz" {
  alias {
    evaluate_target_health = false
    name                   = aws_elb.bastion-kops-renanfenrich-xyz.dns_name
    zone_id                = aws_elb.bastion-kops-renanfenrich-xyz.zone_id
  }
  name    = "bastion.kops.renanfenrich.xyz"
  type    = "A"
  zone_id = "/hostedzone/Z01210839B1WRBUMRAWY"
}

resource "aws_route_table" "kops-renanfenrich-xyz" {
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
    "kubernetes.io/kops/role"                     = "public"
  }
  vpc_id = aws_vpc.kops-renanfenrich-xyz.id
}

resource "aws_route_table" "private-us-east-1a-kops-renanfenrich-xyz" {
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "private-us-east-1a.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
    "kubernetes.io/kops/role"                     = "private-us-east-1a"
  }
  vpc_id = aws_vpc.kops-renanfenrich-xyz.id
}

resource "aws_route_table_association" "private-us-east-1a-kops-renanfenrich-xyz" {
  route_table_id = aws_route_table.private-us-east-1a-kops-renanfenrich-xyz.id
  subnet_id      = aws_subnet.us-east-1a-kops-renanfenrich-xyz.id
}

resource "aws_route_table_association" "utility-us-east-1a-kops-renanfenrich-xyz" {
  route_table_id = aws_route_table.kops-renanfenrich-xyz.id
  subnet_id      = aws_subnet.utility-us-east-1a-kops-renanfenrich-xyz.id
}

resource "aws_s3_bucket_object" "cluster-completed-spec" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_cluster-completed.spec_content")
  key                    = "kops.renanfenrich.xyz/cluster-completed.spec"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "etcd-cluster-spec-events" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_etcd-cluster-spec-events_content")
  key                    = "kops.renanfenrich.xyz/backups/etcd/events/control/etcd-cluster-spec"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "etcd-cluster-spec-main" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_etcd-cluster-spec-main_content")
  key                    = "kops.renanfenrich.xyz/backups/etcd/main/control/etcd-cluster-spec"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "kops-renanfenrich-xyz-addons-aws-ebs-csi-driver-addons-k8s-io-k8s-1-17" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_kops.renanfenrich.xyz-addons-aws-ebs-csi-driver.addons.k8s.io-k8s-1.17_content")
  key                    = "kops.renanfenrich.xyz/addons/aws-ebs-csi-driver.addons.k8s.io/k8s-1.17.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "kops-renanfenrich-xyz-addons-bootstrap" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_kops.renanfenrich.xyz-addons-bootstrap_content")
  key                    = "kops.renanfenrich.xyz/addons/bootstrap-channel.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "kops-renanfenrich-xyz-addons-core-addons-k8s-io" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_kops.renanfenrich.xyz-addons-core.addons.k8s.io_content")
  key                    = "kops.renanfenrich.xyz/addons/core.addons.k8s.io/v1.4.0.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "kops-renanfenrich-xyz-addons-coredns-addons-k8s-io-k8s-1-12" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_kops.renanfenrich.xyz-addons-coredns.addons.k8s.io-k8s-1.12_content")
  key                    = "kops.renanfenrich.xyz/addons/coredns.addons.k8s.io/k8s-1.12.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "kops-renanfenrich-xyz-addons-dns-controller-addons-k8s-io-k8s-1-12" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_kops.renanfenrich.xyz-addons-dns-controller.addons.k8s.io-k8s-1.12_content")
  key                    = "kops.renanfenrich.xyz/addons/dns-controller.addons.k8s.io/k8s-1.12.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "kops-renanfenrich-xyz-addons-kops-controller-addons-k8s-io-k8s-1-16" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_kops.renanfenrich.xyz-addons-kops-controller.addons.k8s.io-k8s-1.16_content")
  key                    = "kops.renanfenrich.xyz/addons/kops-controller.addons.k8s.io/k8s-1.16.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "kops-renanfenrich-xyz-addons-kubelet-api-rbac-addons-k8s-io-k8s-1-9" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_kops.renanfenrich.xyz-addons-kubelet-api.rbac.addons.k8s.io-k8s-1.9_content")
  key                    = "kops.renanfenrich.xyz/addons/kubelet-api.rbac.addons.k8s.io/k8s-1.9.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "kops-renanfenrich-xyz-addons-leader-migration-rbac-addons-k8s-io-k8s-1-23" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_kops.renanfenrich.xyz-addons-leader-migration.rbac.addons.k8s.io-k8s-1.23_content")
  key                    = "kops.renanfenrich.xyz/addons/leader-migration.rbac.addons.k8s.io/k8s-1.23.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "kops-renanfenrich-xyz-addons-limit-range-addons-k8s-io" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_kops.renanfenrich.xyz-addons-limit-range.addons.k8s.io_content")
  key                    = "kops.renanfenrich.xyz/addons/limit-range.addons.k8s.io/v1.5.0.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "kops-renanfenrich-xyz-addons-networking-amazon-vpc-routed-eni-k8s-1-16" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_kops.renanfenrich.xyz-addons-networking.amazon-vpc-routed-eni-k8s-1.16_content")
  key                    = "kops.renanfenrich.xyz/addons/networking.amazon-vpc-routed-eni/k8s-1.16.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "kops-renanfenrich-xyz-addons-storage-aws-addons-k8s-io-v1-15-0" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_kops.renanfenrich.xyz-addons-storage-aws.addons.k8s.io-v1.15.0_content")
  key                    = "kops.renanfenrich.xyz/addons/storage-aws.addons.k8s.io/v1.15.0.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "kops-version-txt" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_kops-version.txt_content")
  key                    = "kops.renanfenrich.xyz/kops-version.txt"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "manifests-etcdmanager-events" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_manifests-etcdmanager-events_content")
  key                    = "kops.renanfenrich.xyz/manifests/etcd/events.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "manifests-etcdmanager-main" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_manifests-etcdmanager-main_content")
  key                    = "kops.renanfenrich.xyz/manifests/etcd/main.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "manifests-static-kube-apiserver-healthcheck" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_manifests-static-kube-apiserver-healthcheck_content")
  key                    = "kops.renanfenrich.xyz/manifests/static/kube-apiserver-healthcheck.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "nodeupconfig-master-us-east-1a" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_nodeupconfig-master-us-east-1a_content")
  key                    = "kops.renanfenrich.xyz/igconfig/master/master-us-east-1a/nodeupconfig.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "nodeupconfig-nodes-us-east-1a" {
  bucket                 = "kops.renanfenrich.xyz"
  content                = file("${path.module}/data/aws_s3_bucket_object_nodeupconfig-nodes-us-east-1a_content")
  key                    = "kops.renanfenrich.xyz/igconfig/node/nodes-us-east-1a/nodeupconfig.yaml"
  provider               = aws.files
  server_side_encryption = "AES256"
}

resource "aws_security_group" "api-elb-kops-renanfenrich-xyz" {
  description = "Security group for api ELB"
  name        = "api-elb.kops.renanfenrich.xyz"
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "api-elb.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
  vpc_id = aws_vpc.kops-renanfenrich-xyz.id
}

resource "aws_security_group" "bastion-elb-kops-renanfenrich-xyz" {
  description = "Security group for bastion ELB"
  name        = "bastion-elb.kops.renanfenrich.xyz"
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "bastion-elb.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
  vpc_id = aws_vpc.kops-renanfenrich-xyz.id
}

resource "aws_security_group" "bastion-kops-renanfenrich-xyz" {
  description = "Security group for bastion"
  name        = "bastion.kops.renanfenrich.xyz"
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "bastion.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
  vpc_id = aws_vpc.kops-renanfenrich-xyz.id
}

resource "aws_security_group" "masters-kops-renanfenrich-xyz" {
  description = "Security group for masters"
  name        = "masters.kops.renanfenrich.xyz"
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "masters.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
  vpc_id = aws_vpc.kops-renanfenrich-xyz.id
}

resource "aws_security_group" "nodes-kops-renanfenrich-xyz" {
  description = "Security group for nodes"
  name        = "nodes.kops.renanfenrich.xyz"
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "nodes.kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
  vpc_id = aws_vpc.kops-renanfenrich-xyz.id
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-22to22-bastion-elb-kops-renanfenrich-xyz" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion-elb-kops-renanfenrich-xyz.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-443to443-api-elb-kops-renanfenrich-xyz" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.api-elb-kops-renanfenrich-xyz.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-22to22-bastion-elb-kops-renanfenrich-xyz" {
  from_port         = 22
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion-elb-kops-renanfenrich-xyz.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-443to443-api-elb-kops-renanfenrich-xyz" {
  from_port         = 443
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.api-elb-kops-renanfenrich-xyz.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "from-api-elb-kops-renanfenrich-xyz-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.api-elb-kops-renanfenrich-xyz.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-api-elb-kops-renanfenrich-xyz-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.api-elb-kops-renanfenrich-xyz.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-elb-kops-renanfenrich-xyz-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-elb-kops-renanfenrich-xyz.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-elb-kops-renanfenrich-xyz-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-elb-kops-renanfenrich-xyz.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-elb-kops-renanfenrich-xyz-ingress-tcp-22to22-bastion-kops-renanfenrich-xyz" {
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.bastion-kops-renanfenrich-xyz.id
  source_security_group_id = aws_security_group.bastion-elb-kops-renanfenrich-xyz.id
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-bastion-kops-renanfenrich-xyz-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-kops-renanfenrich-xyz.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-kops-renanfenrich-xyz-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-kops-renanfenrich-xyz.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-kops-renanfenrich-xyz-ingress-tcp-22to22-masters-kops-renanfenrich-xyz" {
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-kops-renanfenrich-xyz.id
  source_security_group_id = aws_security_group.bastion-kops-renanfenrich-xyz.id
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-bastion-kops-renanfenrich-xyz-ingress-tcp-22to22-nodes-kops-renanfenrich-xyz" {
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nodes-kops-renanfenrich-xyz.id
  source_security_group_id = aws_security_group.bastion-kops-renanfenrich-xyz.id
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-masters-kops-renanfenrich-xyz-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.masters-kops-renanfenrich-xyz.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-kops-renanfenrich-xyz-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.masters-kops-renanfenrich-xyz.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-kops-renanfenrich-xyz-ingress-all-0to0-masters-kops-renanfenrich-xyz" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.masters-kops-renanfenrich-xyz.id
  source_security_group_id = aws_security_group.masters-kops-renanfenrich-xyz.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-masters-kops-renanfenrich-xyz-ingress-all-0to0-nodes-kops-renanfenrich-xyz" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-kops-renanfenrich-xyz.id
  source_security_group_id = aws_security_group.masters-kops-renanfenrich-xyz.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-kops-renanfenrich-xyz-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-kops-renanfenrich-xyz.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-kops-renanfenrich-xyz-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-kops-renanfenrich-xyz.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-kops-renanfenrich-xyz-ingress-all-0to0-masters-kops-renanfenrich-xyz" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.masters-kops-renanfenrich-xyz.id
  source_security_group_id = aws_security_group.nodes-kops-renanfenrich-xyz.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-kops-renanfenrich-xyz-ingress-all-0to0-nodes-kops-renanfenrich-xyz" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-kops-renanfenrich-xyz.id
  source_security_group_id = aws_security_group.nodes-kops-renanfenrich-xyz.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-kops-renanfenrich-xyz-ingress-tcp-1to2379-masters-kops-renanfenrich-xyz" {
  from_port                = 1
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-kops-renanfenrich-xyz.id
  source_security_group_id = aws_security_group.nodes-kops-renanfenrich-xyz.id
  to_port                  = 2379
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-kops-renanfenrich-xyz-ingress-tcp-2382to4000-masters-kops-renanfenrich-xyz" {
  from_port                = 2382
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-kops-renanfenrich-xyz.id
  source_security_group_id = aws_security_group.nodes-kops-renanfenrich-xyz.id
  to_port                  = 4000
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-kops-renanfenrich-xyz-ingress-tcp-4003to65535-masters-kops-renanfenrich-xyz" {
  from_port                = 4003
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-kops-renanfenrich-xyz.id
  source_security_group_id = aws_security_group.nodes-kops-renanfenrich-xyz.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-kops-renanfenrich-xyz-ingress-udp-1to65535-masters-kops-renanfenrich-xyz" {
  from_port                = 1
  protocol                 = "udp"
  security_group_id        = aws_security_group.masters-kops-renanfenrich-xyz.id
  source_security_group_id = aws_security_group.nodes-kops-renanfenrich-xyz.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "https-elb-to-master" {
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-kops-renanfenrich-xyz.id
  source_security_group_id = aws_security_group.api-elb-kops-renanfenrich-xyz.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "icmp-pmtu-api-elb-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 3
  protocol          = "icmp"
  security_group_id = aws_security_group.api-elb-kops-renanfenrich-xyz.id
  to_port           = 4
  type              = "ingress"
}

resource "aws_security_group_rule" "icmpv6-pmtu-api-elb-__--0" {
  from_port         = -1
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "icmpv6"
  security_group_id = aws_security_group.api-elb-kops-renanfenrich-xyz.id
  to_port           = -1
  type              = "ingress"
}

resource "aws_subnet" "us-east-1a-kops-renanfenrich-xyz" {
  availability_zone = "us-east-1a"
  cidr_block        = "172.20.32.0/19"
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "us-east-1a.kops.renanfenrich.xyz"
    "SubnetType"                                  = "Private"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
    "kubernetes.io/role/internal-elb"             = "1"
  }
  vpc_id = aws_vpc.kops-renanfenrich-xyz.id
}

resource "aws_subnet" "utility-us-east-1a-kops-renanfenrich-xyz" {
  availability_zone = "us-east-1a"
  cidr_block        = "172.20.0.0/22"
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "utility-us-east-1a.kops.renanfenrich.xyz"
    "SubnetType"                                  = "Utility"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
    "kubernetes.io/role/elb"                      = "1"
  }
  vpc_id = aws_vpc.kops-renanfenrich-xyz.id
}

resource "aws_vpc" "kops-renanfenrich-xyz" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = "172.20.0.0/16"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "kops-renanfenrich-xyz" {
  domain_name         = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = {
    "KubernetesCluster"                           = "kops.renanfenrich.xyz"
    "Name"                                        = "kops.renanfenrich.xyz"
    "kubernetes.io/cluster/kops.renanfenrich.xyz" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "kops-renanfenrich-xyz" {
  dhcp_options_id = aws_vpc_dhcp_options.kops-renanfenrich-xyz.id
  vpc_id          = aws_vpc.kops-renanfenrich-xyz.id
}

terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      "configuration_aliases" = [aws.files]
      "source"                = "hashicorp/aws"
      "version"               = ">= 3.59.0"
    }
  }
}
