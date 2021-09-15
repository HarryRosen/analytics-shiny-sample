tab_3 <- f7Tab(
  tabName = "Customers",
  icon = f7Icon("person_3_fill"),
  active = FALSE,
  f7Shadow(
    intensity = 10,
    hover = TRUE,
    f7Card(
      title = "Card header",
      f7Slider(
        "n",
        "Top n %:",
        min = 1,
        max = 100,
        step = 1,
        value = 20
      ),
      DT::dataTableOutput("customer_tbl")
    )
  )
)