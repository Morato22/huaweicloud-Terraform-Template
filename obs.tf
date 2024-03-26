# Create an OBS bucket
resource "huaweicloud_obs_bucket" "bucket" {
  for_each      = var.create_obs ? { for index in var.obs_tf : index.bucket_name => index } : {}
  bucket        = each.value.bucket_name
  acl           = each.value.bucket_acl
  versioning    = each.value.bucket_versioning
  storage_class = each.value.bucket_storage
}