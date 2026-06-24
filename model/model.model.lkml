connection: "data-bricks"

include: "/views/*.view.lkml"
include: "/dashboards/*.dashboard"

#datagroup: daily_refresh {
 # sql_trigger: SELECT MAX(orderid) FROM orders ;;
  #max_cache_age: "24 hours"
#}

explore: orders {
  #access_filter: {
  #  field: orders.region
  #  user_attribute: region_access
  #}
  join: max_date {
    type: cross
    relationship: one_to_one
  }
  #persist_for: "24 hours"
   #sql_always_where: ${orders.city} = 'New York City' ;;
  #always_filter: {
  #  filters: [orders.category: "Furniture"]
 # }
  join: returns {
    type: left_outer
    relationship: many_to_many
    sql_on: ${orders.order_id}=${returns.order_id} ;;
  }
}
explore: people {}

explore: logistics_orders {}
explore: ticket_sla_thresholds {}
explore: kpi_summary_orders {
  join: max_date {
    type: cross
    relationship: one_to_one
  }
}
