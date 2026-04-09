variable "control_plane_id" {
  description = "The ID of the Konnect control plane."
  type        = string
  sensitive   = true
}

variable "konnect_token" {
  description = "Konnect personal access token"
  type        = string
  sensitive   = true
}