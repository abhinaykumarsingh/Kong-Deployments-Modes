resource "konnect_gateway_route" "anything" {
  name    = "anything-route"
  methods = ["GET"]
  paths   = ["/anything"]

  strip_path = false

  control_plane_id = var.control_plane_id

  service = {
    id = konnect_gateway_service.httpbin.id
  }
}