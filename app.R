# Library declaration 
library(shiny)
library(dplyr)
library(shinyMobile)
library(readr)
library(apexcharter)
require(ggplot2)
library(DT)
library(timetk)

#Load the scripts needed for runtime
sapply(list.files("src", pattern = "*.R",full.names = T), source, globalenv())
#Define the modules (if applicable)
sapply(list.files("modules", pattern = "*.R",full.names = T), source, globalenv())
#Define the UI for the ui() function
sapply(list.files("ui", pattern = "*.R",full.names = T), source, globalenv())

#Shiny app runtime command 
shinyApp(
  ui = ui(),
  server = function(input, output, session) {
    
    #Turn the dataset into a reactive data frame
    base_data<-reactive(uk_clean_data)
    
    #Top N %  data
    top_n_data<-reactive({
      #Ensure that the data is accessible in the application as well as the 'n' input UI
      req(base_data(),input[['n']])
      ch_df<-isolate(base_data())%>% 
        #By customer and country
        group_by(CustomerID,Country)%>%
        #Summarise features
        summarise(Transactions = length(unique(InvoiceNo)),
                  Items = length(unique(StockCode)),
                  Sales = sum(items_value,na.rm=T),
                  `First Invoice Date` = min(InvoiceDate),
                  `Last Invoice Date` = max(InvoiceDate),
                  .groups = 'drop'
        )%>%
        #Order by the initially selected metric in the application
        arrange(desc(.data[[input[['metric']]]]))%>%
        #Top N fraction of the population as the datatable display
          top_frac(n = input[['n']]/100,wt = Sales)
      return(ch_df)
      })
    
    #Overview table presented on the first tab
    output[['overview_tbl']] <- DT::renderDataTable({
      #Requires the data and the grouping variable selected from tab 1
      req(is.character(input[['grouping']]),base_data())
      #Overview data frame
      ov_df<-isolate(base_data())%>% 
        #Aggregated at the 'grouping' input level
        group_by(.data[[input[['grouping']]]]) %>%
        summarise(Transactions = length(unique(InvoiceNo)),
                  Items = length(unique(StockCode)),
                  Sales = sum(items_value,na.rm=T),
                  `First Invoice Date` = min(InvoiceDate),
                  `Last Invoice Date` = max(InvoiceDate),
        )%>%arrange(desc(Sales))
      ov_df
    })
    
    #Bar plot of the different countries that invoices and items originate
    #Visualization that is used in tab 2
    output[['region_plot']] <- renderApexchart({
      req(is.character(input[['grouping']]),base_data())
      ch_df<-isolate(base_data())%>% 
        group_by(Country) %>%
        summarise(Transactions = length(unique(InvoiceNo)),
                  Items = length(unique(StockCode)),
                  Sales = sum(items_value,na.rm=T),
                  `First Invoice Date` = min(InvoiceDate),
                  `Last Invoice Date` = max(InvoiceDate),
        )%>%arrange(desc(Sales))
      apex(ch_df,mapping = aes(x = Country,y = Sales),type = "column")
    })
    
    # Customer table that is displayed on tab 3
    output[['customer_tbl']] <- DT::renderDataTable({
      req(is.character(input[['grouping']]),top_n_data())
      top_n_data()
    }, rownames = TRUE)
    
    #Code is entirely commented out as it is moduralized below,
    #Code has been kept to show the development made in feature 2
    #Sales trend plot
    #Creates plot that tracks weekly trend
    # output[['salesTrend']] = renderPlot({
    #     dfsalesTrend = uk_clean_data %>%
    #       filter(Country == input$selectedCountry1) %>%
    #       filter(InvoiceDate < as.POSIXct(input$endDate)) %>%
    #       filter(InvoiceDate > as.POSIXct(input$startDate)) %>%
    #       summarise_by_time(
    #         InvoiceDate, .by = "week", TotalNet = sum(total_product_net)
    #       )
    #       ggplot(dfsalesTrend, aes(as.Date(InvoiceDate), TotalNet)) + xlab("Date") + ylab("Net Sales") +
    #         geom_line() + scale_x_date(date_labels = "%b-%d-%Y")
    #   })
    
    #Moduralized table from feature 2
    #A modularized version of the above chart
    #timeFrame can be changed from week to year, biweekly, etc.
    #Other parameters can be changed from reactive to static if desired
    #Reuseable code going forward
    tableServer("salesTrend_tbl", df = uk_clean_data, timeFrame = "week",
                countrySel = reactive(input$selectedCountry1),
                dateStart = reactive(input$startDate),
                dateEnd = reactive(input$endDate))
    
    #Chart in tab 5, 'Performance'
    #helper function to get data that will be put on chart
    filterPerfData <- reactive({
      #Filter data based on country
      filter(uk_clean_data, Country == input$selectedPerformanceCountry) %>%
        # Create year column to group by and filter on
        mutate(year = format(InvoiceDate, "%Y")) %>%
        group_by(year) %>%
        #Create values that'll be placed into the chart
        summarise(
          totalSales = sum(total_product_sales),
          totalReturns = (sum(total_product_returns))*-1,
          totalNet = sum(total_product_net),
          avgItemSalePrice = mean(mean_price),
          itemsSold = sum(Quantity)
        )
    })
    
    #Creates chart in tab 6, 'Performance'
    #Allows for table exporting (to excel, clipboard, csv)
    output[['performance_tbl']] <- DT::renderDataTable({
      DT::datatable(
        data = filterPerfData(),
        #Set extensions for export buttons
        extensions = "Buttons",
        options = list(
          fixedColumns = TRUE,
          autoWidth = TRUE,
          ordering = FALSE,
          dom = 'tB',
          buttons = c("copy", "csv", "excel")
        ),
        class = "display"
      )
    }, rownames = TRUE)
    
    
    
  }
)
    
