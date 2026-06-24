view: durga_test {
  # Your personal safe test playground!

  # ROW 1: DAY CARD
  measure: scorecard_day {
    type: number
    sql: 1 ;; # Changing type to number and using a dummy integer bypasses the aggregation error entirely!
    html:
      <div style="display: flex; align-items: center; justify-content: space-between; font-family: Arial, sans-serif; border: 2px solid #FF5722; border-bottom: none; width: 450px;">
        <div style="background: #FF5722; color: white; font-weight: bold; width: 90px; text-align: center; padding: 25px 15px; font-size: 22px;">Day</div>
        <div style="font-size: 26px; font-weight: bold; width: 140px; text-align: center; color: #222;">557.01K</div>
        <div style="font-size: 13px; text-align: left; color: #333; line-height: 1.5; width: 160px; padding: 10px 0;">
          <span style="color: #2aa134; font-weight: bold;">▲ 12.3% <span style="color: #666; font-weight: normal;">WoW</span></span><br>
          <span style="color: #2aa134; font-weight: bold;">▲ 4.5% <span style="color: #666; font-weight: normal;">YoY</span></span><br>
          <span style="color: #e51c23; font-weight: bold;">▼ -1.2% <span style="color: #666; font-weight: normal;">vs Target</span></span>
        </div>
      </div> ;;
  }

  # ROW 2: WTD CARD
  measure: scorecard_wtd {
    type: number
    sql: 1 ;;
    html:
      <div style="display: flex; align-items: center; justify-content: space-between; font-family: Arial, sans-serif; border: 2px solid #FF5722; width: 450px;">
        <div style="background: #FF5722; color: white; font-weight: bold; width: 90px; text-align: center; padding: 25px 15px; font-size: 22px;">WTD</div>
        <div style="font-size: 26px; font-weight: bold; width: 140px; text-align: center; color: #222;">5.12M</div>
        <div style="font-size: 13px; text-align: left; color: #333; line-height: 1.5; width: 160px; padding: 10px 0;">
          <span style="color: #2aa134; font-weight: bold;">▲ 8.1% <span style="color: #666; font-weight: normal;">vs Prior Week</span></span><br>
          <span style="color: #e51c23; font-weight: bold;">▼ -2.3% <span style="color: #666; font-weight: normal;">vs Prior Year</span></span><br>
          <span style="color: #2aa134; font-weight: bold;">▲ 0.4% <span style="color: #666; font-weight: normal;">vs Target</span></span>
        </div>
      </div> ;;
  }
}
