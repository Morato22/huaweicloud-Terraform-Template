# Create a VPC
resource "huaweicloud_vpc" "vpc" {
  name = var.vpc_name
  cidr = var.vpc_cidr
}

# Create a Subnet
resource "huaweicloud_vpc_subnet" "subnet" {
  for_each   = { for index in var.subnets : index.subnet_name => index }
  name       = each.value.subnet_name
  cidr       = each.value.subnet_cidr
  gateway_ip = each.value.subnet_gateway
  vpc_id     = huaweicloud_vpc.vpc.id
}

# Create a Security Group
resource "huaweicloud_networking_secgroup" "secgroup" {
  name                 = var.secgroup_name
  delete_default_rules = true
}

# Create a Security Group Rule
resource "huaweicloud_networking_secgroup_rule" "secgroup_rule" {
  for_each          = { for index in var.secgroup_rule : index.secgroup_rule_direction => index }
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
  direction         = each.value.secgroup_rule_direction
  ethertype         = each.value.secgroup_rule_ethertype
  protocol          = each.value.secgroup_rule_protocol
  ports             = each.value.secgroup_rule_ports
  remote_ip_prefix  = each.value.secgroup_rule_ip-prefix
}