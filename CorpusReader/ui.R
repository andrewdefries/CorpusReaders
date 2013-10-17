###################################################################################################
library(shiny)
library(hexbin)
###################################################################################################
widget_style <-
  "display: inline-block;
  vertical-align: text-top;
  padding: 7px;
  border: solid;
  border-width: 1px;
  border-radius: 4px;
  border-color: #CCC;"
shinyUI(bootstrapPage(
headerPanel("ReadDatFast::A Corpus Reader"),
############################################################################
  wellPanel(
    div(style = widget_style,
        sliderInput("obs", "Seed::WNA",min=1, max=4000, value=2000)),
    div(style = widget_style,
	sliderInput("include", "Include for WNA", min=1, max=100, value=96)),
    div(style = widget_style,
	sliderInput("obs2", "Corpus2WordCloud", min=1, max=100, value=1)),
    div(style = widget_style,
        sliderInput("page", "CorpusLength", min=1, max=4500, value=3)),
    div(style = widget_style,
	textInput("searchthis", "Constrain WNA:", 'aba')),
    div(style = widget_style,
	textInput("searchthisb", "Term 2:", 'hormone')),
    div(style = widget_style,
	textInput("searchthisc", "Term 3:", 'stress')),
    div(style = widget_style,
	textInput("searchthisd", "Term 4:", 'arabidopsis'))

###########################################################################
),
tabsetPanel(
  tabPanel("WNA", plotOutput("main_plot")),
  tabPanel("WordCloudPerCorpus",plotOutput("second_plot")),
  tabPanel("WordCloud with Length Filter",plotOutput("corpus_page")),
  tabPanel("Chemicalize&ChemmineR", plotOutput("MDS")),
  tabPanel("Corpus Chosen",verbatimTextOutput("termMat")) 
  )
###################################################################################################
))
###################################################################################################

