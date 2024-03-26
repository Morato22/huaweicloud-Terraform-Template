# Create a VPC to CCE
resource "huaweicloud_vpc" "vpc-cce" {
  count = var.cce_tf ? 1 : 0
  name  = var.vpc-tf-cce_name
  cidr  = var.vpc-tf-cce_cidr
}

# Create a Subnet to CCE
resource "huaweicloud_vpc_subnet" "subnet-cce" {
  count      = var.cce_tf ? 1 : 0
  name       = var.subnet-tf-cce_name
  cidr       = var.subnet-tf-cce_cidr
  gateway_ip = var.subnet-tf-cce_gateway
  vpc_id     = huaweicloud_vpc.vpc-cce[0].id
}

# Create an EIP to CCE
resource "huaweicloud_vpc_eip" "eip-tf-cce" {
  count = var.cce_tf ? 1 : 0
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = var.eip-tf-cce_name
    size        = var.eip-tf-cce_size
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

# Create the cluster
resource "huaweicloud_cce_cluster" "cluster-tf" {
  count                  = var.cce_tf ? 1 : 0
  name                   = var.cluster-tf_name
  flavor_id              = var.cluster-tf_flavor
  vpc_id                 = length(huaweicloud_vpc.vpc-cce) == 0 ? null : element(huaweicloud_vpc.vpc-cce[*].id, 0)
  subnet_id              = length(huaweicloud_vpc.vpc-cce) == 0 ? null : element(huaweicloud_vpc_subnet.subnet-cce[*].id, 0)
  container_network_type = var.cluster-tf_network
  cluster_version        = var.cluster-tf_version
  eip                    = length(huaweicloud_vpc.vpc-cce) == 0 ? null : element(huaweicloud_vpc_eip.eip-tf-cce[*].address, 0)
}

resource "huaweicloud_cce_node_pool" "node_pool" {
  for_each = var.create_node_pool ? {for index in var.cce_node_pool : index.cce_np_name => index} : {}
  cluster_id               = huaweicloud_cce_cluster.cluster-tf[0].id
  name                     = each.value.cce_np_name
  os                       = each.value.cce_np_os
  password                 = each.value.cce_np_password 
  flavor_id                = each.value.cce_np_flavor
  initial_node_count       = each.value.cce_np_count
  scall_enable             = each.value.cce_np_scall
  min_node_count           = each.value.cce_np_min_count
  max_node_count           = each.value.cce_np_max_count
  scale_down_cooldown_time = each.value.cce_np_scaledown
  priority                 = each.value.cce_np_priority
  type                     = each.value.cce_np_type

  root_volume {
    size       = each.value.cce_np_rootsize
    volumetype = each.value.cce_np_rootvolume
  }

  data_volumes {
    size       = each.value.cce_np_size
    volumetype = each.value.cce_np_volume
  }
}

resource "huaweicloud_cce_node" "node" {
  for_each = var.create_node ? {for index in var.cce_node : index.cce_node_name => index} : {}
  cluster_id        = length(huaweicloud_cce_cluster.cluster-tf) == 0 ? null : element(huaweicloud_cce_cluster.cluster-tf[*].id, 0)
  name              = each.value.cce_node_name
  os                = each.value.cce_node_os
  flavor_id         = each.value.cce_node_flavor
  availability_zone = data.huaweicloud_availability_zones.azs.names[0]
  password          = each.value.cce_node_password


  root_volume {
    size       = each.value.cce_noderoot_size
    volumetype = each.value.cce_noderoot_type
  }
  data_volumes {
    size       = each.value.cce_node_size
    volumetype = each.value.cce_node_type
  }

  // Assign EIP
  iptype                = "5_bgp"
  bandwidth_charge_mode = each.value.cce_node_eip_chargemode
  sharetype             = "PER"
  bandwidth_size        = each.value.cce_node_eip_size
}

# CCE Addons
locals {
  elb_id = length(huaweicloud_elb_loadbalancer.dedicated[*].id) == 0 ? null : element(huaweicloud_elb_loadbalancer.dedicated[*].id, 0)
}

# Addon Autoscaler
data "huaweicloud_cce_addon_template" "addon_autoscaler_template" {
  count = var.cce_tf ? 1 : 0
  name       = "autoscaler"
  cluster_id = length(huaweicloud_cce_cluster.cluster-tf) == 0 ? null : element(huaweicloud_cce_cluster.cluster-tf[*].id, 0)
  version    = "1.27.53"
}

resource "huaweicloud_cce_addon" "addon_autoscaler" {
  count = var.create_autoscaler_addon ? 1 : 0
  template_name = "autoscaler"
  version       = "1.27.53"
  cluster_id = length(huaweicloud_cce_cluster.cluster-tf) == 0 ? null : element(huaweicloud_cce_cluster.cluster-tf[*].id, 0)

  values {
    basic_json = jsonencode(jsondecode(data.huaweicloud_cce_addon_template.addon_autoscaler_template[0].spec).basic)
    custom_json = jsonencode(merge(
      jsondecode(data.huaweicloud_cce_addon_template.addon_autoscaler_template[0].spec).parameters.custom,
      {
        cluster_id = length(huaweicloud_cce_cluster.cluster-tf) == 0 ? null : element(huaweicloud_cce_cluster.cluster-tf[*].id, 0)
        tenant_id              = var.credentialshwc[3] # Project ID of the region
      }
    ))
    flavor_json = jsonencode( 
    {resources = [{
            "name" : "metrics-server",
            "limitsCpu" : var.metrics_server_resources.limits_cpu,
            "limitsMem" : var.metrics_server_resources.limits_mem,
            "requestsCpu" : var.metrics_server_resources.requests_cpu,
            "requestsMem" : var.metrics_server_resources.requests_mem
          }
        ]
      })
    
  }
}

#Add an nginx ingress controller in the CCE
data "huaweicloud_cce_addon_template" "nginx_controller_addon" {
  count = var.cce_tf ? 1 : 0
  name       = "nginx-ingress"
  version    = "2.4.6"
  cluster_id = length(huaweicloud_cce_cluster.cluster-tf) == 0 ? null : element(huaweicloud_cce_cluster.cluster-tf[*].id, 0)
}

data "huaweicloud_cce_addon_template" "nginx-ingress" {
  count = var.cce_tf ? 1 : 0
  cluster_id = length(huaweicloud_cce_cluster.cluster-tf) == 0 ? null : element(huaweicloud_cce_cluster.cluster-tf[*].id, 0)
  name       = "nginx-ingress"
  version    = "2.4.6"
}

resource "huaweicloud_cce_addon" "nginx-ingress" {
  count = var.cce_tf ? 1 : 0
  cluster_id = length(huaweicloud_cce_cluster.cluster-tf) == 0 ? null : element(huaweicloud_cce_cluster.cluster-tf[*].id, 0)
  template_name = "nginx-ingress"
  version       = "2.4.6"

  values {
    basic_json = jsonencode(jsondecode(data.huaweicloud_cce_addon_template.nginx-ingress[0].spec).basic)
    custom_json = jsonencode(merge(
      jsondecode(data.huaweicloud_cce_addon_template.nginx-ingress[0].spec).parameters.custom,
      {
        admissionWebhooks = { "enabled" = "true" }
        service = { 
          annotations = {
            "kubernetes.io/elb.class" = "performance"
            "kubernetes.io/elb.id"    = local.elb_id
          } 
        }
        tenant_id = var.credentialshwc[3]
      }
    ))
  }
}