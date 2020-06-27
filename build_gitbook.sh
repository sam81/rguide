#!/bin/sh

./get_bibtex_database.sh
Rscript -e "bookdown::render_book(input='00_preface.Rmd', output_format='bookdown::gitbook', output_dir='../gitbook')"
#Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"
rm ../gitbook/rguide_datasets.zip
zip ../gitbook/rguide_datasets.zip datasets/*
