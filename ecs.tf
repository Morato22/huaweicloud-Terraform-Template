# Get the Azs availables in the region
data "huaweicloud_availability_zones" "azs" {}

# Create an ECS
resource "huaweicloud_compute_instance" "ecs" {
  for_each           = var.create_ecs ? { for index in var.ecs_tf : index.ecs_name => index } : {}
  name               = each.value.ecs_name
  image_id           = var.image_type == "public" ? var.image_public : var.image_private
  flavor_id          = each.value.ecs_flavor
  security_group_ids = [huaweicloud_networking_secgroup.secgroup.id]
  availability_zone  = data.huaweicloud_availability_zones.azs.names[0]
  admin_pass         = each.value.ecs_password
  system_disk_type   = each.value.ecs_disk_type
  system_disk_size   = each.value.ecs_disk_size

  network {
    uuid = huaweicloud_vpc_subnet.subnet[each.value.ecs_subnet].id
  }
}

# Create extra volumes and attach on ECS
resource "huaweicloud_evs_volume" "evsdisk" {
  for_each = var.create_evs ? {for index in var.evs_tf : index.evs_name => index} : {}
  name              = each.value.evs_name
  availability_zone = data.huaweicloud_availability_zones.azs.names[0]
  volume_type       = each.value.evs_type
  size              = each.value.evs_size
  server_id         = huaweicloud_compute_instance.ecs[each.value.evs_ecs].id
}