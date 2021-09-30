# Library declaration 
library(shiny)
library(dplyr)
library(shinyMobile)
library(readr)
library(apexcharter)
require(ggplot2)
library(DT)
library(timetk)
library(lubridate)
library(plotly)
library(daterangepicker)

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
    
    ### Set default values for start and end dates
    dates <- reactiveValues(start_date = min(as.Date(uk_clean_data$InvoiceDate)), end_date = max(as.Date(uk_clean_data$InvoiceDate)))
    ### Update default values
    observeEvent(input[['date']],{
      dates$start_date <- as.Date(input[['date']][1])
      dates$end_date <- as.Date(input[['date']][2])
    })
    
    ### New reactive data frame that will be used for both plots in tab 4
    filtered <- reactive({
      req(base_data(),input[['country']], dates$start_date, dates$end_date)
      fil_df<-isolate(base_data())%>% 
              mutate(invoice_date = as.Date(InvoiceDate))%>%
              filter(invoice_date %within% interval(dates$start_date, dates$end_date)
                    & Country == input[['country']])
      return(fil_df)
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
                  `Last Invoice Date` = max(InvoiceDate)
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
                  `Last Invoice Date` = max(InvoiceDate)
        )%>%arrange(desc(Sales))
      apex(ch_df,mapping = aes(x = Country, y = Sales),type = "column")
    })
    
    # Customer table that is displayed on tab 3
    output[['customer_tbl']] <- DT::renderDataTable({
      req(is.character(input[['grouping']]),top_n_data())
      top_n_data()
    }, rownames = TRUE)

    ### Country sale plot that is displayed on tab 4
    output[['country_sales']] <- plotly::renderPlotly({
      sale_df<-filtered()%>%
             group_by(invoice_date)%>%
             summarise(Sales = sum(UnitPrice[Quantity > 0] * Quantity[Quantity > 0], na.rm=T),
                       .groups = 'drop')%>%
             arrange(invoice_date)
      
      sale_df %>% 
        plot_time_series(.date_var = invoice_date, .value = Sales, .color_var = week(invoice_date), .smooth = FALSE,
                         .title = "Sales By Country Over Specified Time", .x_lab = "Invoice Date", .y_lab = "Sale",
                         .color_lab = "Week")
    })
    
    ### Top 10 products by country that is displayed on tab 4
    output[['top_products']] <- renderApexchart({ 
      tp_df<-filtered()%>%
             group_by(Description)%>%
             summarise(`Total Transactions` = sum(length(unique(InvoiceNo)), na.rm=T),
                       `Total Quantity` = sum(Quantity, na.rm=T),
                        Sales = sum(UnitPrice[Quantity > 0] * Quantity[Quantity > 0], na.rm=T),
                       .groups = 'drop')%>%
            arrange(desc(.data[[input[['choice']]]]))%>%
            top_n(10, .data[[input[['choice']]]])
      
      apex(tp_df, mapping = aes(x = Description, y = .data[[input[['choice']]]]), type = "column")%>%
        ax_labs(title = "Top 10 products By Country Over Specified Time", x="Products")%>%
        ax_xaxis(labels=list(style=list(fontSize="6px")))
    })
      
  }
)

    
    
