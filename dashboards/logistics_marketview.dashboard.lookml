- dashboard: logistics_marketview_v1
  title: "Market View - Order Level (Dev Mode)"
  layout: newspaper
  preferred_viewer: dashboards-next
  filters_location_top: false


  # =========================================================================
  # CLEAN VERTICAL FILTERS (ACTS AS BOTH HEADER & INPUT)
  # =========================================================================
  filters:
  - name: time_period_value
    title: "Time Display Period (Value)"
    type: field_filter
    default_value: "10"
    allow_multiple_values: false
    ui_config:
      type: text
    model: model
    explore: logistics_marketview
    field: logistics_marketview.time_display_value

  - name: time_period_unit
    title: "Time Display Period (Unit)"
    type: field_filter
    default_value: "day"
    allow_multiple_values: false
    ui_config:
      type: dropdown
    model: model
    explore: logistics_marketview
    field: logistics_marketview.time_display_granularity

  - name: select_weekday
    title: "Delivery Time: Weekday"
    type: field_filter
    allow_multiple_values: true
    ui_config:
      type: dropdown
    model: model
    explore: logistics_marketview
    field: logistics_marketview.delivery_weekday

  - name: select_mealtime
    title: "Delivery Time: Mealtime"
    type: field_filter
    allow_multiple_values: true
    ui_config:
      type: dropdown
    model: model
    explore: logistics_marketview
    field: logistics_marketview.delivery_mealtime

  - name: select_cbsa
    title: "GHD District: CBSA"
    type: field_filter
    model: model
    explore: logistics_marketview
    field: logistics_marketview.cbsa

  - name: select_logistics
    title: "GHD District: Logistic Seg"
    type: field_filter
    model: model
    explore: logistics_marketview
    field: logistics_marketview.logistics

  - name: select_key_city
    title: "GHD District: Key City"
    type: field_filter
    model: model
    explore: logistics_marketview
    field: logistics_marketview.key_city

  - name: select_district
    title: "GHD District: District"
    type: field_filter
    model: model
    explore: logistics_marketview
    field: logistics_marketview.district


  # =========================================================================
  # DASHBOARD TILES / VISUAL ELEMENTS
  # =========================================================================
  elements:

  - name: dashboard_header_markdown
    type: text
    body_text: |
      <div style="font-family: Arial, sans-serif; padding: 12px 0 0 10px; min-height: 70px;">
      <h1 style="margin: 0; font-size: 24px; color: #000000; font-weight: bold; line-height: 1.2;">
      Market View - Order Level
      </h1>
      <p style="margin: 4px 0 0 0; font-size: 13px; color: #333333; font-weight: normal;">
      Updated: 6/3/2026 10:08:54 PM. Data available for the past 7wks (inclusive current week).
      </p>
      </div>
    row: 0
    col: 0
    width: 24
    height: 3


  - name: sales_and_orders_table
    title: ""
    model: model
    explore: logistics_marketview
    type: table
    fields: [
      logistics_marketview.district,
      logistics_marketview.current_sales,
      logistics_marketview.previous_sales,
      logistics_marketview.current_orders,
      logistics_marketview.previous_orders
    ]
    listen:
      time_period_value: logistics_marketview.time_display_value
      time_period_unit:  logistics_marketview.time_display_granularity
      select_weekday:    logistics_marketview.delivery_weekday
      select_mealtime:   logistics_marketview.delivery_mealtime
      select_cbsa:       logistics_marketview.cbsa
      select_logistics:  logistics_marketview.logistics
      select_key_city:   logistics_marketview.key_city
      select_district:   logistics_marketview.district
    row: 3
    col: 0
    width: 24
    height: 12

    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
