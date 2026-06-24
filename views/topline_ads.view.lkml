view: topline_ads {
  sql_table_name: orders ;;

  dimension: order_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.`ORDER ID` ;;
  }

  dimension: kpi_name {
    type: string
    label: "KPI Name"
    description: "The categorical name of the advertising metric"
    sql: ${TABLE}.`CATEGORY` ;;
  }

  dimension_group: order_date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    label: "Info"
    sql: ${TABLE}.`ORDER DATE` ;;
  }

  measure: actual_sales_amount {
    type: sum
    label: "Actual"
    value_format_name: percent_0
    sql: ${TABLE}.`SALES` ;;

    html:
      <div style="text-align: center; width: 100%;">
        <div style="font-size: 28px; font-weight: normal; color: #333333; margin-bottom: 4px; line-height: 1.1;">
          {{ rendered_value }}
        </div>

        <div style="font-size: 18px; font-weight: normal; line-height: 1.1;">
          {% if topline_ads.achievement_percentage._value >= 1.0 %}
            <span style="color: #2ecc71;">{{ topline_ads.achievement_percentage._rendered_value }}</span>
          {% elsif topline_ads.achievement_percentage._value >= 0.9 %}
            <span style="color: #f1c40f;">{{ topline_ads.achievement_percentage._rendered_value }}</span>
          {% else %}
            <span style="color: #e74c3c;">{{ topline_ads.achievement_percentage._rendered_value }}</span>
          {% endif %}
          <span style="font-size: 14px; font-weight: normal; color: #666666;"> of target</span>
        </div>
      </div> ;;
  }

  measure: target_sales_amount {
    type: average
    label: "Target"
    description: "Total target baseline metric"
    value_format_name: percent_0
    sql: ${TABLE}.`PROFIT`;;
    html:
    <div style="text-align: center; width: 100%;">
    <div style="font-size: 28px; font-weight: normal; color: #333333; margin-bottom: 2px; line-height: 1.1;">
    {{ rendered_value }}
    </div>
    <div style="font-size: 14px; color: #666666; line-height: 1.1;">
    {% assign month_part = topline_ads.order_date_month._value | split: "-" | last %}
    {% case month_part %}
    {% when "01" %}January{% when "02" %}February{% when "03" %}March{% when "04" %}April
    {% when "05" %}May{% when "06" %}June{% when "07" %}July{% when "08" %}August
    {% when "09" %}September{% when "10" %}October{% when "11" %}November{% when "12" %}December
    {% else %}{{ topline_ads.order_date_month._value }}
    {% endcase %} Target
    </div>
    </div> ;;
  }

  measure: achievement_percentage {
    type: number
    label: "Achievement %"
    value_format_name: percent_0
    sql: ${actual_sales_amount} / NULLIF(${target_sales_amount}, 0) ;;
  }

}
