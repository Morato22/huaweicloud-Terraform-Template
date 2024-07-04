### VPC, SUBNETS AND SECURITY GROUPS VARIABLES ###
vpc_name = "vpc-tf"
vpc_cidr = "192.168.0.0/16"

subnets = [{
  subnet_name    = "subnet-tf"
  subnet_cidr    = "192.168.0.0/24"
  subnet_gateway = "192.168.0.1"
},
{
    subnet_name = "subnet-tf2"
    subnet_cidr = "192.168.1.0/24"
    subnet_gateway = "192.168.1.1"
}]

secgroup_name = "sg-tf"

secgroup_rule = [{
  secgroup_rule_direction = "ingress"
  secgroup_rule_ethertype = "IPV4"
  secgroup_rule_protocol  = "tcp"
  secgroup_rule_ports     = "22,80,8635,6379"
  secgroup_rule_ip-prefix = "0.0.0.0/0"
  },
  {
    secgroup_rule_direction = "egress"
    secgroup_rule_ethertype = "IPV4"
    secgroup_rule_protocol  = "tcp"
    secgroup_rule_ports     = "1-65535"
    secgroup_rule_ip-prefix = "0.0.0.0/0"

  }
]

### ECS VARIABLES ###
ecs_tf = [{
  ecs_name      = "ecs-tf"
  ecs_flavor    = "s6.medium.2"
  ecs_password  = ".."
  ecs_disk_type = "SAS"
  ecs_disk_size = "40"
  ecs_subnet = "subnet-tf"
  },
  {
    ecs_name      = "ecs-tf2"
    ecs_flavor    = "s6.medium.4"
    ecs_password  = ".."
    ecs_disk_type = "SAS"
    ecs_disk_size = "40"
    ecs_subnet = "subnet-tf2"
  }
]

image_public  = "68a783a4-25b2-4069-bc25-d927eeb7f97b"
image_private = "31ce5492-e909-4688-93c5-1922ee0ec00e"

### EVS VARIABLES ###
evs_tf = [{
    evs_name = "evs-tf"
    evs_type = "SAS"
    evs_size = 40
    evs_ecs = "ecs-tf"
}, {
    evs_name = "evs-tf2"
    evs_type = "SAS"
    evs_size = 50
    evs_ecs = "ecs-tf"
}, {
    evs_name = "evs-tf3"
    evs_type = "SAS"
    evs_size = 30
    evs_ecs = "ecs-tf2"
}]

### EIP VARIABLES ###
eip-bandwidth_name = "bandwidth-tf"
eip-bandwidth_size = "100"

### OBS VARIABLES ###
obs_tf = [{
  bucket_name       = "tf-test-bucket"
  bucket_acl        = "private"
  bucket_versioning = true
  bucket_storage    = "STANDARD"
}]

### CCE VARIABLES ###
vpc-tf-cce_name       = "vpc-cce"
vpc-tf-cce_cidr       = "192.168.0.0/16"
subnet-tf-cce_name    = "subnet-cce"
subnet-tf-cce_cidr    = "192.168.0.0/24"
subnet-tf-cce_gateway = "192.168.0.1"
eip-tf-cce_name       = "eip-cce"
eip-tf-cce_size       = "100"
cluster-tf_name       = "cce-tf"
cluster-tf_flavor     = "cce.s2.small" #s2 gonna create a HA cluster with 3 master nodes, s1 gonna create a single master node
cluster-tf_network    = "vpc-router"
cluster-tf_version    = "v1.27"

cce_node_pool = [ {
    cce_np_name = "np-tf"
    cce_np_os = "Huawei Cloud EulerOS 2.0"
    cce_np_password = ".."
    cce_np_flavor = "c7n.xlarge.2"
    cce_np_count = "2"
    cce_np_scall = false
    cce_np_min_count = 1
    cce_np_max_count = 10
    cce_np_scaledown = 100
    cce_np_priority = 1
    cce_np_type = "vm"
    cce_np_rootsize = 50
    cce_np_rootvolume = "SAS"
    cce_np_size = 100
    cce_np_volume = "SAS"
} ]

cce_node = [{
    cce_node_name = "node-tf"
    cce_node_os = "Huawei Cloud EulerOS 2.0"
    cce_node_flavor = "c6s.xlarge.2"
    cce_node_password = ".."
    cce_noderoot_size = 50
    cce_noderoot_type = "SAS"
    cce_node_size = 100
    cce_node_type = "SAS"
    cce_node_eip_chargemode = "traffic"
    cce_node_eip_size = 100
}]

## JSON VARIABLES ##
metrics_server_resources = {
    limits_cpu   = "1500m"
    limits_mem   = "1000Mi"
    requests_cpu = "1000m"
    requests_mem = "500Mi"
}

### ELB VARIABLES ###
elb_eip_charge = "traffic"
elb_eip_size = 100

### RDS VARIABLES ###
rds_tf = [{
  rds_name         = "rds-tf"
  rds_flavor       = "rds.pg.n1.large.2.ha"
  rds_ha           = "async"
  rds_type         = "PostgreSQL"
  rds_type_version = "15"
  rds_volume_type  = "CLOUDSSD"
  rds_volume_size  = "40"
  rds_password     = ".."
  }
]

### VPN VARIABLES ###
## SP VARIABLES ##
eip_sp = [{
    eip_name_sp = "eip-sp1"
    eip_size_sp = 50
},  {
        eip_name_sp = "eip-sp2"
        eip_size_sp = 50
}]

vpn_gateway_name_sp = "vpn-gateway-sp"

cg_name_sp = "cg-sp"
cg_routemode_sp = "static"

## ST VARIABLES ##
vpc_name_st = "vpc-st"
vpc_cidr_st = "172.16.0.0/16"

subnet_name_st = "subnet-st"
subnet_cidr_st = "172.16.0.0/24"
subnet_gateway_st = "172.16.0.1"

eip_st = [ {
    eip_name_st = "eip-st1"
    eip_size_st = 50
},  {
        eip_name_st = "eip-st2"
        eip_size_st = 50
}]

vpn_gateway_name_st = "vpn-gateway-st"

cg_name_st = "cg-st"
cg_routemode_st = "static"

## CONNECTION VARIABLES ##
vpn_name_sp = "vpn-sp"
vpn_name_st = "vpn-st"

psk = ".."
vpn_type = "static"

### IAM VARIABLES ###
ep_iam_name = "Test-Terraform3"

iam_tf = [{
    iam_name = "Terraform-IAM"
    iam_password = ".."
}, {
    iam_name = "Terraform-IAM2"
    iam_password = ".."
}]

iam_role = [{
    iam_role_name = "Role-TF"
    iam_role_type = "AX"
    iam_role_description = "Role for test ECS"
    iam_role_policy = <<EOF
{
        "Version": "1.1",
        "Statement": [
                {
                        "Effect": "Allow",
                        "Action": [
                                "ecs:*:*",
                                "evs:*:get",
                                "evs:*:list",
                                "evs:volumes:create",
                                "evs:volumes:delete",
                                "evs:volumes:attach",
                                "evs:volumes:detach",
                                "evs:volumes:manage",
                                "evs:volumes:update",
                                "evs:volumes:use",
                                "evs:volumes:uploadImage",
                                "evs:snapshots:create",
                                "vpc:*:get",
                                "vpc:*:list",
                                "vpc:networks:create",
                                "vpc:networks:update",
                                "vpc:subnets:update",
                                "vpc:subnets:create",
                                "vpc:ports:*",
                                "vpc:routers:get",
                                "vpc:routers:update",
                                "vpc:securityGroups:*",
                                "vpc:securityGroupRules:*",
                                "vpc:floatingIps:*",
                                "vpc:publicIps:*",
                                "ims:images:create",
                                "ims:images:delete",
                                "ims:images:get",
                                "ims:images:list",
                                "ims:images:update",
                                "ims:images:upload"
                        ]
                }
        ]
}
EOF
    }, {
    iam_role_name        = "Role2"
    iam_role_type        = "AX"
    iam_role_description = "Role for test OBS"
    iam_role_policy      = <<EOF
{
    "Version": "1.1",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "obs:*:*"
            ]
        }
    ]
}
EOF
  }
]

iam_group = [ {
  iam_group_name = "group1"
} ]

### NAT GATEWAY VARIABLES ###
dnat_rule = [{
  dnat_protocol = "tcp"
  internal_range = "83-220"
  external_range = "8083-8220"
}]

### SMN VARIABLES ###
smn_template = [{
    smn_template_name = "template-tf"
    smn_template_protocol = "email"
    smn_template_content = "template para ecs"
}]

smn_topic = [{
  smn_topic_name = "topic-tf"
  smn_topic_displayname = "Topic 1"
  smn_topic_users = "urn:csp:iam:::root"
  smn_topic_services = "ecs,obs,cce"
  smn_topic_introduction = "Created by Terraform"
}]

smn_subscription = [{
  smn_subscription_endpoint = "example@example.com"
  smn_subscription_protocol = "email"
  smn_subscription_remark = "O&M"
}]

### WAF VARIABLES ###
waf_policy_name = "waf-policy-tf"
waf_policy_protection = "log"
waf_policy_robot = "block"
waf_policy_level = 1

## WAF RULE PRECISE ##
waf_rule_precise = [{
  waf_rule_precise_name = "rule_blocking-all-but-brazil"
  waf_rule_precise_priority = "10"
  waf_rule_precise_action = "block"
  waf_rule_precise_description = "block all countries"
  waf_rule_precise_status = 1
}]

## WAF GEO BLOCK ##
waf_geoblock = [{
  waf_geolocation = "BR"
  waf_geolocation_name = "allow-brazil"
  waf_geolocation_action = 1
  waf_geolocation_description = "allow brazil acces to your website"
}]

## WAF DOMAIN ##
waf_domain = "example.com"
waf_proxy = false
waf_domain_protect = 1
waf_client_protocol = "HTTP"
waf_server_protocol = "HTTP"
waf_server_address = "257.123.123.123"
waf_server_port = "80"
waf_server_type = "ipv4"


### GeminiDB Cassandra VARIABLES ###
gcassandra_name = "cassandra-tf"
gcassandra_password = ".."
gcassandra_flavor = "geminidb.cassandra.large.4"
gcassandra_volume = 200
gcassandra_nodes = 3
gcassandra_engine = "cassandra"
gcassandra_version = "3.11"
gcassandra_storage_engine = "rocksDB"

### GeminiDB Redis VARIABLES ###
gredis_name = "redis-tf"
gredis_password = ".."
gredis_flavor = "geminidb.redis.medium.4"
gredis_volume = 6
gredis_nodes = 3
gredis_port = 6379
gredis_engine = "redis"
gredis_version = "5.0"
gredis_storage_engine = "rocksDB"

### GeminiDB InfluxDB VARIABLES ###
ginflux_name = "influx-tf"
ginflux_password = ".."
ginflux_flavor = "geminidb.influxdb.large.4"
ginflux_volume = 200
ginflux_node = 4

### VPC ENDPOINT VARIABLES ###
service_private_id = "4be4d50a-ff2d-48c5-8b54-1f2a6ec302c1"
endpoint_whitelist = [ "192.168.0.0/24", "192.168.0.1/24"]

### DCS Redis VARIABLES ###
dcs_redis_name = "redis-tf"
dcs_redis_engine = "Redis"
dcs_redis_engine_version = "5.0"
dcs_redis_flavor = "redis.cluster.xu1.large.r2.4"
dcs_redis_password = ".."
dcs_redis_port = 6379
dcs_redis_capacity = 4

dcs_redis_backup_type = "auto"
dcs_redis_backup_save_days = 3
dcs_redis_backup_at = [1,3,5,7]
dcs_redis_backup_begin_at = "02:00-04:00"

dcs_redis_whitelist_group_name1 = "test-group1"
dcs_redis_whitelist_ip_address1 = ["192.168.10.100", "192.168.0.0/24"]

dcs_redis_whitelist_group_name2 = "test-group2"
dcs_redis_whitelist_ip_address2 = ["172.16.10.100", "172.16.0.0/24"]

### DDS VARIABLES ###
dds_datastore_type = "DDS-Community"
dds_datastore_version = "4.4"
dds_datastore_storage_engine = "rocksDB"

dds_instance_name = "dds-tf"
dds_instance_password = ".."
dds_instance_mode = "Sharding"

dds_flavor_type1 = "mongos"
dds_flavor_num1 = 2
dds_flavor_spec_code1 = "dds.mongodb.s6.large.4.mongos"

dds_flavor_type2 = "shard"
dds_flavor_num2 = 2
dds_flavor_storage2 = "ULTRAHIGH"
dds_flavor_size2 = 100
dds_flavor_spec_code2 = "dds.mongodb.s6.xlarge.4.shard"

dds_flavor_type3 = "config"
dds_flavor_num3 = 1
dds_flavor_storage3 = "ULTRAHIGH"
dds_flavor_size3 = 20
dds_flavor_spec_code3 = "dds.mongodb.s6.large.2.config"

### DMS RabbitMQ VARIABLES ###
rabbit_type = "cluster"
rabbit_storage_type = "dms.physical.storage.ultra.v2"

rabbit_instance_name = "rabbit-tf"
rabbit_instance_flavor = "rabbitmq.2u4g.cluster"
rabbit_instance_engine = "3.8.35"
rabbit_instance_broker_num = 3
rabbit_instance_broker_storage = 300
rabbit_instance_user = "user"
rabbit_instance_password = ".."