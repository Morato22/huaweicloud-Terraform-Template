# Get the flavors list of ELB in the layer 4 (TCP/UDP)
data "huaweicloud_elb_flavors" "flavors_l4" {
  type            = "L4"
}

# Get the flavors list of ELB in the layer 7 (HTTP/HTTPS)
data "huaweicloud_elb_flavors" "flavors_l7" {
  type            = "L7"
}

resource "huaweicloud_elb_loadbalancer" "dedicated" {
    count             = var.create_elb ? 1 : 0
    name              = "elb-ingress"
    cross_vpc_backend = true

    vpc_id            = huaweicloud_vpc.vpc.id
    ipv4_subnet_id    = huaweicloud_vpc_subnet.subnet["subnet-tf"].ipv4_subnet_id

    l4_flavor_id = data.huaweicloud_elb_flavors.flavors_l4.ids[0]
    l7_flavor_id = data.huaweicloud_elb_flavors.flavors_l7.ids[0]

    availability_zone = [data.huaweicloud_availability_zones.azs.names[0], data.huaweicloud_availability_zones.azs.names[1], data.huaweicloud_availability_zones.azs.names[2]]

    iptype                = "5_bgp"
    bandwidth_charge_mode = var.elb_eip_charge
    sharetype             = "PER"
    bandwidth_size        = var.elb_eip_size
}