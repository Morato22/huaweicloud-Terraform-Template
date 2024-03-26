# Create a public Nat Gateway
resource "huaweicloud_nat_gateway" "public" {
    count       = var.create_nat_gateway ? 1 : 0
    name        = var.nat_gateway_public_name
    spec        = var.nat_gateway_public_spec
    vpc_id      = huaweicloud_vpc.vpc.id
    subnet_id   = huaweicloud_vpc_subnet.subnet["subnet-tf"].id
}

# Create an EIP
resource "huaweicloud_vpc_eip" "eip-nat" {
  count = var.create_nat_gateway ? 1 : 0
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = var.eip_nat_bandwidth_name
    size        = var.eip_nat_bandwidth_size
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

# Create a DNAT rule
resource "huaweicloud_nat_dnat_rule" "dnat" {
    for_each = var.create_nat_gateway ? {for index in var.dnat_rule : index.external_range => index} : {}
    nat_gateway_id              = huaweicloud_nat_gateway.public[0].id
    floating_ip_id              = huaweicloud_vpc_eip.eip-nat[0].id
    port_id                     = huaweicloud_compute_instance.ecs["ecs-tf"].network[0].port
    protocol                    = each.value.dnat_protocol
    internal_service_port_range = each.value.internal_range
    external_service_port_range = each.value.external_range
}

# Create a SNAT rule
resource "huaweicloud_nat_snat_rule" "snat" {
    count       = var.create_nat_gateway ? 1 : 0
    floating_ip_id = huaweicloud_vpc_eip.eip-nat[0].id
    nat_gateway_id = huaweicloud_nat_gateway.public[0].id
    subnet_id      = huaweicloud_vpc_subnet.subnet["subnet-tf"].id
}