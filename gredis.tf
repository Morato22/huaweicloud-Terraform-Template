# Create the Redis Instance Resource
resource "huaweicloud_gaussdb_redis_instance" "gredis" {
  count             = var.create_gredis ? 1 : 0
  name              = var.gredis_name
  password          = var.gredis_password
  flavor            = var.gredis_flavor
  volume_size       = var.gredis_volume
  node_num          = var.gredis_nodes
  port              = var.gredis_port
  mode              = "Cluster"
  vpc_id            = huaweicloud_vpc.vpc.id
  subnet_id         = huaweicloud_vpc_subnet.subnet["subnet-tf"].id
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
  availability_zone = data.huaweicloud_availability_zones.azs.names[1]

  datastore {
    engine = var.gredis_engine
    version = var.gredis_version
    storage_engine = var.gredis_storage_engine
  }
}