# Create the InfluxDB Instance Resource
resource "huaweicloud_gaussdb_influx_instance" "ginflux" {
  count             = var.create_ginflux ? 1 : 0
  name              = var.ginflux_name
  password          = var.ginflux_password
  flavor            = var.ginflux_flavor
  volume_size       = var.ginflux_volume
  node_num          = var.ginflux_node
  vpc_id            = huaweicloud_vpc.vpc.id
  subnet_id         = huaweicloud_vpc_subnet.subnet["subnet-tf"].id
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
  availability_zone = data.huaweicloud_availability_zones.azs.names[1]
}