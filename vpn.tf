# Create an EIP SP
resource "huaweicloud_vpc_eip" "eip_vpn_sp" {
    for_each = var.create_eip_vpn_sp ? {for index in var.eip_sp : index.eip_name_sp => index} : {}
    publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = each.value.eip_name_sp
    size        = each.value.eip_size_sp
    share_type  = "PER"
    charge_mode = "traffic"
  }
  region = var.credentialshwc[0]
}

# Create a VPN Gateway SP
resource "huaweicloud_vpn_gateway" "gateway_sp" {
  count = var.create_vpn_gateway_sp ? 1 : 0
  name               = var.vpn_gateway_name_sp
  vpc_id             = huaweicloud_vpc.vpc.id
  local_subnets      = [huaweicloud_vpc_subnet.subnet["subnet-tf"].cidr]
  connect_subnet     = huaweicloud_vpc_subnet.subnet["subnet-tf"].id
  availability_zones = [data.huaweicloud_availability_zones.azs.names[0], data.huaweicloud_availability_zones.azs.names[1]]
  
  eip1 {
    id = huaweicloud_vpc_eip.eip_vpn_sp["eip-sp1"].id
  }
  eip2 {
    id = huaweicloud_vpc_eip.eip_vpn_sp["eip-sp2"].id
  }
  region = var.credentialshwc[0]
}

# Create a VPN Customer Gateway SP 
resource "huaweicloud_vpn_customer_gateway" "cg-sp" {
  count = var.create_vpn_cg_sp ? 1 : 0
  ip = huaweicloud_vpc_eip.eip_vpn_st["eip-st1"].address
  name = var.cg_name_sp
  route_mode = var.cg_routemode_sp
  region = var.credentialshwc[0]
}

# Resources in ST

# Get the availability zones ST
data "huaweicloud_availability_zones" "st" {
    region = var.credentialshwc[4]
}

# Create a VPC ST
resource "huaweicloud_vpc" "vpc_st" {
  count = var.create_vpc_st_vpn ? 1 : 0
  name = var.vpc_name_st
  cidr = var.vpc_cidr_st
  region = var.credentialshwc[4]
}

# Create a Subnet ST
resource "huaweicloud_vpc_subnet" "subnet_st" {
  count = var.create_subnet_st_vpn ? 1 : 0
  name       = var.subnet_name_st
  cidr       = var.subnet_cidr_st
  gateway_ip = var.subnet_gateway_st
  vpc_id     = huaweicloud_vpc.vpc_st[0].id
  region = var.credentialshwc[4]
}

# Create an EIP ST 
resource "huaweicloud_vpc_eip" "eip_vpn_st" {
  for_each = var.create_eip_vpn_st ? {for index in var.eip_st : index.eip_name_st => index} : {}
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = each.value.eip_name_st
    size        = each.value.eip_size_st
    share_type  = "PER"
    charge_mode = "traffic"
  }
  region = var.credentialshwc[4]
}

# Create a VPN Gateway ST
resource "huaweicloud_vpn_gateway" "gateway_st" {
  count = var.create_vpn_gateway_st ? 1 : 0
  name               = var.vpn_gateway_name_st
  vpc_id             = huaweicloud_vpc.vpc_st[0].id
  local_subnets      = [huaweicloud_vpc_subnet.subnet_st[0].cidr]
  connect_subnet     = huaweicloud_vpc_subnet.subnet_st[0].id
  availability_zones = [data.huaweicloud_availability_zones.st.names[0], data.huaweicloud_availability_zones.st.names[1]]
  
  eip1 {
    id = huaweicloud_vpc_eip.eip_vpn_st["eip-st1"].id  
    }
  eip2 {
    id = huaweicloud_vpc_eip.eip_vpn_st["eip-st2"].id
  }
  region = var.credentialshwc[4]
}

# Create a Customer Gateway ST
resource "huaweicloud_vpn_customer_gateway" "cg-st" {
  count = var.create_vpn_cg_st ? 1 : 0
  ip = huaweicloud_vpc_eip.eip_vpn_sp["eip-sp1"].address
  name = var.cg_name_st
  route_mode = var.cg_routemode_st
  region = var.credentialshwc[4]
}

# Create a VPN SP Connection
resource "huaweicloud_vpn_connection" "vpn-sp" {
  count = var.create_vpn_connection_sp ? 1 : 0
  name = var.vpn_name_sp
  gateway_id = huaweicloud_vpn_gateway.gateway_sp[0].id
  gateway_ip = huaweicloud_vpc_eip.eip_vpn_sp["eip-sp1"].id
  psk = var.psk
  peer_subnets = [huaweicloud_vpc_subnet.subnet_st[0].cidr]
  vpn_type = var.vpn_type
  customer_gateway_id = huaweicloud_vpn_customer_gateway.cg-sp[0].id
  region = var.credentialshwc[0]
}

# Create a VPN ST Connection
resource "huaweicloud_vpn_connection" "vpn-st" {
  count = var.create_vpn_connection_st ? 1 : 0
  name = var.vpn_name_st
  gateway_id = huaweicloud_vpn_gateway.gateway_st[0].id
  gateway_ip = huaweicloud_vpc_eip.eip_vpn_st["eip-st1"].id
  psk = var.psk
  peer_subnets = [huaweicloud_vpc_subnet.subnet["subnet-tf"].cidr]
  vpn_type = var.vpn_type
  customer_gateway_id = huaweicloud_vpn_customer_gateway.cg-st[0].id
  region = var.credentialshwc[4]
}