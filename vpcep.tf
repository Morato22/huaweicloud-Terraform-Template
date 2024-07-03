# Create the VPC Endpoint
resource "huaweicloud_vpcep_endpoint" "endpoint" {
  count = var.create_vpcep ? 1 : 0
  service_id  = var.service_private_id
  vpc_id      = huaweicloud_vpc.vpc.id
  network_id = huaweicloud_vpc_subnet.subnet["subnet-tf"].id
  enable_dns = var.endpoint_dns
  enable_whitelist = var.endpoint_whitelist_enable
  whitelist = var.endpoint_whitelist
}