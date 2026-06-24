view: logistics_orders {
  # This creates an independent mock dataset containing the exact rows from image_977e58.png
  derived_table: {
    sql:
      SELECT 'Assisted Call Center' AS lob, 'Prime' AS time_group, '16:00' AS start_time, '21:00' AS end_time
      UNION ALL SELECT 'Corporate Care', 'After Hours', '0:00', '7:00'
      UNION ALL SELECT 'Corporate Care', 'After Hours', '23:00', '23:59'
      UNION ALL SELECT 'Customer Care', 'After Hours', '2:00', '6:00'
      UNION ALL SELECT 'Customer Care', 'Prime', '17:00', '21:00'
      UNION ALL SELECT 'CXT Fraud', 'After Hours', '0:00', '7:59'
      UNION ALL SELECT 'CXT Fraud', 'After Hours', '22:30', '23:59'
      UNION ALL SELECT 'DET', 'After Hours', '0:00', '7:00'
      UNION ALL SELECT 'DET', 'After Hours', '23:00', '23:59'
      UNION ALL SELECT 'Driver Care', 'After Hours', '2:00', '7:00'
      UNION ALL SELECT 'Driver Care', 'Prime', '16:00', '21:00'
      UNION ALL SELECT 'PnP', 'After Hours', '0:00', '5:00'
      UNION ALL SELECT 'PnP', 'After Hours', '11:00', '14:00'
      UNION ALL SELECT 'PnP', 'Prime', '17:00', '21:00'
      UNION ALL SELECT 'Restaurant Care', 'After Hours', '0:00', '7:00'
      UNION ALL SELECT 'Restaurant Care', 'After Hours', '23:00', '23:59'
      UNION ALL SELECT 'Restaurant Care', 'Prime', '15:00', '20:00'
    ;;
  }

  dimension: lob {
    type: string
    label: "Lob"
    sql: ${TABLE}.lob ;;
  }

  dimension: time_group {
    type: string
    label: "Time Group"
    sql: ${TABLE}.time_group ;;
  }

  dimension: start_time {
    type: string
    label: "Start Time"
    sql: ${TABLE}.start_time ;;
  }

  dimension: end_time {
    type: string
    label: "End Time"
    sql: ${TABLE}.end_time ;;
  }
}
