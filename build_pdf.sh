#!/bin/sh

#Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
Rscript -e "bookdown::render_book(input='index.Rmd', output='bookdown::pdf_book', output_dir='../latex')"