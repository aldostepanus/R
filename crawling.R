#Loading the rvest package
library('rvest')

#Specifying the url for desired website to be scraped
url <- 'https://www.yellowpages.com/search?search_terms=Chinese+Restaurants&geo_location_terms=California%2C+MD'
#Reading the HTML code from the website
webpage <- read_html(url)


business_name_data_html <- html_nodes(webpage,'.business-name')
business_name_data <- html_text(business_name_data_html)
head(business_name_data)

street_address_data_html <- html_nodes(webpage,'.street-address')
street_address_data <- html_text(street_address_data_html)
head(street_address_data)

locality_data_html <- html_nodes(webpage,'.locality')
locality_data <- html_text(locality_data_html)
head(locality_data)

categories_data_html <- html_nodes(webpage,'.categories a')
categories_data <- html_text(categories_data_html)
categories_data<-gsub(",.*","",categories_data)
categories_data<-as.factor(categories_data)
head(categories_data)

phone_data_html <- html_nodes(webpage,'.phone')
phone_data <- html_text(phone_data_html)
head(phone_data)

chinese_restaurant_df<-data.frame(Name = business_name_data, Street = street_address_data, City = locality_data,
                                  Categories = categories_data, Phone = phone_data)
#Structure of the data frame
str(chinese_restaurant_df)

# Include ‘jsonlite’ library to convert in JSON form.
library(jsonlite)
#convert
json_data <- toJSON(chinese_restaurant_df)
#print
cat(json_data)
#write to json file
write(json_data, file="D:/hasil_crawling.json")
