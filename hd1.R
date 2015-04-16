#!/usr/bin/env Rscript
Sys.setenv(HADOOP_STREAMING = "/usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.6.0.jar")
library(rmr2) 

#clean punctuation
my.substitution <- function(my.text){
my.text<-tolower(my.text)
my.text<-gsub("[[:punct:]]"," ",my.text)
my.text<-gsub("[[:space:]]"," ",my.text)
my.text<-gsub("[[:space:]][[:space:]]"," ",my.text)
my.text<-gsub("[[:space:]][[:space:]]"," ",my.text)
my.text
}

## map function
map <- function(k,lines) {
  clean_lines<-sapply(lines,my.substitution)
  words.list <- strsplit(clean_lines, '\\s') 
  words <- unlist(words.list)
  return( keyval(words, 1) )
}

## reduce function
reduce <- function(word, counts) { 
  keyval(word, sum(counts))
}

wordcount <- function (input, output=NULL) { 
  mapreduce(input=input, output=output, input.format="text", 
            map=map, reduce=reduce)
}


## delete previous result if any
system("hdfs dfs -rm -r /wordcount/out")

## Submit job
hdfs.root <- 'wordcount'
hdfs.data <- file.path(hdfs.root, 'data') 
hdfs.out <- file.path(hdfs.root, 'out') 
out <- wordcount(hdfs.data, hdfs.out)

## Fetch results from HDFS
results <- from.dfs(out)

## check top 4 frequent words
results.df <- as.data.frame(results, stringsAsFactors=F) 
colnames(results.df) <- c('word', 'count') 
head(results.df[order(results.df$count, decreasing=T), ], 100)

