#!/bin/sh

./get_bibtex_database.sh
Rscript -e "bookdown::render_book(input='index.Rmd', output_format='bookdown::gitbook', output_dir='../gitbook')"
Rscript -e "bookdown::render_book(input='index.Rmd', output='bookdown::pdf_book', output_dir='../latex')"
Rscript -e "bookdown::render_book(input='index.Rmd', output='bookdown::epub_book', output_dir='../ebook')"

cp ../ebook/rguide.epub ../gitbook
cp ../latex/rguide.pdf ../gitbook
#Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"
