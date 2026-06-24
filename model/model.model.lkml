connection: "data-bricks"

include: "/views/*.view.lkml"
include: "/dashboards/*.dashboard"

#datagroup: daily_refresh {
 # sql_trigger: SELECT MAX(orderid) FROM orders ;;
  #max_cache_age: "24 hours"
#}

explore: orders {

  join: max_date {
    type: cross
    relationship: one_to_one
  }
  join: topline_ads {
    type: left_outer
    relationship: one_to_one
    sql_on: ${orders.order_id} = ${topline_ads.order_id} ;;
  }

  join: returns {
    type: left_outer
    relationship: many_to_many
    sql_on: ${orders.order_id}=${returns.order_id} ;;
  }
}

explore: people {}

explore: logistics_marketview {
  label: "Logistics Market View"
  sql_always_where: ${logistics_marketview.is_in_time_display_period} ;;

  join: max_date {
    type: cross
    relationship: one_to_one
  }
}

explore: wfm_dailyvolume{
  label: "Daily Volume to 3 Wk Avg"

  join: max_date {
    type: cross
    relationship: one_to_one
  }

}
