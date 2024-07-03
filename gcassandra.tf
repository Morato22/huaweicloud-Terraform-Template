# Create the Cassandra Instance Resource
resource "huaweicloud_gaussdb_cassandra_instance" "gcassandra" {
  count             = var.create_gcassandra ? 1 : 0
  name              = var.gcassandra_name
  password          = var.gcassandra_password
  flavor            = var.gcassandra_flavor
  volume_size       = var.gcassandra_volume
  node_num          = var.gcassandra_nodes
  vpc_id            = huaweicloud_vpc.vpc.id
  subnet_id         = huaweicloud_vpc_subnet.subnet["subnet-tf"].id
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
  availability_zone = data.huaweicloud_availability_zones.azs.names[1]

  datastore {
    engine = var.gcassandra_engine
    version = var.gcassandra_version
    storage_engine = var.gcassandra_storage_engine
  }
}

data huaweicloud_gaussdb_cassandra_instances out {
  region = var.credentialshwc[0]
}

output "cas" {
  value = data.huaweicloud_gaussdb_cassandra_instances.out
}