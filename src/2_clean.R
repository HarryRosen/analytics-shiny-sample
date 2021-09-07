#Script for pre-processing the data taken directly from the CSV
#The features
uk_clean_data <- uk_data %>%
  #convert the date into a timestamp object
  mutate(InvoiceDate = strptime(InvoiceDate, "%m/%d/%Y %R")) %>%
  #group by the clients to get some general stats
  group_by(CustomerID) %>%
  #Order by date for life time value calculations
  arrange(InvoiceDate) %>%
  #Determine the number of visits the user has had
  mutate(
    visit = dense_rank(desc(InvoiceDate)),
    transactions = length(unique(InvoiceNo)),
    total_visits = max(visit),
    is_anon = ifelse(is.na(CustomerID),T,F),
    ltv = cumsum(UnitPrice * Quantity),
    last_visit = max(InvoiceDate),
    first_visit = min(InvoiceDate),
  ) %>%
  #Remove the grouping
  ungroup(.) %>%
  #group by the transaction and product for statistics about the item-related spend
  group_by(InvoiceNo, StockCode) %>%
  #Determine total spend and whether it was a purchase or a transaction
  mutate(
    purchase = Quantity > 0,
    return = Quantity < 0,
    items_value = UnitPrice * Quantity
  ) %>%
  ungroup(.) %>%
  #Break out by the different transactions for related statistics to each transaction
  group_by(InvoiceNo) %>%
  #Transaction related statistics worth noting
  mutate(transaction_value = sum(items_value)) %>%
  ungroup(.) %>%
  #group by the stock code of items to determine performance of a specific stock good
  group_by(StockCode) %>%
  mutate(
    min_price = min(UnitPrice),
    mean_price = mean(UnitPrice),
    max_price = max(UnitPrice),
    total_product_net_sales = sum(UnitPrice * Quantity),
    total_product_sales = sum(UnitPrice[Quantity > 0] * Quantity[Quantity > 0]),
    total_product_returns = sum(UnitPrice[Quantity < 0] * Quantity[Quantity < 0]),
    total_product_net = sum(Quantity),
  )%>%
  ungroup(.)

return(class(uk_clean_data$InvoiceDate) %in% "POSIXlt") 
