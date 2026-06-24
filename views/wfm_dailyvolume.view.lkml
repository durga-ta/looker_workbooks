view: wfm_dailyvolume {
  sql_table_name: orders ;;

  dimension: order_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.`ORDER_ID` ;;
  }

  dimension_group: order_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.`ORDER DATE` ;;
  }

  measure: volume {
    type: sum
    label: "Received Volume"
    sql: ${TABLE}.`SALES` ;;
  }

  measure: week_avg {
    type: sum
    label: "3 Wk Avg (DAY)"
    sql: ${TABLE}.`PROFIT` ;;
  }

   }
