

covid_county_data <- 
  read.csv("https://opendata-geohive.hub.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.csv?outSR=%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D",
           stringsAsFactors = F) %>%
  mutate(TimeStamp = as.Date(TimeStamp)) 

range(covid_county_data$TimeStamp)
max_date <- max(covid_county_data$TimeStamp)

my_rolling_sum <- function(x, n_days = 14) zoo::rollsum(x - lag(x), k = n_days, align = "right", fill = NA)


my_county_plot <- 
  function(x, max_height = 1060){
    ggplot(x, aes(TimeStamp, PopulationProportionCovidCases)) +
      geom_line() +
      theme_light() +
      scale_y_continuous(limits = c(0, max_height)) +
      labs(x = "", y = "") +
      theme(text = element_text(size = 35))
  }



covid_county_data_tidy <- 
  covid_county_data %>%
  arrange(TimeStamp) %>%
  group_by(CountyName) %>%
  mutate(PopulationProportionCovidCases = my_rolling_sum(PopulationProportionCovidCases)) 


covid_county_data_tidy %>%
  summarise(average_100k = mean(PopulationProportionCovidCases, na.rm = T),
            median_100k = median(PopulationProportionCovidCases, na.rm = T),
            max_100k = max(PopulationProportionCovidCases, na.rm = T)) %>%
  full_join(
    covid_county_data_tidy %>%
      filter(TimeStamp >= "2020-08-01") %>%
      summarise(average_100k = mean(PopulationProportionCovidCases, na.rm = T),
                median_100k = median(PopulationProportionCovidCases, na.rm = T),
                max_100k = max(PopulationProportionCovidCases, na.rm = T)),
    by = c("CountyName"),
    suffix = c("_full", "_august")
  ) %>%
  full_join(
    covid_county_data_tidy %>%
      filter(TimeStamp >= max(TimeStamp)) %>%
      select(CountyName, current_14day = PopulationProportionCovidCases),
    by = c("CountyName")
  ) -> covid_county_stats


total_data_range <- 
  covid_county_stats %>%
  select(-CountyName) %>%
  range()
total_data_range[1] <- 0




county_data_plot <- 
  covid_county_data_tidy %>%
  filter(TimeStamp >= "2020-08-01") %>%
  group_by(CountyName) %>%
  tidyr::nest() %>%
  mutate(plot = purrr::map(data, my_county_plot),
         plot_col = NA)


covid_county_table <-
  covid_county_stats %>%
  left_join(
    county_data_plot %>%
      select(CountyName, plot, plot_col),
    by = "CountyName")  %>%
  arrange(desc(current_14day))



covid_county_table %>%
  gt(rowname_col = "CountyName") %>%
  tab_stubhead(label = "County") %>%
  tab_header(title = "Republic of Ireand Covid Statistics by County",
             subtitle = "14 Day Incidence Per 100,000") %>%
  tab_source_note(source_note = md("Source: [data.gov.ie](https://data.gov.ie/dataset/covid19countystatisticshpscireland1)")) %>%
  data_color(columns = vars(current_14day,
                            median_100k_full, average_100k_full, max_100k_full, 
                            median_100k_august, average_100k_august, max_100k_august),
             colors = scales::col_numeric(
               palette = c(
                 "red", "orange", "green"),
               domain = total_data_range, reverse = T),
             alpha = 0.5
  ) %>%
  
  data_color(columns = vars(median_100k_full, median_100k_august),
             colors = scales::col_numeric(
               palette = c("red", "orange", "green"),
               domain = c(0, 100), reverse = T)
  ) %>%
  data_color(columns = vars(average_100k_full, average_100k_august),
             colors = scales::col_numeric(
               palette = c("red", "orange", "green"),
               domain = c(0, 160),  reverse = T)
  ) %>%
  
  
  text_transform(
    locations = cells_body(vars(plot_col)),
    fn = function(x) {
      purrr::map(covid_county_table$plot, ggplot_image, height = px(150), 
                 aspect_ratio = 1.75)
      }
  ) %>%
  
  tab_spanner(
    label = html("All Time"),
    columns = vars(median_100k_full, average_100k_full, max_100k_full)
  ) %>%
  tab_spanner(
    label = html("Since August"),
    columns = vars(median_100k_august, average_100k_august, max_100k_august)
  )  %>%
  cols_move_to_start(
    columns = vars(plot_col, current_14day,
                   median_100k_august, average_100k_august, max_100k_august,
                   median_100k_full, average_100k_full)
  ) %>%
  cols_label(
    current_14day = "Current",
    median_100k_august = "Median",
    average_100k_august = "Average",
    max_100k_august = "Max",
    median_100k_full = "Median",
    average_100k_full = "Average",
    max_100k_full = "Max",
    plot_col = "14 Day Incidence"
  ) %>%
  cols_hide(vars(plot))












my_county_plot <- function(x){
  ggplot(x, aes(TimeStamp, incidence_14)) +
    geom_line() +
    theme_light() +
    scale_y_continuous(limits = c(0, NA)) +
    labs(x = "", y = "") +
    theme(text = element_text(size = 16))
}

covid_county_data_tidy %>%
  mutate(incidence_14 = zoo::rollsum(ConfirmedCovidCases, k = 14, align = "right", fill = NA)) %>% 
  filter(CountyName == "Kilkenny") %>%
  my_county_plot






covid_county_data_tidy %>%
  filter(TimeStamp > "2020-08-01") %>%
  mutate(incidence_14 = zoo::rollsum(ConfirmedCovidCases, k = 14, align = "right", fill = NA)) %>% 
  group_by(CountyName) %>%
  # summarise(All_Cases = sum(Total, na.rm = T)) %>%
  tidyr::nest() %>%
  mutate(plot = purrr::map(data, my_county_plot),
         plot_col = NA) -> county_data_plot



county_data_plot %>%
  select(CountyName, plot, plot_col) %>%
  left_join(covid_county_stats, by = "CountyName") %>%
  gt() %>%
  text_transform(
    locations = cells_body(vars(plot_col)),
    fn = function(x) {
      purrr::map(county_data_plot$plot, ggplot_image, height = px(200))
    }
  ) %>%
  cols_hide(vars(plot))


