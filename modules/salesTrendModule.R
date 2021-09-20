
tableUI <- function(id){
  plotOutput(NS(id,"salesTrendTable"))
}

tableServer <- function(id,df,timeFrame, countrySel, dateStart, dateEnd){
  moduleServer(id,function(input,output,session){
    output$salesTrendTable <- renderPlot({
      df %>%
        dplyr::filter(Country == countrySel()) %>% #this is supposed to be input$selectedCountry
        dplyr::filter(InvoiceDate < as.POSIXct(dateEnd())) %>% #this is supposed to be input$endDate
        dplyr::filter(InvoiceDate > as.POSIXct(dateStart())) %>% #this is supposed to be input$startDate
        #all of the above inputs should be from tab_4.R
        summarise_by_time(
          InvoiceDate, .by = timeFrame, TotalNet = sum(total_product_net)
        ) %>%
        ggplot(aes(as.Date(InvoiceDate), TotalNet)) + xlab("Date") + ylab("Net Product Sales") + 
        geom_line() + scale_x_date(date_labels = "%b-%d-%Y")
    }
    )
  })
}