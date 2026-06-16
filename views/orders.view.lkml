view: orders {
  sql_table_name: default.`orders` ;;
  drill_fields: [order_id]

  dimension: order_id {
    primary_key: yes
    type: string
    description: "The unique identifier for each transaction. Use this for counting specific orders."
    sql: ${TABLE}.`ORDER ID` ;;
  }
  dimension: category {
    type: string
    description: "The broad grouping of products, such as Furniture, Technology, or Office Supplies."
    sql: ${TABLE}.`CATEGORY` ;;
  }
  dimension: city {
    type: string
    sql: ${TABLE}.`CITY` ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.`COUNTRY` ;;
  }
  dimension: customer_id {
    type: string
    sql: ${TABLE}.`CUSTOMER ID` ;;
  }
  dimension: customer_name {
    type: string
    description: "The name of the person who placed the order."
    sql: ${TABLE}.`CUSTOMER NAME` ;;
  }
  measure: discount {
    type: sum
    sql: ${TABLE}.`DISCOUNT` ;;
  }
  dimension_group: order_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.`ORDER DATE` ;;
  }
  dimension: postal_code {
    type: zipcode
    map_layer_name:  us_zipcode_tabulation_areas
    sql: ${TABLE}.`POSTAL CODE` ;;
  }
  dimension: product_id {
    type: string
    sql: ${TABLE}.`PRODUCT ID` ;;
  }
  dimension: product_name {
    type: string
    sql: ${TABLE}.`PRODUCT NAME` ;;
  }
  measure: profit {
    type: sum
    sql: ${TABLE}.`PROFIT` ;;
  }
  measure: quantity {
    type: sum
    sql: ${TABLE}.`QUANTITY` ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.`REGION` ;;
  }
  dimension: row_id {
    type: number
    sql: ${TABLE}.`ROW ID` ;;
  }
  measure: sales {
    type: sum
    sql: ${TABLE}.`SALES` ;;
  }
  dimension: segment {
    type: string
    sql: ${TABLE}.`SEGMENT` ;;
  }
  dimension_group: ship {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.`SHIP DATE` ;;
  }
  dimension: ship_mode {
    type: string
    sql: ${TABLE}.`SHIP MODE` ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.`STATE` ;;
  }
  dimension: subcategory {
    type: string
    description: "More specific product grouping (e.g., Chairs, Phones, Paper)."
    sql: ${TABLE}.`Sub-Category` ;;
  }
  measure: count {
    type: count
    drill_fields: [order_id, product_name, customer_name]
  }

  parameter: Date_Range {
    type: string
    label: "date range"
    default_value: "last 52 weeks"

    allowed_value: {
      label: "last 52 weeks"
      value: "last 52 weeks"
    }
    allowed_value: {
      label: "last 26 weeks"
      value: "last 26 weeks"
    }
    allowed_value: {
      label: "last 13 weeks"
      value: "last 13 weeks"
    }
    allowed_value: {
      label: "last 4 weeks"
      value: "last 4 weeks"
    }
    allowed_value: {
      label: "YTD"
      value: "YTD"
    }
  }

  dimension: date_filter {
    type: string
    label: "date_filter"
    hidden: no
    sql:
        CASE
      WHEN {% parameter Date_Range %} = 'last 52 weeks' THEN
        CASE
          WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -357)
           AND date_trunc('week', ${TABLE}.`Order Date`) <= date_trunc('week', ${max_date.max_week_ending})
          THEN date_trunc('week', ${TABLE}.`Order Date`)
        END

      WHEN {% parameter Date_Range %} = 'last 26 weeks' THEN
      CASE
      WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -175)
      AND date_trunc('week', ${TABLE}.`Order Date`) <= date_trunc('week', ${max_date.max_week_ending})
      THEN date_trunc('week', ${TABLE}.`Order Date`)
      END

      WHEN {% parameter Date_Range %} = 'last 13 weeks' THEN
      CASE
      WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -84)
      AND date_trunc('week', ${TABLE}.`Order Date`) <= date_trunc('week', ${max_date.max_week_ending})
      THEN date_trunc('week', ${TABLE}.`Order Date`)
      END

      WHEN {% parameter Date_Range %} = 'last 4 weeks' THEN
      CASE
      WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -21)
      AND date_trunc('week', ${TABLE}.`Order Date`) <= date_trunc('week', ${max_date.max_week_ending})
      THEN date_trunc('week', ${TABLE}.`Order Date`)
      END

      WHEN {% parameter Date_Range %} = 'YTD' THEN
      CASE
      WHEN year(date_trunc('week', ${TABLE}.`Order Date`)) = year(${max_date.max_week_ending})
      AND date_trunc('week', ${TABLE}.`Order Date`) <= date_trunc('week', ${max_date.max_week_ending})
      THEN date_trunc('week', ${TABLE}.`Order Date`)
      END
      END ;;
  }

  dimension: date_filter_comparison {

    type: string
    label: "date_filter_comparison"
    hidden: no
    sql:
        CASE
      WHEN {% parameter Date_Range %} = 'last 52 weeks' THEN
        CASE
          -- Period: 52 weeks prior to the "Current" 52-week window
          WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -721)
           AND date_trunc('week', ${TABLE}.`Order Date`) <= date_add(date_trunc('week', ${max_date.max_week_ending}), -364)
          THEN date_trunc('week', ${TABLE}.`Order Date`)
        END

      WHEN {% parameter Date_Range %} = 'last 26 weeks' THEN
      CASE
      -- Period: 26 weeks prior to the "Current" 26-week window
      WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -357)
      AND date_trunc('week', ${TABLE}.`Order Date`) <= date_add(date_trunc('week', ${max_date.max_week_ending}), -182)
      THEN date_trunc('week', ${TABLE}.`Order Date`)
      END

      WHEN {% parameter Date_Range %} = 'last 13 weeks' THEN
      CASE
      WHEN date_trunc('week', ${TABLE}.`Order Date`) >= date_add(date_trunc('week', ${max_date.max_week_ending}), -175)
      AND date_trunc('week', ${TABLE}.`Order Date`) <= date_add(date_trunc('week', ${max_date.max_week_ending}), -91)
      THEN date_trunc('week', ${TABLE}.`Order Date`)
      END

      WHEN {% parameter Date_Range %} = 'last 4 weeks' THEN
      CASE
      WHEN date_trunc('week', ${TABLE}.`Order Date`) > date_add(date_trunc('week', ${max_date.max_week_ending}), -56)
      AND date_trunc('week', ${TABLE}.`Order Date`) <= date_add(date_trunc('week', ${max_date.max_week_ending}), -28)
      THEN date_trunc('week', ${TABLE}.`Order Date`)
      END

      WHEN {% parameter Date_Range %} = 'YTD' THEN
      CASE
      -- Prior Year to Date (PYTD): Same year-day range, but for the previous year
      WHEN year(date_trunc('week', ${TABLE}.`Order Date`)) = year(add_months(${max_date.max_week_ending}, -12))
      AND date_trunc('week', ${TABLE}.`Order Date`) <= add_months(date_trunc('week', ${max_date.max_week_ending}), -12)
      THEN date_trunc('week', ${TABLE}.`Order Date`)
      END
      END ;;
  }
  measure: Sales_date_filter_not_null{
    type: sum
    label: "Current Sales"
    sql:
            CASE WHEN ${date_filter} IS NOT NULL THEN ${TABLE}.`SALES`
            ELSE 0
            END;;
    value_format_name: usd_0
  }
  measure: Sales_date_filter_comparison_not_null{
    type: sum
    label: "Previous Sales"
    sql:
            CASE WHEN ${date_filter_comparison} IS NOT NULL THEN ${TABLE}.`SALES`
            ELSE 0
            END;;
    value_format_name: usd_0
  }
  measure: current_orders_filtered {
    type: count_distinct
    label: "Current Order"
    sql: ${TABLE}.`ORDER ID` ;;
    filters: [date_filter: "-NULL"]  # This means "Where date_filter is NOT NULL"
  }
  measure: Orders_date_filter_comparison_not_null {
    type: count_distinct
    label: "Previous Order"
    sql: ${TABLE}.`ORDER ID` ;;
    filters: [date_filter_comparison: "-NULL"]  # This means "Where date_filter is NOT NULL"
  }
  measure: Profit_date_filter_not_null{
    type: sum
    label: "Current Profit"
    sql:
            CASE WHEN ${date_filter} IS NOT NULL THEN ${TABLE}.`PROFIT`
            ELSE 0
            END;;
    value_format_name: usd_0
  }
  measure: Profit_date_filter_comparison_not_null{
    type: sum
    label: "Previous Profit"
    sql:
            CASE WHEN ${date_filter_comparison} IS NOT NULL THEN ${TABLE}.`PROFIT`
            ELSE 0
            END;;
    value_format_name: usd_0
  }
  measure: Discount_date_filter_not_null{
    type: sum
    label: "Current Discount"
    sql:
            CASE WHEN ${date_filter} IS NOT NULL THEN ${TABLE}.`DISCOUNT`
            ELSE 0
            END;;
    value_format_name: usd_0
  }
  measure: Discount_date_filter_comparison_not_null{
    type: sum
    label: "Previous Discount"
    sql:
            CASE WHEN ${date_filter_comparison} IS NOT NULL THEN ${TABLE}.`DISCOUNT`
            ELSE 0
            END;;
    value_format_name: usd_0
  }
#durga-added:

  # 1. Percentage Change Calculation
  measure: mock_wow_change {
    type: number
    sql: (${Sales_date_filter_not_null} - ${Sales_date_filter_comparison_not_null}) / NULLIF(${Sales_date_filter_comparison_not_null}, 0) ;;
    value_format_name: percent_1
  }
 # 2. Dynamic GTV KPI Tile
  measure: dynamic_gtv_kpi {
    type: number
    sql: ${Sales_date_filter_not_null} ;;
    value_format_name: usd_0
    html:
      @{kpi_tile_start}@{kpi_tile_value_start}{{ rendered_value }}@{div_end}@{kpi_tile_label_start}GTV@{div_end}
        @{kpi_tile_metrics_start}
        {% if mock_wow_change._value >= 0 %}
        @{kpi_arrow_up} {{ mock_wow_change._rendered_value }} WoW
        {% else %}
        @{kpi_arrow_down} {{ mock_wow_change._rendered_value }} WoW
          {% endif %}
        <br>@{kpi_arrow_down} -0.7% YoY
        <br>@{kpi_arrow_up} 2.4% vs Target
        @{div_end}
        @{div_end} ;;
 }
# NATIVE TABLE FORMATTED FIELD: WoW Change with Arrow Icons
  measure: table_wow_formatted {
    type: number
    sql: ${mock_wow_change} ;;
    value_format_name: percent_1
    html:
    @{table_metric_start}
    {% if value >= 0 %}
    @{kpi_arrow_up} {{ rendered_value }}
    {% else %}
    @{kpi_arrow_down} {{ rendered_value }}
    {% endif %}
    @{div_end} ;;
  }
  # NATIVE TABLE FORMATTED FIELD: Dynamic Performance Trend Line
  measure: table_yoy_formatted {
    type: number
    sql: (${Sales_date_filter_not_null} - ${Sales_date_filter_comparison_not_null}) / NULLIF(${Sales_date_filter_comparison_not_null}, 0) ;;
    value_format_name: percent_1
    html:
    @{table_metric_start}
    {% if value >= 0 %}
    @{kpi_arrow_up} {{ rendered_value }}
    {% else %}
    @{kpi_arrow_down} {{ rendered_value }}
    {% endif %}
    @{div_end} ;;
  }
# TARGET VOLUMES LAYER (SCALED TO ORDER COUNTS)
  measure: target_orders {
    type: number
    sql:
          CASE
            WHEN ${Sales_date_filter_not_null} > 0 THEN ${Sales_date_filter_not_null} * 1.05
            ELSE ${count} * 1.15  -- Scales cleanly off your order counts when testing in Explore mode
          END ;;
    value_format_name: decimal_0
  }
# INDEPENDENT SCORECARD MATRIX
  measure: new_vertical_orders_scorecard {
    type: count_distinct
    sql: ${TABLE}.`ORDER ID` ;;
    html:
      @{scorecard_table_start}
        <tr>
          <th colspan="3" style="@{scorecard_header_style}">
            New Vertical Orders
          </th>
        </tr>

      <tr style="@{scorecard_row_height}">
      <td style="@{scorecard_period_style}">Day</td>
      <td style="@{scorecard_value_style}">{{ rendered_value }}</td>
      <td style="@{scorecard_detail_style}">
      <table style="@{scorecard_inner_table_style}">
      <tr style="@{scorecard_row_divider}">
      <td style="@{scorecard_split_half} @{scorecard_label_style}">WoW</td>
      <td style="@{scorecard_split_half} @{scorecard_metric_style}">{{ table_wow_formatted._rendered_value }}</td>
      </tr>
      <tr>
      <td style="@{scorecard_label_style}">YoY</td>
      <td style="@{scorecard_metric_style}">{{ table_yoy_formatted._rendered_value }}</td>
      </tr>
      </table>
      </td>
      </tr>

      <tr style="@{scorecard_row_height}">
      <td style="@{scorecard_period_style}">WTD</td>
      <td style="@{scorecard_value_style}">92.90K</td>
      <td style="@{scorecard_detail_style}">
      <table style="@{scorecard_inner_table_style}">
      <tr style="@{scorecard_row_divider}">
      <td style="@{scorecard_split_skew} @{scorecard_label_style}">vs. Prior Week</td>
      <td style="width: 35%; @{scorecard_metric_style}">-2.6%</td>
      </tr>
      <tr>
      <td style="@{scorecard_label_style}">vs. Prior Year</td>
      <td style="@{scorecard_metric_style}">0.5%</td>
      </tr>
      </table>
      </td>
      </tr>

      <tr style="@{scorecard_row_height}">
      <td style="@{scorecard_period_style}">MTD</td>
      <td style="@{scorecard_value_style}">161.94K</td>
      <td style="@{scorecard_detail_style}">
      <table style="@{scorecard_inner_table_style}">
      <tr style="@{scorecard_row_divider}">
      <td style="@{scorecard_split_skew} @{scorecard_label_style}">vs. Prior Month</td>
      <td style="width: 35%; @{scorecard_metric_style}">-7.4%</td>
      </tr>
      <tr>
      <td style="@{scorecard_label_style}">vs. Prior Year</td>
      <td style="@{scorecard_metric_style}">1.0%</td>
      </tr>
      </table>
      </td>
      </tr>

      <tr style="@{scorecard_row_height}">
      <td style="@{scorecard_period_style}">QTD</td>
      <td style="@{scorecard_value_style}">0.16M</td>
      <td style="@{scorecard_detail_style}">
      <table style="@{scorecard_inner_table_style}">
      <tr style="@{scorecard_row_divider}">
      <td style="@{scorecard_split_skew} @{scorecard_label_style}">vs. Prior Quarter</td>
      <td style="width: 35%; @{scorecard_metric_style}">N/A</td>
      </tr>
      <tr>
      <td style="@{scorecard_label_style}">vs. Prior Year</td>
      <td style="@{scorecard_metric_style}">1.0%</td>
      </tr>
      </table>
      </td>
      </tr>

      <tr style="@{scorecard_row_height}">
      <td style="@{scorecard_period_style}">YTD</td>
      <td style="@{scorecard_value_style}">1.53M</td>
      <td style="@{scorecard_detail_style}">
      <table style="@{scorecard_inner_table_style}">
      <tr>
      <td style="@{scorecard_split_skew} @{scorecard_label_style}">vs. Prior Year</td>
      <td style="width: 35%; @{scorecard_metric_style}">8.1%</td>
      </tr>
      </table>
      </td>
      </tr>

      </table> ;;
  }
# MASTER SCORECARD COMPONENT: Marketplace Orders per Diner Matrix
  measure: marketplace_orders_per_diner_scorecard {
    type: count_distinct
    sql: ${TABLE}.`ORDER ID` ;;
    html:
      @{marketplace_table_start}
        <tr>
          <th colspan="4" style="@{scorecard_header_style}">
            Marketplace Orders per Diner
          </th>
        </tr>
      <!-- ================= GH+ SECTION ================= -->
      <tr style="@{marketplace_row_height}">
      <td rowspan="2" style="@{marketplace_ghplus_style}">
      <div style="@{marketplace_rotated_label}">GH+</div>
      </td>
      <td style="width: 22%; @{marketplace_orange_label_style}">
      Rolling
      </td>
      <td style="@{scorecard_value_style}; width: 30%; vertical-align: middle;">
      4.22
      </td>
      <td style="@{scorecard_detail_style}; width: 38%;">
      <table style="@{scorecard_inner_table_style}">
      <tr style="@{scorecard_row_divider}">
      <td style="@{scorecard_label_style}">MoM</td>
      <td style="@{scorecard_metric_style}">-3.8%</td>
      </tr>
      <tr>
      <td style="@{scorecard_label_style}">YoY</td>
      <td style="@{scorecard_metric_style}">-1.2%</td>
      </tr>
      </table>
      </td>
      </tr>
      <tr style="@{marketplace_row_height}">
      <td style="@{marketplace_orange_label_style}">Rolling</td>
      <td style="@{scorecard_value_style}; width: 30%; vertical-align: middle;">16.43</td>
      <td style="@{scorecard_detail_style}; width: 38%;">
      <table style="@{scorecard_inner_table_style}">
      <tr style="@{scorecard_row_divider}">
      <td style="@{scorecard_label_style}">MoM</td>
      <td style="@{scorecard_metric_style}">1.1%</td>
      </tr>
      <tr>
      <td style="@{scorecard_label_style}">YoY</td>
      <td style="@{scorecard_metric_style}">-4.7%</td>
      </tr>
      </table>
      </td>
      </tr>
      <!-- ================= NON-GH+ SECTION ================= -->
      <tr style="@{marketplace_row_height}">
      <td rowspan="2" style="@{marketplace_non_ghplus_style}">
      <div style="@{marketplace_rotated_label}">Non-GH+</div>
      </td>
      <td style="@{marketplace_yellow_label_style}">
      Rolling
      </td>
      <td style="@{scorecard_value_style}; width: 30%; vertical-align: middle;">
      2.63
      </td>
      <td style="@{scorecard_detail_style}; width: 38%;">
      <table style="@{scorecard_inner_table_style}">
      <tr style="@{scorecard_row_divider}">
      <td style="@{scorecard_label_style}">MoM</td>
      <td style="@{scorecard_metric_style}">-1.9%</td>
      </tr>
      <tr>
      <td style="@{scorecard_label_style}">YoY</td>
      <td style="@{scorecard_metric_style}">1.1%</td>
      </tr>
      </table>
      </td>
      </tr>
      <tr style="@{marketplace_row_height}">
      <td style="@{marketplace_yellow_label_style}">Rolling</td>
      <td style="@{scorecard_value_style}; width: 30%; vertical-align: middle;">5.54</td>
      <td style="@{scorecard_detail_style}; width: 38%;">
      <table style="@{scorecard_inner_table_style}">
      <tr style="@{scorecard_row_divider}">
      <td style="@{scorecard_label_style}">MoM</td>
      <td style="@{scorecard_metric_style}">-0.4%</td>
      </tr>
      <tr>
      <td style="@{scorecard_label_style}">YoY</td>
      <td style="@{scorecard_metric_style}">0.1%</td>
      </tr>
      </table>
      </td>
      </tr>
      <!-- ================= TOTAL SECTION ================= -->
      <tr style="@{marketplace_row_height}">
      <td rowspan="2" style="@{marketplace_total_style}">
      <div style="@{marketplace_rotated_label}">Total</div>
      </td>
      <td style="@{marketplace_green_label_style}">
      Rolling
      </td>
      <td style="@{scorecard_value_style}; width: 30%; vertical-align: middle;">
      3.58
      </td>
      <td style="@{scorecard_detail_style}; width: 38%;">
      <table style="@{scorecard_inner_table_style}">
      <tr style="@{scorecard_row_divider}">
      <td style="@{scorecard_label_style}">YoY</td>
      <td style="@{scorecard_metric_style}">3.7%</td>
      </tr>
      <tr>
      <td style="@{scorecard_label_style}">MoM</td>
      <td style="@{scorecard_metric_style}">-3.7%</td>
      </tr>
      </table>
      </td>
      </tr>
      <tr style="@{marketplace_row_height}">
      <td style="@{marketplace_green_label_style}">Rolling</td>
      <td style="@{scorecard_value_style}; width: 30%; vertical-align: middle;">10.54</td>
      <td style="@{scorecard_detail_style}; width: 38%;">
      <table style="@{scorecard_inner_table_style}">
      <tr style="@{scorecard_row_divider}">
      <td style="@{scorecard_label_style}">MoM</td>
      <td style="@{scorecard_metric_style}">0.9%</td>
      </tr>
      <tr>
      <td style="@{scorecard_label_style}">YoY</td>
      <td style="@{scorecard_metric_style}">5.3%</td>
      </tr>
      </table>
      </td>
      </tr>
      </table> ;;
  }
}
