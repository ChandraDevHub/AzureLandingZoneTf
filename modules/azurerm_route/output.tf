output "o_route_dtls" {
  value = {
    for r_key, r in azurerm_route.nw_routes :
    r_key => {
      id   = r.id
      name = r.name
    }
  }
}