resource "huaweicloud_waf_cloud_instance" "waf_tf" {
    count = var.create_waf_instance ? 1 : 0
    charging_mode = "postPaid"
    website = "hec-hk"
}

resource "huaweicloud_waf_policy" "policy_tf" {
    count = var.create_waf_instance ? 1 : 0
    name = var.waf_policy_name
    protection_mode = var.waf_policy_protection
    robot_action = var.waf_policy_robot
    level = var.waf_policy_level

    options {
        crawler_scanner                = var.waf_crawler_scanner
        crawler_script                 = var.waf_crawler_script
        false_alarm_masking            = var.waf_false_alarm
        general_check                  = var.waf_general
        geolocation_access_control     = var.waf_geolocation
        information_leakage_prevention = var.waf_information_leakage
        known_attack_source            = var.waf_known_attacks
        precise_protection             = var.waf_precise
        web_tamper_protection          = var.waf_web_tamper
        webshell                       = var.waf_webshell
    }
    depends_on = [ huaweicloud_waf_cloud_instance.waf_tf ]
}

resource "huaweicloud_waf_rule_precise_protection" "precise_protection_block" {
    for_each = var.create_waf_instance ? {for index in var.waf_rule_precise : index.waf_rule_precise_name => index} : {}
    policy_id             = huaweicloud_waf_policy.policy_tf[0].id
    name                  = each.value.waf_rule_precise_name
    priority              = each.value.waf_rule_precise_priority
    action                = each.value.waf_rule_precise_action
    description           = each.value.waf_rule_precise_description
    status                = each.value.waf_rule_precise_status

    conditions {
        field = "url"
        logic = "contain"
        content = "/"
    }
}

resource "huaweicloud_waf_rule_geolocation_access_control" "geoblock" {
    for_each = var.create_waf_instance ? {for index in var.waf_geoblock : index.waf_geolocation_name => index} : {}
    policy_id             = huaweicloud_waf_policy.policy_tf[0].id
    name                  = each.value.waf_geolocation_name
    geolocation           = each.value.waf_geolocation
    action                = each.value.waf_geolocation_action
    description           = each.value.waf_geolocation_description
}

resource "huaweicloud_waf_certificate" "certificate_tf" {
    name = "cert_1"
    
#Replace here
    certificate = <<EOT
-----BEGIN CERTIFICATE-----
      ....
-----END CERTIFICATE-----
EOT
#Replace here
  private_key = <<EOT
-----BEGIN PRIVATE KEY-----
  ....
-----END PRIVATE KEY-----
EOT

depends_on = [ huaweicloud_waf_cloud_instance.waf_tf  ]
}

resource "huaweicloud_waf_domain" "domain_tf" {
    count = var.create_waf_instance ? 1 : 0
    domain = var.waf_domain
    proxy = var.waf_proxy
    charging_mode = "postPaid"
    protect_status = var.waf_domain_protect
    certificate_id = huaweicloud_waf_certificate.certificate_tf.id
    certificate_name = huaweicloud_waf_certificate.certificate_tf.name
    policy_id = huaweicloud_waf_policy.policy_tf[0].id

    server {
        client_protocol = var.waf_client_protocol
        server_protocol = var.waf_server_protocol
        address = var.waf_server_address
        port = var.waf_server_port
        type = var.waf_server_type
    }
    depends_on =[huaweicloud_waf_cloud_instance.waf_tf] 
}