view: logistics_marketview {
  sql_table_name: orders ;;

  dimension: order_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.`ORDER_ID` ;;
  }

  # Header part ----------------------------------------------------

  parameter: Date_Range {
    type: string
    label: "Date Range"
    default_value: "last 52 weeks"
    allowed_value: { label: "last 52 weeks" value: "last 52 weeks" }
    allowed_value: { label: "last 26 weeks" value: "last 26 weeks" }
    allowed_value: { label: "last 13 weeks" value: "last 13 weeks" }
    allowed_value: { label: "last 4 weeks"  value: "last 4 weeks" }
    allowed_value: { label: "YTD"           value: "YTD" }
  }

  parameter: time_display_value {
    type: number
    label: "Time Display Period (Value)"
    description: "Enter the number of units to display (e.g., 10)"
    default_value: "10"
  }

  parameter: time_display_granularity {
    type: unquoted
    label: "Time Display Period (Unit)"
    description: "Select whether the value is in Months, ISO Weeks, or Days"
    default_value: "day"

    allowed_value: {
      label: "Month"
      value: "month"
    }
    allowed_value: {
      label: "ISO Week"
      value: "week"
    }
    allowed_value: {
      label: "Day"
      value: "day"
    }
  }

  dimension: date_filter {
    type: string
    hidden: yes
    sql:
      CASE
        WHEN {% parameter Date_Range %} = 'last 52 weeks' THEN
          CASE WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -357)
               AND date_trunc('week', ${TABLE}.`Order Date`) <= date_trunc('week', ${max_date.max_week_ending})
               THEN date_trunc('week', ${TABLE}.`Order Date`) END
        WHEN {% parameter Date_Range %} = 'last 26 weeks' THEN
          CASE WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -175)
               AND date_trunc('week', ${TABLE}.`Order Date`) <= date_trunc('week', ${max_date.max_week_ending})
               THEN date_trunc('week', ${TABLE}.`Order Date`) END
        WHEN {% parameter Date_Range %} = 'last 13 weeks' THEN
          CASE WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -84)
               AND date_trunc('week', ${TABLE}.`Order Date`) <= date_trunc('week', ${max_date.max_week_ending})
               THEN date_trunc('week', ${TABLE}.`Order Date`) END
        WHEN {% parameter Date_Range %} = 'last 4 weeks' THEN
          CASE WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -21)
               AND date_trunc('week', ${TABLE}.`Order Date`) <= date_trunc('week', ${max_date.max_week_ending})
               THEN date_trunc('week', ${TABLE}.`Order Date`) END
        WHEN {% parameter Date_Range %} = 'YTD' THEN
          CASE WHEN year(date_trunc('week', ${TABLE}.`Order Date`)) = year(${max_date.max_week_ending})
               AND date_trunc('week', ${TABLE}.`Order Date`) <= date_trunc('week', ${max_date.max_week_ending})
               THEN date_trunc('week', ${TABLE}.`Order Date`) END
      END ;;
  }

  dimension: date_filter_comparison {
    type: string
    hidden: yes
    sql:
      CASE
        WHEN {% parameter Date_Range %} = 'last 52 weeks' THEN
          CASE WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -721)
               AND date_trunc('week', ${TABLE}.`Order Date`) <= date_add(date_trunc('week', ${max_date.max_week_ending}), -364)
               THEN date_trunc('week', ${TABLE}.`Order Date`) END
        WHEN {% parameter Date_Range %} = 'last 26 weeks' THEN
          CASE WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -357)
               AND date_trunc('week', ${TABLE}.`Order Date`) <= date_add(date_trunc('week', ${max_date.max_week_ending}), -182)
               THEN date_trunc('week', ${TABLE}.`Order Date`) END
        WHEN {% parameter Date_Range %} = 'last 13 weeks' THEN
          CASE WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -175)
               AND date_trunc('week', ${TABLE}.`Order Date`) <= date_add(date_trunc('week', ${max_date.max_week_ending}), -91)
               THEN date_trunc('week', ${TABLE}.`Order Date`) END
        WHEN {% parameter Date_Range %} = 'last 4 weeks' THEN
          CASE WHEN date_trunc('week', ${TABLE}.`Order Date`) > date_add(date_trunc('week', ${max_date.max_week_ending}), -56)
               AND date_trunc('week', ${TABLE}.`Order Date`) <= date_add(date_trunc('week', ${max_date.max_week_ending}), -28)
               THEN date_trunc('week', ${TABLE}.`Order Date`) END
        WHEN {% parameter Date_Range %} = 'YTD' THEN
          CASE WHEN year(date_trunc('week', ${TABLE}.`Order Date`)) = year(add_months(${max_date.max_week_ending}, -12))
               AND date_trunc('week', ${TABLE}.`Order Date`) <= add_months(date_trunc('week', ${max_date.max_week_ending}), -12)
               THEN date_trunc('week', ${TABLE}.`Order Date`) END
      END ;;
  }

  dimension: is_in_time_display_period {

    type: yesno
    hidden: yes
    sql:
      {% if time_display_granularity._parameter_value == 'day' %}
        ${TABLE}.`Order Date` >= DATE_SUB(${max_date.max_week_ending}, CAST({% parameter time_display_value %} AS INT))
      {% elsif time_display_granularity._parameter_value == 'week' %}
        ${TABLE}.`Order Date` >= DATE_TRUNC('WEEK', DATE_SUB(${max_date.max_week_ending}, CAST({% parameter time_display_value %} * 7 AS INT)))
      {% else %}
        ${TABLE}.`Order Date` >= DATE_TRUNC('MONTH', ADD_MONTHS(${max_date.max_week_ending}, -1 * CAST({% parameter time_display_value %} AS INT)))
      {% endif %} ;;
  }

  # DELIVERY TIME SECTIONS------------------------------------------

  dimension: delivery_weekday {
    type: string
    label: "Weekday"
    group_label: "Delivery Time"
    sql: ${TABLE}.`SHIP MODE` ;;
  }

  dimension: delivery_mealtime {
    type: string
    label: "Mealtime"
    group_label: "Delivery Time"
    sql: ${TABLE}.`SEGMENT` ;;
  }

  # GHD DISTRICTS SECTION -----------------------------------------

  dimension:  cbsa{
    type: string
    label: "CBSA"
    group_label: "GHD District"
    sql: ${TABLE}.`COUNTRY` ;;
  }

  dimension: logistics {
    type: string
    label: "Logistic Seg"
    group_label: "GHD District"
    sql: ${TABLE}.`REGION` ;;
  }

  dimension: key_city {
    type: string
    label: "Key City"
    group_label: "GHD District"
    sql: ${TABLE}.`CITY` ;;
  }

  dimension: district {
    type: string
    label: "District"
    group_label: "GHD District"
    sql: ${TABLE}.`STATE` ;;
  }

  dimension: wonder_market {
    type: string
    label: "Wonder Mkt"
    group_label: "GHD District"
    description: "Calculated Wonder Market category based on region data"
    sql:
      CASE
        WHEN ${TABLE}.`REGION` = 'Central' THEN 'Wonder Central Mkt'
        WHEN ${TABLE}.`REGION` = 'East' THEN 'Wonder East Mkt'
        ELSE 'Standard Mkt'
      END ;;
  }

  dimension: district_density {
    type: string
    label: "District Density"
    group_label: "GHD District / District Density & Urban Classif.."
    description: "Density classification mapped from postal codes"
    sql:
      CASE
        WHEN ${TABLE}.`POSTAL CODE` LIKE '10%' THEN 'High Density'
        WHEN ${TABLE}.`POSTAL CODE` LIKE '90%' THEN 'Medium Density'
        ELSE 'Low Density'
      END ;;
  }

  dimension: urban_classification {
    type: string
    label: "Urban Classification"
    group_label: "GHD District / District Density & Urban Classif.."
    description: "Urban or suburban tiering based on state boundaries"
    sql:
      CASE
        WHEN ${TABLE}.`STATE` IN ('New York', 'California') THEN 'Tier 1 Urban'
        ELSE 'Tier 2 Suburban'
      END ;;
  }

  measure: current_sales {
    type: sum
    label: "Current Sales"
    group_label: "Sales Metrics"
    sql: CASE WHEN ${date_filter} IS NOT NULL THEN ${TABLE}.`SALES` ELSE 0 END ;;
    value_format_name: usd_0
  }

  measure: previous_sales {
    type: sum
    label: "Previous Sales"
    group_label: "Sales Metrics"
    sql: CASE WHEN ${date_filter_comparison} IS NOT NULL THEN ${TABLE}.`SALES` ELSE 0 END ;;
    value_format_name: usd_0
  }

  measure: current_orders {
    type: count_distinct
    label: "Current Orders"
    group_label: "Order Metrics"
    sql: ${TABLE}.`ORDER ID` ;;
    filters: [date_filter: "-NULL"]
  }

  measure: previous_orders {
    type: count_distinct
    label: "Previous Orders"
    group_label: "Order Metrics"
    sql: ${TABLE}.`ORDER ID` ;;
    filters: [date_filter_comparison: "-NULL"]
  }


}
