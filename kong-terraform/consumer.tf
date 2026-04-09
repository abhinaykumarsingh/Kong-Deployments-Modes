resource "konnect_gateway_consumer" "user1" {
  username          = "abhinay"
  control_plane_id  = var.control_plane_id
}

resource "konnect_gateway_key_auth" "my_keyauth" {
  key              = "spiderkey"
  consumer_id      = konnect_gateway_consumer.user1.id
  control_plane_id = var.control_plane_id
}