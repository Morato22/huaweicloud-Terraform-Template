resource huaweicloud_smn_message_template template {
    for_each = var.create_smn_template ? {for index in var.smn_template : index.smn_template_name => index} : {}
    name = each.value.smn_template_name
    protocol = each.value.smn_template_protocol
    content = each.value.smn_template_content
}

resource huaweicloud_smn_topic topic {
    for_each = var.create_smn_topic ? {for index in var.smn_topic : index.smn_topic_name => index} : {}
    name = each.value.smn_topic_name
    display_name = each.value.smn_topic_displayname
    users_publish_allowed = each.value.smn_topic_users
    services_publish_allowed = each.value.smn_topic_services
    introduction = each.value.smn_topic_introduction
}

resource huaweicloud_smn_subscription subscription {
    for_each = var.create_smn_subscription ? {for index in var.smn_subscription : index.smn_subscription_endpoint => index} : {}
    topic_urn = huaweicloud_smn_topic.topic["topic-tf"].id
    endpoint = each.value.smn_subscription_endpoint
    protocol = each.value.smn_subscription_protocol
    remark = each.value.smn_subscription_remark
}