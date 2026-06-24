project_name: "testmlmodel"

# MASTER SHORTCUT FOR RED/GREEN KPI ARROWS (WITH DYNAMIC VALUE SLOTS)
constant: kpi_arrow_up {
  value: "
  <span style='font-family: Arial, sans-serif; font-weight: 500; color: #2aa134; margin-right: 4px;'>▲</span>"
}

constant: kpi_arrow_down {
  value: "
  <span style='font-family: Arial, sans-serif; font-weight: 500; color: #e51c23; margin-right: 4px;'>▼</span>"
}

constant: kpi_tile_start {

  value: "<div style='text-align: center; font-family: Arial, sans-serif;'>"
}

constant: kpi_tile_value_start {
  value: "<div style='font-size: 46px; font-weight: bold; color: #000; margin-bottom: 2px;'>"
}

constant: kpi_tile_label_start {
  value: "<div style='font-size: 16px; color: #666; margin-bottom: 8px;'>"
}

constant: kpi_tile_metrics_start {
  value: "<div style='font-size: 14px; font-weight: 500; line-height: 1.5; color: #666;'>"
}

constant: div_end {
  value: "</div>"
}

# for the tabular arrow table
constant: table_metric_start {
  value: "<div style='font-family: Arial, sans-serif; font-weight: 500;'>"
}

# SCORECARD STYLES
constant: scorecard_table_start {
  value: "<table style='width: 100%; max-width: 500px; border-collapse: separate; border-spacing: 5px; font-family: Arial, sans-serif; background-color: #ffffff;'>"
}

constant: scorecard_header_style {
  value: "background-color: #FF5722; color: #ffffff; font-size: 22px; padding: 12px; text-align: center; font-weight: bold; border-radius: 4px;"
}

constant: scorecard_period_style {
  value: "width: 25%; background-color: #FF5722; color: #ffffff; text-align: center; font-weight: bold; font-size: 22px; border-radius: 4px;"
}

constant: scorecard_value_style {
  value: "width: 35%; background-color: #F4E7D7; color: #222222; text-align: center; font-weight: bold; font-size: 24px; border-radius: 4px;"
}

constant: scorecard_detail_style {
  value: "width: 40%; background-color: #F9F9F9; padding: 6px 12px; border-radius: 4px; vertical-align: middle;"
}

constant: scorecard_inner_table_style {
  value: "width: 100%; border-collapse: collapse; font-size: 13px; color: #444444;"
}

constant: scorecard_label_style {
  value: "text-align: left; color: #666666; padding: 4px 0;"
}

constant: scorecard_metric_style {
  value: "text-align: right; font-weight: bold; padding: 4px 0;"
}

constant: scorecard_row_divider {
  value: "border-bottom: 1px solid #e0e0e0;"
}
constant: scorecard_row_height {
  value: "height: 70px;"
}
constant: scorecard_split_half {
  value: "width: 50%;"
}
constant: scorecard_split_skew {
  value: "width: 65%;"
}

# MARKETPLACE ORDERS PER DINER SCORECARD


constant: marketplace_table_start {
  value: "<table style='width: 100%; max-width: 550px; border-collapse: separate; border-spacing: 5px; font-family: Arial, sans-serif; background-color: #ffffff;'>"
}

constant: marketplace_ghplus_style {
  value: "width: 10%; background-color: #FF5722; color: #ffffff; text-align: center; font-weight: bold; font-size: 20px; border-radius: 4px; padding: 0;"
}

constant: marketplace_non_ghplus_style {
  value: "background-color: #FBC02D; color: #222222; text-align: center; font-weight: bold; font-size: 18px; border-radius: 4px; padding: 0;"
}

constant: marketplace_total_style {
  value: "background-color: #134633; color: #ffffff; text-align: center; font-weight: bold; font-size: 20px; border-radius: 4px; padding: 0;"
}

constant: marketplace_orange_label_style {
  value: "background-color: #FF5722; color: #ffffff; text-align: center; font-weight: bold; font-size: 18px; border-radius: 4px; vertical-align: middle;"
}

constant: marketplace_yellow_label_style {
  value: "background-color: #FBC02D; color: #222222; text-align: center; font-weight: bold; font-size: 18px; border-radius: 4px; vertical-align: middle;"
}

constant: marketplace_green_label_style {
  value: "background-color: #134633; color: #ffffff; text-align: center; font-weight: bold; font-size: 18px; border-radius: 4px; vertical-align: middle;"
}

constant: marketplace_rotated_label {
  value: "transform: rotate(-90deg); white-space: nowrap; display: block; margin: 0 auto; width: 30px;"
}

constant: marketplace_row_height {
  value: "height: 65px;"
}

constant: kpi_header_ribbon {
  value: "<tr style='border-bottom: 1px solid #d1d5db;'>
  <td style='width: 25%; font-size: 30px; color: #000000; padding-bottom: 10px; text-align: left; font-weight: 600;'>Received Volume</td>
  <td style='width: 25%; font-size: 30px; color: #000000; padding-bottom: 10px; text-align: left; font-weight: 600;'>Handled Volume</td>
  <td style='width: 25%; font-size: 30px; color: #000000; padding-bottom: 10px; text-align: left; font-weight: 600;'>Total Orders</td>
  <td style='width: 25%; font-size: 30px; color: #000000; padding-bottom: 10px; text-align: left; font-weight: 600;'>All Care CPO</td>
  </tr>"
}

constant: kpi_ribbon_wrapper_start {
  value: "<div style='width: 100%; background-color: #ffffff; padding: 10px 0px;'>
  <table style='width: 100%; border-collapse: collapse; font-family: Arial, sans-serif;'>"
}
constant: kpi_value_cell_style {
  value: "font-size: 44px; color: #333333; padding-top: 14px; text-align: left; font-weight: 400; letter-spacing: -1px; background-color: #ffffff;"
}
