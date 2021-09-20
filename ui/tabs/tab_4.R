countryList = as.character(unique(uk_clean_data[[8]]))

tab_4<-f7Tab(
  tabName = "Trends",
  icon = f7Icon("chart_bar"),
  active = FALSE,
  f7Shadow(
    intensity = 10,
    hover = TRUE,
    f7Card(
      title = NULL,
      f7Select(inputId = "selectedCountry1",label = "Country", countryList, selected = "United Kingdom"),
      div(style = "display:inline-block;",f7DatePicker(inputId = "startDate",label = "Start Date")),
      div(style = "display:inline-block;",f7DatePicker(inputId = "endDate",label = "End Date"))
      
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