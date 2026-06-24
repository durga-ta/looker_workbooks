include: "/views/orders.view.lkml"

view: kpi_summary_orders {
  extends: [orders]

  # --- RELATIVE TIME DIMENSION FOR THE ROWS ---
  dimension_group: order_time {
    type: time
    timeframes: [raw, time, time_of_day, date, month]
    sql: ${TABLE}.`ORDER DATE` ;;
  }

  dimension: interval_30 {
    type: string
    label: "Interval 30"
    # Example generic SQL to create 30-min string buckets like "0:00", "0:30"
    sql: CONCAT(
           CAST(EXTRACT(HOUR FROM ${TABLE}.`ORDER DATE`) AS STRING),
           ':',
           LPAD(CAST(FLOOR(EXTRACT(MINUTE FROM ${TABLE}.`ORDER DATE`) / 30) * 30 AS STRING), 2, '0')
         ) ;;
  }

  measure: received_volume {
    type: count
    label: "Received Volume"
    value_format_name: decimal_0
  }

  measure: handled_volume {
    type: number
    label: "Handled Volume"
    sql: FLOOR(${received_volume} * 0.99) ;;
    value_format_name: decimal_0
  }

  measure: total_orders_kpi {
    type: count_distinct
    sql: ${TABLE}.`Order ID` ;;
    label: "Total Orders"
    value_format_name: decimal_0
  }

  measure: all_care_cpo {
    type: number
    sql: 1.0 * ${handled_volume} / NULLIF(${total_orders_kpi}, 0) ;;
    label: "All Care CPO"
    value_format_name: percent_2
  }

  measure: kpi_summary_ribbon {
    type: number
    sql: 1 ;;
    label: "KPI Summary Ribbon"
    required_fields: [received_volume, handled_volume, total_orders_kpi, all_care_cpo]

    html:
      @{kpi_ribbon_wrapper_start}
        @{kpi_header_ribbon}
        <tr>
          <td style="@{kpi_value_cell_style}">{{ received_volume._rendered_value }}</td>
          <td style="@{kpi_value_cell_style}">{{ handled_volume._rendered_value }}</td>
          <td style="@{kpi_value_cell_style}">{{ total_orders_kpi._rendered_value }}</td>
          <td style="@{kpi_value_cell_style}">{{ all_care_cpo._rendered_value }}</td>
        </tr>
      @{div_end} ;;
  }
  measure: cpo_forecast {
    type: number
    label: "CPO Forecast"
    sql: ${all_care_cpo} * 1.25 ;;
    value_format_name: percent_2
  }

  measure: cpo_percent_to_forecast {
    type: number
    label: "CPO % to Forecast"
    sql: ${all_care_cpo} / NULLIF(${cpo_forecast}, 0) ;;
    value_format_name: percent_2
  }
# DUMMY METRIC: Forecast Volume

  measure: forecast_volume {
    type: number
    label: "Forecast Volume"
    sql: FLOOR(${received_volume} * 1.05) ;;
    value_format_name: decimal_0
  }

  # DUMMY METRIC: Contacts to Forecast (%)
  measure: contacts_to_forecast {
    type: number
    label: "Contacts to Forecast"
    sql: 1.0 * ${received_volume} / NULLIF(${forecast_volume}, 0) ;;
    value_format_name: percent_0
  }

  # DUMMY METRIC: Forecast Orders
  measure: forecast_orders {
    type: number
    label: "Forecast Orders"
    sql: FLOOR(${total_orders_kpi} * 1.1) ;;
    value_format_name: decimal_0
  }

  # DUMMY METRIC: Orders % to Forecast
  measure: orders_percent_to_forecast {
    type: number
    label: "Orders % to Forecast"
    sql: 1.0 * ${total_orders_kpi} / NULLIF(${forecast_orders}, 0) ;;
    value_format_name: percent_0
  }

# --- MONTHLY PACING METRICS ---

  measure: locked_volume {
    type: number
    label: "Locked Volume"
    sql: FLOOR(${received_volume} * 1.2) ;;
    value_format_name: decimal_0
  }

  measure: wfm_handled {
    type: number
    label: "WFM Handled"
    sql: ${handled_volume} ;;
    value_format_name: decimal_0
  }

  measure: handled_percent_to_forecast {
    type: number
    label: "Handled Volum % To Forecast"
    sql: 1.0 * ${wfm_handled} / NULLIF(${forecast_volume}, 0) ;;
    value_format_name: percent_1
  }

  measure: volume_remaining {
    type: number
    label: "Volume Remaining"
    sql: ${forecast_volume} - ${wfm_handled} ;;
    value_format_name: decimal_0
  }

  measure: shortages {
    type: number
    label: "Shortages"
    group_label: "Contact Month (6/1/2026)"
    sql: ${volume_remaining} * 1.5 ;;
    value_format_name: decimal_0
  }

  measure: pacing_forecast {
    type: number
    label: "Pacing Forecast"
    group_label: "Contact Month (6/1/2026)"
    sql: 1.0 * ${wfm_handled} / NULLIF(${locked_volume}, 0) ;;
    value_format_name: percent_1
  }

  measure: service_level_percent {
    type: number
    label: "Service Level %"
    sql: 1.0 * ${handled_volume} / NULLIF(${received_volume}, 0) ;;
    value_format_name: percent_1
  }

  measure: abandon_rate {
    type: number
    label: "Abandon Rate %"
    sql: 1.0 - (${handled_volume} / NULLIF(${received_volume}, 0)) ;;
    value_format_name: percent_1
  }

  measure: day_of_oldest_date {
    type: date
    label: "Day of Oldest Date"
    sql: MIN(${TABLE}.`ORDER DATE`) ;; # Replace with your actual ticket creation date field
    html: {{ rendered_value | date: "%B %e, %Y" }} ;; # Formats to "June 2, 2026"
  }
  measure: qa_score_target {

    type: average
    label: "QA Score"
    # DUMMY PROXY: Hardcoding 382 to match the Tableau mockup visual,
    # or you could use something like AVG(${TABLE}.Profit) as a fake proxy.
    sql: 382 ;;
    value_format_name: decimal_0
  }
}
