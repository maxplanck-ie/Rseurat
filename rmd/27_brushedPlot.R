# seurat_data: should be a seurat object you need to QC/ pick cells to be dropped.

brushData <- data.frame(nCount_RNA = seurat_data$nCount_RNA,
                        nFeature_RNA = seurat_data$nFeature_RNA)

ui <- shiny::basicPage(
  shiny::plotOutput("plot1", brush = "plot_brush"),
  shiny::verbatimTextOutput("info")
)

server <- function(input, output) {
  
  output$plot1 <- shiny::renderPlot({
    plot(brushData$nCount_RNA,
         brushData$nFeature_RNA)
  })
  
  output$info <- shiny::renderPrint({
    shiny::brushedPoints(brushData,
                         input$plot_brush,
                         xvar = "nCount_RNA",
                         yvar = "nFeature_RNA")
  })
}

shiny::shinyApp(ui, server)