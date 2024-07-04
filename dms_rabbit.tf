# Get the RabbitMQ Flavors
data "huaweicloud_dms_rabbitmq_flavors" "rabbit" {
  type               = var.rabbit_type
  storage_spec_code  = var.rabbit_storage_type
  availability_zones = [data.huaweicloud_availability_zones.azs.names[0]]
}

# Create a DMS Instance
resource "huaweicloud_dms_rabbitmq_instance" "rabbit" {
  count             = var.create_dms_rabbit ? 1 : 0
  name              = var.rabbit_instance_name
  flavor_id         = var.rabbit_instance_flavor
  engine_version    = var.rabbit_instance_engine
  storage_spec_code = data.huaweicloud_dms_rabbitmq_flavors.rabbit.flavors[0].ios[0].storage_spec_code
  broker_num        = var.rabbit_instance_broker_num
  storage_space     = var.rabbit_instance_broker_storage

  vpc_id             = huaweicloud_vpc.vpc.id
  network_id         = huaweicloud_vpc_subnet.subnet["subnet-tf"].id
  security_group_id  = huaweicloud_networking_secgroup.secgroup.id
  availability_zones = [data.huaweicloud_availability_zones.azs.names[0]]

  access_user = var.rabbit_instance_user
  password    = var.rabbit_instance_password
}