##################################################################################################
library(shiny)
library(tm)
library(igraph)
library(wordcloud)
################################################################
#source <- DirSource("/home/adefries/ShinyApps/NLPTK/txt")
#MyCorpus <- Corpus(source, readerControl=list(reader=readPlain)) 
#MyCorpus<-tm_map(MyCorpus, tolower)
#dtm <- DocumentTermMatrix(MyCorpus) 
################################################################
load("CorpusReady.rda")
load("dtm.rda")
################################################################
shinyServer(function(input,output){
  output$main_plot <- renderPlot({
#####################
MyCorpus<-MyCorpus[1:input$include]
#####################
FrequentTerms <- findFreqTerms(dtm, input$obs)
#AssociatedWords_ABA <- findAssocs(dtm, "aba", 0.8) #query
######################
#d <- Dictionary(c("aba", "abi1", "plants", "signalling", "abscisic", "stress", "pyrabactin", "hormone", "arabidopsis"))
#d <- Dictionary(c("aba"))
d <- Dictionary(c(input$searchthis, input$searchthisb, input$searchthisc, input$searchthisd))
######################
refined<-inspect(DocumentTermMatrix(MyCorpus, list(dictionary = d)))
termDocMatrix<-refined
termDocMatrix[termDocMatrix>=1] <- 1
termMatrix <- termDocMatrix %*% t(termDocMatrix)
######################
g <- graph.adjacency(termMatrix, weighted=T, mode = "undirected")
g <- simplify(g)
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)
set.seed(input$obs)#3952
layout1 <- layout.fruchterman.reingold(g)
plot(g, layout=layout1)
})
######################
output$second_plot<- renderPlot({
wordcloud(MyCorpus[[input$obs2]])
})
#####################
output$corpus_page<-renderPlot({
This<-MyCorpus[[input$obs2]][1:input$page]
wordcloud(This)
})
#####################
output$termMat<-renderText({
source$FileList[input$obs2]
})
#################################################
#################################################
})

