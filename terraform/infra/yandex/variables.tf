variable "yc_token" {
  type        = string
  description = "Security token or IAM token used for authentication in Yandex.Cloud. This can also be specified using environment variable YC_TOKEN."
  sensitive   = true
}
