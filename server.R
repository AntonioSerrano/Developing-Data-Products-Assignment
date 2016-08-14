## 3. SERVER FOR THE SHINY APP

# Define server logic for random distribution application
server <- shinyServer(function(input, output, session) {
        
        # Reactive expression to generate the requested distribution.
        # This is called whenever the inputs change. The output
        # functions defined below then all use the value computed from
        # this expression
        data <- reactive({
                
                dist <- switch(input$dist,
                               binom = rbinom,
                               pois = rpois,
                               geom = rgeom,
                               unif = runif,
                               norm = rnorm,
                               lnorm = rlnorm,
                               exp = rexp,
                               gamma = rgamma,
                               chisq = rchisq,
                               f = rf
                )
                
                # The "dist" function will depend on different parameters
                # according to the selected distribution
                dist <- if (input$dist == "binom"){
                        dist(input$n, input$binomSize, input$binomProb)        
                }
                else if (input$dist == "pois"){
                        dist(input$n, input$poisLambda)        
                }
                else if (input$dist == "geom"){
                        dist(input$n, input$geomProb)        
                }
                else if (input$dist == "unif"){
                        dist(input$n, input$unifMin, input$unifMax)        
                }
                else if(input$dist == "norm"){
                        dist(input$n, input$normMean, input$normSd)
                }
                else if (input$dist == "lnorm"){
                        dist(input$n, input$lnormMeanlog, input$lnormSdlog)        
                }
                else if (input$dist == "exp"){
                        dist(input$n, input$expRate)        
                }
                else if (input$dist == "gamma"){
                        dist(input$n, input$gammaShape, input$gammaRate)        
                }
                else if (input$dist == "chisq"){
                        dist(input$n, input$chisqDf, input$chisqNcp)        
                }
                else if (input$dist == "f"){
                        dist(input$n, input$fDf1, input$fDf2, input$fNcp)        
                }
        })
        
        # Generate a plot of the data. Also uses the inputs to build
        # the plot label. Note that the dependencies on both the inputs
        # and the data reactive expression are both tracked, and
        # all expressions are called in the sequence implied by the
        # dependency graph
        output$plot <- renderPlot({
                dist <- input$dist
                n <- input$n
                binomProb <- input$binomProb
                poisLambda <- input$poisLambda
                geomProb <- input$geomProb
                unifMin <- input$unifMin
                unifMax <- input$unifMax
                normMean <- input$normMean
                normSd <- input$normSd
                lnormMeanlog <- input$lnormMeanlog
                lnormSdlog <- input$lnormSdlog
                expRate <- input$expRate
                binomSize <- input$binomSize
                gammaShape <- input$gammaShape
                gammaRate <- input$gammaRate
                chisqDf <- input$chisqDf
                chisqNcp <- input$chisqNcp
                fDf1 <- input$fDf1
                fDf2 <- input$fDf2
                fNcp <- input$fNcp
                
                hist(data(),
                     main=paste('r', dist, '(', n, ')', sep=''), # Use the inputs to build the plot label
                     breaks = 30)
        })
        
        # Generate a summary of the data
        output$summary <- renderPrint({
                summary(data())
        })
        
        # Generate an HTML table view of the data
        output$data <- renderTable({
                data.frame(x=data())
        })
        
        # Download the selected graphic
        output$dlGraphic <- downloadHandler(
                filename = 'dlGraphic.pdf',
                content = function(file){
                        pdf(file = file, width=11, height=6)
                        par(mar=c(6,6,10,2))
                        hist(data(),
                             breaks = 30)
                        dev.off()
                }
        )
        
        # Download the generated data
        output$dldata <- downloadHandler(
                filename = function() { paste(input$dist, '.csv', sep='') },
                content = function(file) {
                        write.csv(data.frame(x=data()), file)
                }
        )
})
