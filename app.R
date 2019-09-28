require(shiny)

dadosAssedio <- readRDS("dadosAssedioTPcodificado.rds")
# Define UI for application that draws a histogram
ui <- 
  
  fluidPage(    
    
    # Give the page a title
    titlePanel("Tira Essa Mão Boba Daí"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        selectInput("region", "Respostas dos entrevistados sobre:", 
                    choices=colnames(dadosAssedio[-2])),
        hr(),
        helpText("Resultados de uma pesquisa feita por discentes do curso de Gestão de Políticas Públicas
                 da UFRN, sobre o assédio nos transportes públicos."),
        helpText("Ao todo foram entrevistados 366 pessoas de diferentes gêneros, idades, raças que
                  responderam sobre perguntas relacionadas ao assédio nos transportes públicos.")
        
         ),
      
      # Create a spot for the barplot
      mainPanel(
        plotOutput("phonePlot")  
      )
      
    )
  )

server <- 
  
  function(input, output) {
    
    # Fill in the spot we created for a plot
    output$phonePlot <- renderPlot({
      
      # Render a barplot
      b <- barplot(table(dadosAssedio[input$region]), 
              
              ylab="Número de Respostas",
              ylim=c(0, 366),
              col = c(sample(1:9,size=dim(table(dadosAssedio[input$region])), replace=FALSE)))
      
      text(x=b,y=table(dadosAssedio[input$region]), labels=table(dadosAssedio[input$region]), pos=3, xpd=NA)
      
    })
  }


# Run the application 
shinyApp(ui = ui, server = server)
