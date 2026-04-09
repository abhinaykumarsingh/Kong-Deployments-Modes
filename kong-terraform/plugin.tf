resource "konnect_gateway_plugin_key_auth" "key_auth" {
  control_plane_id  = var.control_plane_id

  route = {
    id = konnect_gateway_route.anything.id
  }

  config = {
    key_names = ["apikey"]
    key_in    = ["header"]   # or ["header", "query"]
  }
}


resource "konnect_gateway_plugin_rate_limiting" "my_gatewaypluginratelimiting" {
  config = {
    minute        = 3
    hour          = 100
    day           = 1000
    limit_by      = "consumer"
    policy        = "local"
    error_code    = 429
    error_message = "API rate limit exceeded"
  }

  control_plane_id = var.control_plane_id
  enabled          = true

  service = {
    id = konnect_gateway_service.httpbin.id
  }
}