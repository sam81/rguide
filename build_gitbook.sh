#!/bin/sh

Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::gitbook', output_dir='../gitbook')"
#Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"
