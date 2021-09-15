tab_1<-f7Tab(
  tabName = "Overview",
  icon = f7Icon("chart_pie"),
  active = TRUE,
  f7Shadow(
    intensity = 10,
    hover = TRUE,
    f7Card(
      title = NULL,
      f7Row(f7Col(f7Tooltip(f7Select(
        inputId = "grouping",
        label = "Top Sales Overview",
        c("Description" = "Description",
          "Country" = "Country",
          "StockCode" = "StockCode"),
        selected = "Description"
      ),text = "Toggle the select to change the grouping on the table below")),
      ),
      DT::dataTableOutput("overview_tbl")
    )
  )
)