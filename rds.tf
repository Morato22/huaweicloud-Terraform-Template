# Create a RDS instance
resource "huaweicloud_rds_instance" "rds-tf" {
  for_each            = var.create_rds ? { for index in var.rds_tf : index.rds_name => index } : {}
  name                = each.value.rds_name
  flavor              = each.value.rds_flavor
  ha_replication_mode = each.value.rds_ha
  vpc_id              = huaweicloud_vpc.vpc.id
  subnet_id           = huaweicloud_vpc_subnet.subnet["subnet-tf"].id
  security_group_id   = huaweicloud_networking_secgroup.secgroup.id
  availability_zone   = [data.huaweicloud_availability_zones.azs.names[0], data.huaweicloud_availability_zones.azs.names[1]]

  # Specify the databse, version and password
  db {
    type     = each.value.rds_type
    version  = each.value.rds_type_version
    password = each.value.rds_password
  }

  # Specify the instance disk
  volume {
    type = each.value.rds_volume_type
    size = each.value.rds_volume_size
  }

  # Define backup options
  backup_strategy {
    start_time = "08:00-09:00"
    keep_days  = 1
  }
}