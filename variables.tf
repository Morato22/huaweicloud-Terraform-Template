### CREDENTIALS VARIABLES ###
variable "credentialshwc" {
  type    = list(string)
  default = ["sa-brazil-1", "..", "..", "la-south-2"]
  description = "Region and your AK, SK, and region 2."
}

### VPC, SUBNETS AND SECURITY GROUPS VARIABLES ###
variable "vpc_name" {
  type = string
  description = "VPC name"
}

variable "vpc_cidr" {
  type = string
  description = "VPC CIDR"
}

variable "subnets" {
  type = list(object({
    subnet_name    = string
    subnet_cidr    = string
    subnet_gateway = string
  }))
  description = "Subnet variables"
}

variable "secgroup_name" {
  type = string
  description = "Security Group name"
}

variable "secgroup_rule" {
  type = list(object({
    secgroup_rule_direction = string
    secgroup_rule_ethertype = string
    secgroup_rule_protocol  = string
    secgroup_rule_ports     = string
    secgroup_rule_ip-prefix = string
  }))
  description = "Security Group variables"
}

#### ECS VARIABLES #####
variable "create_ecs" {
  type        = bool
  description = "Insert true to create an ECS. Insert false to not create."
  default = false
}

variable "ecs_tf" {
  type = list(object({
    ecs_name      = string
    ecs_flavor    = string
    ecs_password  = string
    ecs_disk_type = string
    ecs_disk_size = string
    ecs_subnet = string
  }))
  description = "ECS variables"
}

variable "image_type" {
  type        = string
  description = "Insert public to a Public Image and private to a Private Image"
  default = "public"
}
variable "image_public" {
  type = string
  description = "ID of a public image"
}
variable "image_private" {
  type = string
  description = "ID of a private image"
}

##### EVS VARIABLES #####
variable create_evs {
    type = bool
    description = "Insert true to create aditional disks to an ECS. Insert false to not create."
    default = false
}
variable evs_tf {
    type = list(object({
        evs_name = string
        evs_type = string
        evs_size = number
        evs_ecs = string
    }))
    description = "EVS variables"
}

##### EIP VARIABLES #####
variable "create_eip" {
  type        = bool
  description = "Insert true to create and associate an EIP to all ECS. Insert false to not create."
  default = false
}

variable "eip-bandwidth_name" {
  type = string
  description = "EIP bandwidth name"
}

variable "eip-bandwidth_size" {
  type = string
  description = "EIP bandiwith size"
}

##### OBS VARIABLES #####
variable "create_obs" {
  type        = bool
  description = "Insert true to create an OBS. Insert false to not create."
  default = false
}

variable "obs_tf" {
  type = list(object({
    bucket_name       = string
    bucket_acl        = string
    bucket_versioning = bool
    bucket_storage    = string
  }))
  description = "OBS variables"
}

##### CCE VARIABLES #####
variable "cce_tf" {
  type        = bool
  description = "Insert true to create a CCE. Insert false to not create"
  default = false
}
variable "vpc-tf-cce_name" {
  type = string
  description = "CCE VPC name"
}
variable "vpc-tf-cce_cidr" {
  type = string
  description = "CCE VPC CIDR"
}
variable "subnet-tf-cce_name" {
  type = string
  description = "CCE Subnet name"
}
variable "subnet-tf-cce_cidr" {
  type = string
  description = "CCE Subnet CIDR"
}
variable "subnet-tf-cce_gateway" {
  type = string
  description = "CCE Subnet Gateway"
}
variable "eip-tf-cce_name" {
  type = string
  description = "CCE EIP name"
}
variable "eip-tf-cce_size" {
  type = string
  description = "CCE EIP size"
}
variable "cluster-tf_name" {
  type = string
  description = "CCE instance name"
}
variable "cluster-tf_flavor" {
  type = string
  description = "CCE instance flavor"
}
variable "cluster-tf_network" {
  type = string
  description = "CCE instance network"
}
variable "cluster-tf_version" {
  type = string
  description = "CCE instance version"
}

## NODE POOL VARIABLES ##
variable create_node_pool {
  type = bool
  description = "Insert true to create a node pool. Insert false to not create."
  default = false
}
variable "cce_node_pool" {
    type = list(object({
        cce_np_name = string
        cce_np_os = string
        cce_np_password = string
        cce_np_flavor = string
        cce_np_count = string
        cce_np_scall = bool
        cce_np_min_count = number
        cce_np_max_count = number
        cce_np_scaledown = number
        cce_np_priority = number
        cce_np_type = string
        cce_np_rootsize = number
        cce_np_rootvolume = string
        cce_np_size = number
        cce_np_volume = string
    }))
    description = "CCE node pool variables"
}

## NODE VARIABLES ##
variable create_node {
    type = bool
    description = "Insert true to create a node. Insert false to not create."
    default = false
}
variable cce_node {
    type = list(object({
        cce_node_name = string
        cce_node_os = string
        cce_node_flavor = string
        cce_node_password = string
        cce_noderoot_size = number
        cce_noderoot_type = string
        cce_node_size = number
        cce_node_type = string
        cce_node_eip_chargemode = string
        cce_node_eip_size = number
    }))
    description = "CCE node variables."
}

## ADDONS VARIABLES ##
variable create_autoscaler_addon {
    type = bool
    description = "Insert true to create an autoscaler addon in CCE. Insert false to not create."
    default = false
}
variable create_nginx_ingress {
    type = bool
    description = "Insert true to create a nginx ingress controller addon. Insert false to not create."
    default = false
}

## JSON VARIABLES ##
variable "metrics_server_resources" {
  type = object({
    limits_cpu   = string
    limits_mem   = string
    requests_cpu = string
    requests_mem = string
  })
  description = "Metrics of Autoscaler Addon CCE."
}

##### ELB VARIABLES #####
variable create_elb {
    type = bool
    description = "Insert true to create an ELB. Insert false to not create."
    default = false
}
variable elb_eip_charge {
    type = string
    description = "EIP of ELB billing mode."
}
variable elb_eip_size {
    type = number
    description = "EIP of ELB size"
}

#### RDS VARIABLES #####
variable "create_rds" {
  type        = bool
  description = "Insert true to create a RDS. Insert false to not create."
  default = false
}

variable "rds_tf" {
  type = list(object({
    rds_name         = string
    rds_flavor       = string
    rds_ha           = string
    rds_type         = string
    rds_type_version = string
    rds_volume_type  = string
    rds_volume_size  = string
    rds_password     = string
  }))
  description = "RDS variables"
}

##### VPN VARIABLES #####
## SP REGION ##
variable create_eip_vpn_sp {
    type = bool
    description = "Insert true to create an EIP, to connect a vpn, in Sao Paulo region. Insert false to not create."
    default = false
}
variable eip_sp {
    type = list(object({
        eip_name_sp = string
        eip_size_sp = number
    }))
    description = "EIP Sao Paulo variables."
}

variable create_vpn_gateway_sp {
    type = bool
    description = "Insert true to create a VPN gateway in Sao Paulo region. Insert false to not create."
    default = false
}
variable vpn_gateway_name_sp {
    type = string
    description = "Insert the VPN gateway name of Sao Paulo region."
}

variable create_vpn_cg_sp {
    type = string
    description = "Insert true to create a Customer Gateway in Sao Paulo region. Insert false to not create."
    default = false
}
variable cg_name_sp {
    type = string
    description = "Insert the Customer gateway name of Sao Paulo region."
}
variable cg_routemode_sp {
    type = string
    description = "Insert the Customer gateway route mode of Sao Paulo region."
}


## ST REGION ##
variable create_vpc_st_vpn {
    type = bool
    description = "Insert true to create a VPC, to connect a vpn, in Santiago region. Insert false to not create."
    default = false
}
variable vpc_name_st {
    type = string
    description = "Insert the VPC name of Santiago region."
}
variable vpc_cidr_st {
    type = string
    description = "Insert the VPC CIDR of Santiago region."
}

variable create_subnet_st_vpn {
    type = bool
    description = "Insert true to create a Subnet, to connect a vpn, in Santiago region. Insert false to not create."
    default = false
}
variable subnet_name_st {
    type = string
    description = "Insert the Subnet name of Santiago region."
}
variable subnet_cidr_st {
    type = string
    description = "Insert the Subnet CIDR of Santiago region."
}
variable subnet_gateway_st {
    type = string
    description = "Insert the Subnet gateway of Santiago region."
}

variable create_eip_vpn_st {
    type = bool
    description = "Insert true to create an EIP, to connect a vpn, in Santiago region. Insert false to not create."
    default = false
}
variable eip_st {
    type = list(object({
        eip_name_st = string
        eip_size_st = number
    }))
    description = "EIP Santiago variables"
}

variable create_vpn_gateway_st {
    type = bool
    description = "Insert true to create a VPN gateway, in Santiago region. Insert false to not create."
    default = false
}
variable vpn_gateway_name_st {
    type = string
    description = "Insert the VPN gateway name of Santiago region."
}

variable create_vpn_cg_st {
    type = bool
    description = "Insert true to create a VPN Customer Gateway, in Santiago region. Insert false to not create."
    default = false
}
variable cg_name_st {
    type = string
    description = "Insert the Customer gateway name of Santiago region."
}
variable cg_routemode_st {
    type = string
    description = "Insert the Customer gateway route mode of Santiago region."
}

## CONNECTION VARIABLES ##
variable create_vpn_connection_sp {
    type = bool
    description = "Insert true to create a VPN connection in Sao Paulo region. Insert false to not create."
    default = false
}
variable vpn_name_sp {
    type = string
    description = "Insert the VPN connection name of Sao Paulo region."
}

variable create_vpn_connection_st {
    type = bool
    description = "Insert true to create a VPN connection in Santiago region. Insert false to not create."
    default = false
}
variable vpn_name_st {
    type = string
    description = "Insert the VPN connection name of Santiago region."
}

variable psk {
    type = string
    description = "Insert the psk for your VPN connection."
}
variable vpn_type {
    type = string
    description = "Insert the VPN connection type."
}

##### IAM VARIABLES #####
variable create_ep {
  type = bool
  description = "Insert true to create an Enterprise Project. Insert false to not create."
  default = false
}
variable ep_iam_name {
    type = string
    description = "Enterprise project name."
}

variable create_iam {
    type = bool
    description = "Insert true to create a IAM user. Insert false to not create."
    default = false
}
variable iam_tf {
    type = list(object({
        iam_name = string
        iam_password = string
    }))
    description = "IAM user variables."
}

variable create_iam_role {
    type = bool
    description = "Insert true to create a IAM role. Insert false to not create."
    default = false
}
variable iam_role {
    type = list(object({
        iam_role_name = string
        iam_role_type = string
        iam_role_description = string
        iam_role_policy = any
    }))
    description = "IAM role variables."
}

variable create_iam_group {
    type = bool
    description = "Inser true to create a IAM group. Insert false to not create."
    default = false
}
variable iam_group {
    type = list(object({
        iam_group_name = string
    }))
    description = "IAM group variables."
}

##### NAT GATEWAY VARIABLES #####
variable create_nat_gateway {
    type = bool
    description = "Insert true to create a Nat Gateway. Insert false to not create."
    default = false
}
variable nat_gateway_public_name {
    type = string
    description = "Insert the name of the public Nat Gateway."
    default = "nat-tf"
}
variable nat_gateway_public_spec {
    type = string
    description = "Insert the specification of the Nat Gateway."
    default = "1"
}

### EIP NAT GATEWAY VARIABLES ###
variable eip_nat_bandwidth_name {
    type = string
    description = "Insert the name of the EIP of Nat Gateway."
    default = "eip-nat-tf"
}
variable eip_nat_bandwidth_size {
    type = number
    description = "Insert the size of the bandwidth of EIP."
    default = 100
}

### DNAT VARIABLES ###
variable dnat_rule {
    type = list(object({
        dnat_protocol = string
        internal_range = string
        external_range = string
    }))
    description = "DNAT Variables."
}

##### SMN VARIABLES #####
### SMN TEMPLATE ###
variable create_smn_template {
    type = bool
    default = false
    description = "Insert true to create a SMN Template. Insert false to not create."
}
variable smn_template {
    type = list(object({
        smn_template_name = string
        smn_template_protocol = string
        smn_template_content = string
    }))
    description = "SMN Template variables."
}

### SMN TOPIC ###
variable create_smn_topic {
    type = bool
    description = "Insert true to create a SMN Topic. Insert false to not create."
    default = false
}
variable smn_topic {
    type = list(object({
        smn_topic_name = string
        smn_topic_displayname = string
        smn_topic_users = string
        smn_topic_services = string
        smn_topic_introduction = string
    }))
    description = "SMN Topic variables."
}

### SMN SUBSCRIPTION ###
variable create_smn_subscription {
    type = bool
    description = "Insert true to create a SMN Subscription. Insert false to not create."
    default = false
}
variable smn_subscription {
    type = list(object({
        smn_subscription_endpoint = string
        smn_subscription_protocol = string
        smn_subscription_remark = string
    }))
    description = "SMN Subscription variables."
}

##### WAF VARIABLES #####
variable create_waf_instance {
    type = bool
    description = "Inser true to create a WAF Instance. Insert false to not create."
    default = false
}

### WAF POLICY ###
variable waf_policy_name {
    type = string
    description = "Insert the WAF Policy name."
}

variable waf_policy_protection {
    type = string
    description = "Insert the WAF Policy protection mode."
}

variable waf_policy_robot {
    type = string
    description = "Insert the WAF Policy robot action."
}

variable waf_policy_level {
    type = number
    description = "Insert the WAF Policy level."
}

### WAF POLICY OPTIONS ###
variable waf_crawler_scanner {
    type = bool
    description = "Insert true to activate this option."
    default = false
}

variable waf_crawler_script {
    type = bool
    description = "Insert true to activate this option."
    default = false
}

variable waf_false_alarm {
    type = bool
    description = "Insert true to activate this option."
    default = false
}

variable waf_general {
    type = bool
    description = "Insert true to activate this option."
    default = false
}

variable waf_geolocation {
    type = bool
    description = "Insert true to activate this option."
    default = false
}

variable waf_information_leakage {
    type = bool
    description = "Insert true to activate this option."
    default = false
}

variable waf_known_attacks {
    type = bool
    description = "Insert true to activate this option."
    default = false
}

variable waf_precise {
    type = bool
    description = "Insert true to activate this option."
    default = false
}

variable waf_web_tamper {
    type = bool
    description = "Insert true to activate this option."
    default = false
}

variable waf_webshell {
    type = bool
    description = "Insert true to activate this option."
    default = false
}

### WAF RULE PRECISE ###
variable waf_rule_precise {
    type = list(object({
        waf_rule_precise_name = string
        waf_rule_precise_priority = string
        waf_rule_precise_action = string
        waf_rule_precise_description = string
        waf_rule_precise_status = number
    }))
}

### WAF GEOBLOCK ###
variable waf_geoblock {
    type = list(object({
        waf_geolocation_name = string
        waf_geolocation = string
        waf_geolocation_action = number
        waf_geolocation_description = string
    }))
}

### WAF DOMAINS ###
variable waf_domain {
    type = string
    description = "Insert your domain."
}

variable waf_proxy {
    type = bool
    description = "Insert true to enable proxy. Insert false to disable."
}

variable waf_domain_protect {
    type = number
    description = "Insert the WAF Domain protect status."
}

variable waf_client_protocol {
    type = string
    description = "Insert the client protocol."
}

variable waf_server_protocol {
    type = string
    description = "Insert the server protocol."
}

variable waf_server_address {
    type = string
    description = "Insert the server address."
}

variable waf_server_port {
    type = string
    description = "Insert the server port."
}

variable waf_server_type {
    type = string
    description = "Insert the server type."
}


##### Gemini DB Cassandra VARIABLES #####
variable create_gcassandra {
    type = bool
    description = "Insert true to create a Cassandra Instance. Insert false to not create."
    default = false
}

variable gcassandra_name {
    type = string
    description = "Cassandra Instance Name"
}

variable gcassandra_password {
    type = string
    description = "Cassandra Instance Password"
}

variable gcassandra_flavor {
    type = string
    description = "Casssandra Instance Flavor"
}

variable gcassandra_volume {
    type = number
    description = "Cassandra Instance Volume Size"
}

variable gcassandra_nodes {
    type = number
    description = "Cassandra Instance Nodes Number"
}

variable gcassandra_engine {
    type = string
    description = "Cassandra Engine (Only cassandra)"
}

variable gcassandra_version {
    type = string
    description = "Cassandra Version"
}

variable gcassandra_storage_engine {
    type = string
    description = "Cassandra Storage Engine"
}


##### Gemini DB Redis VARIABLES #####
variable create_gredis {
    type = bool
    description = "Insert true to create a Redis Instance. Insert false to not create"
    default = false
}

variable gredis_name {
    type = string
    description = "Redis Instance Name"
}

variable gredis_password {
    type = string
    description = "Redis Instance Password"
}

variable gredis_flavor {
    type = string
    description = "Redis Instance Flavor"
}

variable gredis_volume {
    type = number
    description = "Redis Instance Volume Size"
}

variable gredis_nodes {
    type = number
    description = "Redis Instance Nodes"
}

variable gredis_port {
    type = number
    description = "Redis Instance Port"
}

variable gredis_engine {
    type = string
    description = "Redis Engine (Only redis)"
}

variable gredis_version {
    type = string
    description = "Redis Version"
}

variable gredis_storage_engine {
    type = string
    description = "Redis Storage Engine (Only rocksDB)"
}

##### GeminiDB InfluxDB VARIABLES #####
variable create_ginflux {
    type = bool
    description = "Insert true to create a InfluxDB instance. Insert false to not create"
    default = false
}

variable ginflux_name {
    type = string
    description = "InfluxDB Instance Name"
}

variable ginflux_password {
    type = string
    description = "InfluxDB Instance password"
}

variable ginflux_flavor {
    type = string
    description = "InfluxDB Instance flavor"
}

variable ginflux_volume {
    type = number
    description = "InfluxDB Volume Size"
}

variable ginflux_node {
    type = number
    description = "InfluxDB Nodes"
}

##### VPC Endpoint VARIABLES #####
variable "create_vpcep" {
  type = bool
  default = false
  description = "Insert true to create the VPC Endpoint. Insert false to not create"
}

variable "service_private_id" {
  type = string
  description = "Private Service ID"
}

variable endpoint_dns {
    type = bool
    default = false
    description = "Insert True to create an endpoint with DNS. Insert false to not create"
}

variable endpoint_whitelist_enable {
    type = bool
    default = true
    description = "Insert true to create a whitelist to the Endpoint. Insert false to not create"
}

variable "endpoint_whitelist" {
    type = list(string)
    description = "Insert the CIDR of the IPs in the whitelist"
}