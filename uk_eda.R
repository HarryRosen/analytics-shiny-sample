#Determine the proportion of business by country
#~91% of business comes from the UK
summary(uk_clean_data)

#Missing data - Description
#~ 0.2% of rows out of complete dataset
nrow(uk_clean_data%>%filter(is.na(Description)))/nrow(uk_clean_data)

#Missing data - customer ID
#~25% of rows out of complete dataset
nrow(uk_clean_data%>%filter(is.na(CustomerID)))/nrow(uk_clean_data)

#Missing data
#~What does the missing data by country look like?
uk_clean_data %>% 
  filter(is.na(CustomerID)) %>% 
  group_by(Country) %>% 
  summarise(n = length(unique(InvoiceNo)),
            products = sum(Quantity),
            min_price = min(UnitPrice),
            max_price = max(UnitPrice),
            median_price = median(UnitPrice),
            mean_price = mean(UnitPrice),
            ) %>%
  arrange(desc(n))


# Complete data
# Displaying a pie chart of the sales by
# country to visualize the proportion of business by
# location
#~84% of business' sales come from the USA
uk_clean_data %>% 
  group_by(Country) %>% 
  summarise(invoices = length(unique(InvoiceNo)),
            products = length(unique(StockCode)),
            sales = sum(items_value,na.rm=T),
            zeros = sum(ifelse(UnitPrice==0,1,0)),
            min_date = min(InvoiceDate),
            max_date = max(InvoiceDate),
            min_price = min(UnitPrice),
            max_price = max(UnitPrice),
            median_price = median(UnitPrice),
            mean_price = mean(UnitPrice),
  ) %>%
  arrange(desc(invoices))%>%
  apex(data = ., type = "pie", mapping = aes_(x = .[['Country']], y = .[['sales']]))
