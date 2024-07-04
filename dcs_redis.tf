# Create a DCS Instance
resource "huaweicloud_dcs_instance" "dcs" {
  count              = var.create_dcs_redis ? 1 : 0
  name               = var.dcs_redis_name
  engine             = var.dcs_redis_engine
  engine_version     = var.dcs_redis_engine_version
  capacity           = var.dcs_redis_capacity
  flavor             = var.dcs_redis_flavor
  availability_zones = [data.huaweicloud_availability_zones.azs.names[0], data.huaweicloud_availability_zones.azs.names[1]]
  password           = var.dcs_redis_password
  vpc_id             = huaweicloud_vpc.vpc.id
  subnet_id          = huaweicloud_vpc_subnet.subnet["subnet-tf"].id
  port               = var.dcs_redis_port
  whitelist_enable   = var.dcs_redis_whitelist_enable

#  charging_mode = "postPaid"

  backup_policy {
    backup_type = var.dcs_redis_backup_type
    save_days   = var.dcs_redis_backup_save_days
    backup_at   = var.dcs_redis_backup_at
    begin_at    = var.dcs_redis_backup_begin_at
  }

  whitelists {
    group_name = var.dcs_redis_whitelist_group_name1
    ip_address = var.dcs_redis_whitelist_ip_address1
  }
  whitelists {
    group_name = var.dcs_redis_whitelist_group_name2
    ip_address = var.dcs_redis_whitelist_ip_address2
  }
}