output "o_route_table_dtls" {
  value = {
    for rt_key, rt in azurerm_route_table.route_tables :
    rt_key => {
      id   = rt.id
      name = rt.name
    }
  }
}
