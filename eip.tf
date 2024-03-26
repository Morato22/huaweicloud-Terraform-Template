# Create an EIP
resource "huaweicloud_vpc_eip" "eip-tf" {
  for_each = var.create_eip ? huaweicloud_compute_instance.ecs : {}
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = var.eip-bandwidth_name
    size        = var.eip-bandwidth_size
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

# Associate the EIP to each ECS
resource "huaweicloud_compute_eip_associate" "associated" {
  for_each    = var.create_eip ? huaweicloud_compute_instance.ecs : {}
  public_ip   = huaweicloud_vpc_eip.eip-tf[each.key].address
  instance_id = huaweicloud_compute_instance.ecs[each.key].id
}