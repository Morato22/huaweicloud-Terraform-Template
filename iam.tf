# Create an Enterprise Project
resource "huaweicloud_enterprise_project" "ep_iam" {
    count = var.create_ep ? 1 : 0
    name = var.ep_iam_name
    enable = true
}

# Create IAM user
resource "huaweicloud_identity_user" "user" {
    for_each = var.create_iam ? {for index in var.iam_tf : index.iam_name => index} : {}
    name = each.value.iam_name
    password = each.value.iam_password
}

# Create roles
resource "huaweicloud_identity_role" "role" {
    for_each = var.create_iam_role ? {for index in var.iam_role : index.iam_role_name => index} : {}
    name = each.value.iam_role_name
    type = each.value.iam_role_type
    description = each.value.iam_role_description
    policy = each.value.iam_role_policy
}

# Create groups
resource "huaweicloud_identity_group" "group" {
    for_each = var.create_iam_group ? {for index in var.iam_group : index.iam_group_name => index} : {}
    name = each.value.iam_group_name
}

# Assign roles
resource "huaweicloud_identity_group_role_assignment" "group_assignment" {
    count = var.create_iam ? 1 : 0
    role_id = huaweicloud_identity_role.role["Role-TF"].id
    group_id = huaweicloud_identity_group.group["group1"].id
    enterprise_project_id = huaweicloud_enterprise_project.ep_iam[0].id
}

# Assign members to a group
resource "huaweicloud_identity_group_membership" "membership" {
    count = var.create_iam ? 1 : 0
    group = huaweicloud_identity_group.group["group1"].id
    users = [huaweicloud_identity_user.user["Terraform-IAM"].id, huaweicloud_identity_user.user["Terraform-IAM2"].id]
}