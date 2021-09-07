#tab_2.R
tab_2 <- f7Tab(
  tabName = "Region",
  icon = f7Icon("map_pin_ellipse"),
  active = FALSE,
  f7Shadow(
    intensity = 10,
    hover = TRUE,
    f7Card(title = "Card header",
           f7Row(f7Col(
             f7Select(
               inputId = "metric",
               label = "",
               c(
                 "Sales" = "Sales",
                 "Items" = "Items",
                 "Transactions" = "Transactions"
               ),
               selected = "Sales"
             )
           )),
           apexchartOutput("region_plot"))
  )
)