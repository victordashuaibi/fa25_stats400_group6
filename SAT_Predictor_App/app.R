library(shiny)
library(dplyr)
library(ggplot2)
library(car)
library(MASS)
library(psych)
library(corrplot)
library(GGally)

# Load dataset
file_path <- "~/Documents/STATS 402/STATS 402 Project One/revised_sat_dataset_minority.csv"
df <- read.csv(file_path, stringsAsFactors = TRUE)

# Organize vars
cat_vars <- c("Ethnicity", "Time_studying", "SAT_prep", "Program_accept_rate", "Program_grad_rate", "Mother_edu") 
num_vars <- c("Income", "PSAT_score")

# Combine predictors for dropdown
all_predictors <- c(num_vars, cat_vars)

######################################
# UI
ui <- fluidPage(
  titlePanel("SAT Score Predictor"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("predictor",
                  "Select a predictor to visualize:",
                  choices = all_predictors),
      hr(),
      h4("SAT Score Predictor Model Builder"),
      checkboxGroupInput("model_vars",
                         "Select predictors to include in the model:",
                         choices = all_predictors),
      actionButton("build_model", "Build Model")
    ),
    
    mainPanel(
      h4("Visualization"),
      plotOutput("satPlot"),
      hr(),
      h4("Model Output"),
      verbatimTextOutput("model_summary"),
      hr(),
      h4("Model Diagnostics"),
      plotOutput("diagnostic_plots")
    )
  )
)

######################################
# Server
server <- function(input, output) {
  
  # Visualization
  output$satPlot <- renderPlot({
    pred <- input$predictor
    
    if (pred %in% num_vars) {
      ggplot(df, aes_string(x = pred, y = "SAT_score")) +
        geom_point(color = "blue") +
        geom_smooth(method = "lm", color = "red") +
        labs(x = pred, y = "SAT Score",
             title = paste("SAT Score vs", pred)) +
        theme_minimal()
    } else if (pred %in% cat_vars) {
      ggplot(df, aes_string(x = pred, y = "SAT_score")) +
        geom_boxplot(fill = "steelblue") +
        labs(x = pred, y = "SAT Score",
             title = paste("SAT Score by", pred)) +
        theme_minimal()
    }
  })
  
  # Reactive model when button is clicked
  model_fit <- eventReactive(input$build_model, {
    req(input$model_vars)
    formula <- as.formula(
      paste("SAT_score ~", paste(input$model_vars, collapse = " + "))
    )
    lm(formula, data = df)
  })
  
  # Display model summary
  output$model_summary <- renderPrint({
    req(model_fit())
    summary(model_fit())
  })
  
  # Diagnostic plots
  output$diagnostic_plots <- renderPlot({
    req(model_fit())
    par(mfrow = c(2, 2))
    plot(model_fit())
  })
}

# Run the app
shinyApp(ui = ui, server = server)
