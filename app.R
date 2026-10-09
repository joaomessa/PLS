library(shiny)
library(bslib)
library(plotly)
library(ggplot2)

# Adicione esta linha para revelar o erro real na tela do navegador
options(shiny.sanitize.errors = FALSE)

# Interface visual moderna com bslib
ui <- page_sidebar(
  title = "Painel Interativo R",
  theme = bs_theme(version = 5, bootswatch = "flatly"),
  sidebar = sidebar(
    title = "Controles",
    sliderInput("bins", "Número de classes (bins):", min = 1, max = 50, value = 30)
  ),
  card(
    card_header("Distribuição de Frequência"),
    plotlyOutput("graficoInterativo")
  )
)

# Servidor para processar o gráfico
server <- function(input, output, session) {
  output$graficoInterativo <- renderPlotly({
    # Dados de exemplo nativos do R
    x <- faithful$eruptions
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # Criando o gráfico com ggplot2
    p <- ggplot(data.frame(x), aes(x)) +
      geom_histogram(breaks = bins, fill = "#2c3e50", color = "white") +
      theme_minimal() +
      labs(x = "Duração da Erupção (minutos)", y = "Frequência")
    
    # Convertendo para interativo com plotly
    ggplotly(p)
  })
}

# Inicia o aplicativo
shinyApp(ui = ui, server = server)