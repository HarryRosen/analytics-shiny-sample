tab_5 <- f7Tab(
  tabName = "Performance",
  icon = f7Icon("battery_25"),
  active = FALSE,
  f7Shadow(
    intensity = 10,
    hover = TRUE,
    f7Card(
      title = NULL,
      f7Select(inputId = "selectedPerformanceCountry",label = "Country", 
               countryList, selected = "United Kingdom")
    )
  ),
  f7Shadow(
    intensity = 10,
    hover = TRUE,
    f7Card(
      title = NULL,
    )
  )
)