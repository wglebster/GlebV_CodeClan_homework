#global.R
library(shiny)
library(tidyverse)
library(CodeClanData)

#set input variables
#class(game_sales$year_of_release)
min_slider <- min(game_sales$year_of_release)
max_slider <- max(game_sales$year_of_release)
genre_choice <- c("all", unique(game_sales$genre))
platform_choice <- c("all", unique(game_sales$platform))
rating_choice <- c("all", unique(game_sales$rating))

#data wrangling
