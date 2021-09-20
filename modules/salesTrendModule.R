
tableUI <- function(id){
  #Output of UI
  plotOutput(NS(id,"salesTrendTable"))
}

#Requires df, timeFrame, countrySel, dateStart, dateEnd when function is called
tableServer <- function(id,df,timeFrame, countrySel, dateStart, dateEnd){
  moduleServer(id,function(input,output,session){
    output$salesTrendTable <- renderPlot({
      df %>%
        dplyr::filter(Country == countrySel()) %>%
        dplyr::filter(InvoiceDate < as.POSIXct(dateEnd())) %>%
        dplyr::filter(InvoiceDate > as.POSIXct(dateStart())) %>%
        #Sum net product sales column
        summarise_by_time(
          InvoiceDate, .by = timeFrame, TotalNet = sum(total_product_net)
        ) %>%
        ggplot(aes(as.Date(InvoiceDate), TotalNet)) + xlab("Date") + ylab("Net Product Sales") + 
        geom_line() + scale_x_date(date_labels = "%b-%d-%Y")
    }
    )
  })
}