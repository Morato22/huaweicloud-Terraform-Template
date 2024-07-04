# Create a DDS Instance
resource "huaweicloud_dds_instance" "instance" {
  count            = var.create_dds ? 1 : 0
  name             = var.dds_instance_name
  datastore {
    type           = var.dds_datastore_type
    version        = var.dds_datastore_version
    storage_engine = var.dds_datastore_storage_engine
  }

  availability_zone = data.huaweicloud_availability_zones.azs.names[0]
  vpc_id            = huaweicloud_vpc.vpc.id
  subnet_id         = huaweicloud_vpc_subnet.subnet["subnet-tf"].id
  security_group_id = huaweicloud_networking_secgroup.secgroup.id
  password          = var.dds_instance_password
  mode              = var.dds_instance_mode

  flavor {
    type      = var.dds_flavor_type1
    num       = var.dds_flavor_num1
    spec_code = var.dds_flavor_spec_code1
  }
  flavor {
    type      = var.dds_flavor_type2
    num       = var.dds_flavor_num2
    storage   = var.dds_flavor_storage2
    size      = var.dds_flavor_size2
    spec_code = var.dds_flavor_spec_code2
  }
  flavor {
    type      = var.dds_flavor_type3
    num       = var.dds_flavor_num3
    storage   = var.dds_flavor_storage3
    size      = var.dds_flavor_size3
    spec_code = var.dds_flavor_spec_code3
  }
}