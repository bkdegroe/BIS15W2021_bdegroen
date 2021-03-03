library("tidyverse")
library("shiny")

UC_admit <- read_csv(here("lab13/data/UC_admit.csv")) %>% clean_names()

UC_admit_no_all <- UC_admit %>% 
  filter(ethnicity !="All")
UC_admit_no_all

ui <- dashboardPage(
  dashboardHeader(title = "Admissions By Ethnicity For UC Campuses"),
  dashboardSidebar(),
  dashboardBody(
    selectInput("x", "Select X Variable", choices = c("academic_yr", "campus", "category", "ethnicity", "filtered_count_fr"), selected = "ethnicity"),
    selectInput("y", "Select Y Variable", choices = c("filtered_count_fr"), selected = "filtered_count_fr"),
    plotOutput("plot", width = "500px", height = "400px"))
)

server <- function(input, output, session) { 
  output$plot <- renderPlot({
    ggplot(UC_admit_no_all, aes_string(x = input$x, y = input$y, fill= "ethnicity")) + geom_col(position = "dodge") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))+ scale_fill_trek("romulan")
  })
  session$onSessionEnded(stopApp)
}

shinyApp(ui, server)

