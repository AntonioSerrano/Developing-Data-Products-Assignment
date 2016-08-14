## NOTE: The following application is based on the example "tabsets" found in
# the offical Shiny examples repository
# (https://github.com/rstudio/shiny-examples).

## 1. GLOBAL

## Load required libraries

library("shiny") # To create Shiny apps
library("shinythemes") # To alter the overall appearance
# of the Shiny apps
library("markdown") # To write text in markdown format

## 2. USER INTERFACE FOR THE SHINY APP

# Define UI for random distribution application 

ui <- shinyUI(
        
        # Set fluidPage to create an adaptative app according to window size
        fluidPage(
                
                # Use "Readable" theme for general appearance
                theme = shinytheme("readable"),
                
                # Application title
                titlePanel("Famous random distributions visualizer"),
                
                # Sidebar with controls to select the random distribution type,
                # number of observations to generate, and parameters of each
                # distribution.
                sidebarLayout(
                        sidebarPanel(
                                
                                # Radio buttons widget. It allows to chose the different
                                # famous random distributions included in the app
                                radioButtons(inputId = "dist",
                                             label = h4("Distribution type:"), # The well known "h" HTML tag to set the header font size
                                             choices = c("Binomial" = "binom",
                                                         "Poisson" = "pois",
                                                         "Geometric" = "geom",
                                                         "Uniform" = "unif",
                                                         "Normal" = "norm",
                                                         "Log-normal" = "lnorm",
                                                         "Exponential" = "exp",
                                                         "Gamma" = "gamma",
                                                         "Chi-squared" = "chisq",
                                                         "F" = "f")),
                                
                                # The well known "br" HTML tag to introduce extra
                                # vertical spacing
                                br(),
                                
                                # Create a slider widget to select the number of
                                # observations from a range of 10,000
                                sliderInput(inputId = "n", 
                                            label = h4("Number of observations:"), 
                                            value = 1000,
                                            min = 1, 
                                            max = 10000),
                                br(),
                                
                                # Create one conditional panel per distribution to
                                # display its parameters. Each of these panels contains
                                # as many numeric inputs as parameters the distribution
                                # has
                                conditionalPanel(condition = "input.dist == 'binom'",
                                                 wellPanel(h4("Parameters"),
                                                           br(),
                                                           numericInput(inputId = "binomSize",
                                                                        label = "Number of trials (x = 0,1,...,n):",
                                                                        value = 100),
                                                           numericInput(inputId = "binomProb",
                                                                        label = "Probability of success (0≤p≤1):",
                                                                        value = 0.5))),
                                
                                conditionalPanel(condition = "input.dist == 'pois'",
                                                 wellPanel(h4("Parameters"),
                                                           br(),
                                                           numericInput(inputId = "poisLambda",
                                                                        label = "Lambda (0≤λ≤∞):",
                                                                        value = 10))),
                                
                                conditionalPanel(condition = "input.dist == 'geom'",
                                                 wellPanel(h4("Parameters"),
                                                           br(),
                                                           numericInput(inputId = "geomProb",
                                                                        label = "Probability (0≤p≤1):",
                                                                        value = 0.5))),
                                
                                conditionalPanel(condition = "input.dist == 'unif'",
                                                 wellPanel(h4("Parameters"),
                                                           br(),
                                                           numericInput(inputId = "unifMin",
                                                                        label = "Lower limit - a (-∞<a<x<b<∞):",
                                                                        value = 0),
                                                           numericInput(inputId = "unifMax",
                                                                        label = "Upper limit - b (-∞<a<x<b<∞):",
                                                                        value = 1))),
                                
                                conditionalPanel(condition = "input.dist == 'norm'",
                                                 wellPanel(h4("Parameters"),
                                                           br(),
                                                           numericInput(inputId = "normMean",
                                                                        label = "Mean (-∞<μ<∞):",
                                                                        value = 0),
                                                           numericInput(inputId = "normSd",
                                                                        label = "Standard deviation (0<σ^2<∞):",
                                                                        value = 1,
                                                                        min = 0))),
                                
                                conditionalPanel(condition = "input.dist == 'lnorm'",
                                                 wellPanel(h4("Parameters"),
                                                           br(),
                                                           numericInput(inputId = "lnormMeanlog",
                                                                        label = "Mean on the log scale (-∞<log(μ)<∞):",
                                                                        value = 0),
                                                           numericInput(inputId = "lnormSdlog",
                                                                        label = "Standard deviation on the log scale (0<σ^2<∞):",
                                                                        value = 1))),
                                
                                conditionalPanel(condition = "input.dist == 'exp'",
                                                 wellPanel(h4("Parameters"),
                                                           br(),
                                                           numericInput(inputId = "expRate",
                                                                        label = "Rate (λ>0):",
                                                                        value = 1))),
                                
                                conditionalPanel(condition = "input.dist == 'gamma'",
                                                 wellPanel(h4("Parameters"),
                                                           br(),
                                                           numericInput(inputId = "gammaShape",
                                                                        label = "Shape (0<α<∞):",
                                                                        value = 1),
                                                           numericInput(inputId = "gammaRate",
                                                                        label = "Rate (0<β<∞):",
                                                                        value = 1))),
                                
                                conditionalPanel(condition = "input.dist == 'chisq'",
                                                 wellPanel(h4("Parameters"),
                                                           br(),
                                                           numericInput(inputId = "chisqDf",
                                                                        label = "Degrees of freedom (d = 1, 2,...):",
                                                                        value = 2),
                                                           numericInput(inputId = "chisqNcp",
                                                                        label = "Non-centrality parameter (λ > 0):",
                                                                        value = 0))),
                                
                                conditionalPanel(condition = "input.dist == 'f'",
                                                 wellPanel(h4("Parameters"),
                                                           br(),
                                                           numericInput(inputId = "fDf1",
                                                                        label = "Degrees of freedom 1 (d1 = 1, 2,...):",
                                                                        value = 5),
                                                           numericInput(inputId = "fDf2",
                                                                        label = "Degrees of freedom 2 (d2 = 1, 2,...):",
                                                                        value = 12),
                                                           numericInput(inputId = "fNcp",
                                                                        label = "Non-centrality parameter (λ > 0):",
                                                                        value = 0))),
                                
                                # Include the "Download Graphic" and "Download Sample" 
                                # buttons to download the graphics and raw data from the
                                # random distributions generated
                                wellPanel(h4("Download options"),
                                          downloadButton(outputId = "dlGraphic",
                                                         label = "Download Graphic",
                                                         class="btn-block btn-primary"),
                                          downloadButton(outputId = "dldata",
                                                         label = "Download Sample",
                                                         class="btn-block btn-warning"))
                        ),
                        
                        # End of the slider panel. To sum up, we have 20 inputs. 2 of
                        # them are widgets on the slider panel (radioButtons and
                        # sliderInput) and 18 are numeric inputs included on the
                        # conditions panels for the distribution parameters.
                        
                        # Now set a tabset panel on the main panel. Specifically, show 4
                        # tabs called "Plot", "Summary", "Data", and "About". In these
                        # tabs we want to render a histogram, the summary statistics,
                        # a table view of the generated distribution, and a "about"
                        # markdown document with basic information regarding the app.
                        # To do so, we use the plotOutput,verbatimTextOutput,
                        # tableOutput, and includeMarkdown functions respectively.
                        mainPanel(
                                tabsetPanel(type = "tabs", 
                                            tabPanel(icon = icon("bar-chart"),
                                                     title = "Plot",
                                                     plotOutput("plot")), 
                                            tabPanel(icon = icon("dashboard"),
                                                     title = "Summary",
                                                     verbatimTextOutput("summary")), 
                                            tabPanel(icon = icon("table"),
                                                     title = "Data",
                                                     tableOutput("data")),
                                            tabPanel(icon = icon("newspaper-o"),
                                                     title = "About",
                                                     mainPanel(includeMarkdown("about.md")))
                                )
                        )
                )
        ))
