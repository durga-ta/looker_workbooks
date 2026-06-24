view: ticket_sla_thresholds {
  # Mocking up the exact matrix grid data points visible in image_95bb02.png
  derived_table: {
    sql:
      SELECT 'Corporate Admin Support' AS group_name, 'Normal Ticket' AS channel, 'Normal Ticket' AS ticket_type, 172800 AS asa_seconds
      UNION ALL SELECT 'Corporate Care', 'Normal Ticket', 'Normal Ticket', 21600
      UNION ALL SELECT 'Corporate Care', 'Urgent Ticket', 'Urgent Ticket', 240
      UNION ALL SELECT 'Corporate Concierge', 'Normal Ticket', 'Normal Ticket', 86400
      UNION ALL SELECT 'Courier Concierge', 'Call', 'Call', 172800
      UNION ALL SELECT 'Courier Concierge', 'Normal', 'Normal Ticket', 172800
      UNION ALL SELECT 'Courier Concierge', 'Ticket', 'Urgent Ticket', 172800
      UNION ALL SELECT 'Customer Care', 'Normal Ticket', 'Normal Ticket', 86400
      UNION ALL SELECT 'CXT', 'Normal Ticket', 'Normal Ticket', 86400
      UNION ALL SELECT 'CXT Fraud', 'Normal Ticket', 'Normal Ticket', 86400
      UNION ALL SELECT 'CXT Fraud', 'Urgent Ticket', 'Urgent Ticket', 1800
      UNION ALL SELECT 'DaaS', 'Normal Ticket', 'Normal Ticket', 43200
      UNION ALL SELECT 'DET', 'Normal Ticket', 'Normal Ticket', 21600
      UNION ALL SELECT 'DET', 'Social Media', 'Social Media', 300
      UNION ALL SELECT 'Driver Accounting', 'Normal Ticket', 'Normal Ticket', 172800
      UNION ALL SELECT 'Driver Care', 'Normal Ticket', 'Normal Ticket', 86400
      UNION ALL SELECT 'Elite Care', 'Normal Ticket', 'Normal Ticket', 259200
      UNION ALL SELECT 'Escalations and Technical Care', 'Normal Ticket', 'Normal Ticket', 21600
      UNION ALL SELECT 'Escalations and Technical Care', 'Urgent Ticket', 'Urgent Ticket', 21600
      UNION ALL SELECT 'Fraud Investigation Office', 'Normal Ticket', 'Normal Ticket', 604800
      UNION ALL SELECT 'Premier Customer Care', 'Normal Ticket', 'Normal Ticket', 86400
      UNION ALL SELECT 'Premier Customer Care', 'Urgent Ticket', 'Urgent Ticket', 86400
    ;;
  }

  dimension: group_name {
    type: string
    label: "Group Name"
    sql: ${TABLE}.group_name ;;
  }

  dimension: channel {
    type: string
    label: "Channel"
    sql: ${TABLE}.channel ;;
  }

  dimension: ticket_type {
    type: string
    label: "Ticket Type"
    sql: ${TABLE}.ticket_type ;;
  }

  dimension: asa_seconds {
    type: number
    label: "ASA (seconds)"
    sql: ${TABLE}.asa_seconds ;;
    value_format_name: decimal_0
  }

  # Looker calculates this column dynamically on the fly
  dimension: asa_minutes {
    type: number
    label: "ASA Minutes"
    sql: ${asa_seconds} / 60.0 ;;
    value_format_name: decimal_0
  }

  # Looker calculates this column dynamically on the fly
  dimension: asa_hours {
    type: number
    label: "ASA Hours"
    sql: ${asa_seconds} / 3600.0 ;;
    value_format_name: decimal_2
  }
}
