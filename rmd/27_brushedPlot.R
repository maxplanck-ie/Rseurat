# seurat_data: should be a seurat object you need to QC/ pick cells to be dropped.

# Similar purposes can be achieved through Seurat's built-in functions:
# https://satijalab.org/seurat/articles/visualization_vignette.html#interactive-plotting-features
# but our approach is more general, helpful to many data wrangling scenarios.

# Run App.

# Convert row.names into a vector by:
#
# copy and pasting the rendered table
# at bottom into an output text file
# and processing it with GNU/Linux...
#
# $ cat output.txt | cut -d' ' -f1 | tr '\n' ',' | sed -e 's/,/", "/g'
#
# Ignore the 3 starting characters (quote, comma, and space),
# and the 3 ending characters (comma, space, and quote),
# select everything in the middle, paste inside a `c()`,
# assign to a variable, and... voilá!
# 
# Ready to apply filter:
# myData <- myData[,!colnames(myData) %in% cellsToDrop]

options(max.print=999)

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
