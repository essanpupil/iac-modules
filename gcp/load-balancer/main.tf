# 1. Reserve a Global Static External IP
resource "google_compute_global_address" "lb_ip" {
  name = "${var.lb_name}-static-ip"
}

# 2. Forwarding Rule (Frontend)
resource "google_compute_global_forwarding_rule" "http_frontend" {
  name                  = "${var.lb_name}-forwarding-rule"
  ip_address            = google_compute_global_address.lb_ip.address
  ip_protocol           = "TCP"
  port_range            = "80"
  target                = google_compute_target_http_proxy.http_proxy.id
  load_balancing_scheme = "EXTERNAL_MANAGED" # Defines it as a modern Application Load Balancer
}

# 3. Target HTTP Proxy
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "${var.lb_name}-target-proxy"
  url_map = google_compute_url_map.url_map.id
}

# 4. URL Map (Routing Table)
resource "google_compute_url_map" "url_map" {
  name            = "${var.lb_name}-url-map"
  default_service = google_compute_backend_service.backend.id
}

# 5. Backend Service
resource "google_compute_backend_service" "backend" {
  name                  = "${var.lb_name}-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 30

  backend {
    group = var.instance_group_id # Link your Instance Group or Network Endpoint Group (NEG)
  }

  health_checks = [google_compute_health_check.http_check.id]
}

# Health Check required by Backend Service
resource "google_compute_health_check" "http_check" {
  name = "${var.lb_name}-health-check"

  http_health_check {
    port = 80
    path = "/"
  }
}
