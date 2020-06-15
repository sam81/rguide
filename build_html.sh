#!/bin/sh

./get_bibtex_database.sh
Rscript -e "bookdown::render_book(input='index.Rmd', output='bookdown::html_book', output_dir='../html')"
#Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"
