#tab_4.R
tab_4 <- f7Tab(
  tabName = "Country",
  icon = f7Icon("map_fill"),
  active = FALSE,
  f7Shadow(
    intensity = 10,
    hover = TRUE,
    f7Card(title = "By Country",
           f7Row(
             f7Col(
               f7SmartSelect(
                 inputId = "country",
                 label = "Choose a country:",
                 selected = "drat",
                 choices = unique(uk_clean_data$Country),
                 openIn = "popup"
               )),
             f7Col(
                daterangepicker(
                 inputId = "date",
                 icon = icon("calendar"),
                 label = "Choose start and end dates ",
                 start = as.Date(min(uk_clean_data$InvoiceDate)),
                 end = as.Date(max(uk_clean_data$InvoiceDate))
                )
             )),
           plotly::plotlyOutput("country_sales"),
           f7Row(f7Select(
             inputId = "choice",
             label = "",
             c("Sales" = "Sales",
               "Total Quantity" = "Total Quantity",
               "Total Transactions" = "Total Transactions"),
             selected = "Total Transactions")),
           apexchartOutput("top_products")
    )
          
  )
)
