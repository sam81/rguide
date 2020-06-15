# Orienting

- adding files: _bookdown.yml
- settings/appearance: _output.yml and index.Rmd

# TODO

- GLOBAL
  * Switch to lower case chapter/section names
- 01_installing_R:
  * add section on installing packages on Mac and say that you can use the `Linux` method of package installation also on Windows and Mac
- 04_data_manipulation:
  * section on reshape2 and dcast
- 06_file_IO:
  * add HDF5
- 07_graphics
  * add example of two-column barplot
  * color section add viridis, RColorBrewer, and colorblind palette
- 09_ggplot2:
  * publication quality tweaks and cowplot
- 13_distributions:
  * add binomial distribution
- 15_cor_reg:
  * add more regression examples and diagnostics
  * dummy coding
- 16_anova:
  * add ez for ANOVA
- 18_programming:
  * add `for` and `while` loops

- Bibliography:
  * move to refs_long and set to copy refs_long on release
  
# Packages need to build the book

install.packages("bookdown", "car", "dplyr", "ggplot2", "gplots", "gtools", "lattice", "plotly", "tibble", "webshot")


# Bookdown 

- code chunk needs to have one empty line after it ends otherwise figure is labeled as such in LaTeX

- looks like bookdown doesn't like underscores in anchor names, for example {#data_manip} doesn't seem to work, need to change to {#datamanip}

- install.packages("webshot") for plotly figure in pdf

- `preview_chapter` does not work if `render_book` is not called first in the same output folder:

```
library(bookdown)
render_book("00_preface.Rmd")
render_book("desired_chapter.Rmd", output_format="bookdown::gitbook", preview=T)
##render_book("desired_chapter.Rmd", output_format="bookdown::pdf_book", preview=T)
```

to keep variables set `new_session=FALSE`:

```
render_book("desired_chapter.Rmd", output_format="bookdown::gitbook", 
	preview=T, new_session=F)
```

- to prevent messages from appearing in rmarkdown chunks when loading a package use message=FALSE

## Citations

[@sarkar2008]

## Links

[I'm an inline-style link](https://www.google.com)

## References to sections {#sectag}

\@ref(sectag)

## Custom blocks

```{block2, type='rmdwarning'}
A warning
```

## Output overflow
https://bookdown.org/yihui/rmarkdown-cookbook/text-width.html

## Tables

Single column tables are confused with headings, add a ghost second column to fix:

Aesthetic 
------------- ---
`color`
`fill`
`shape` 
`size`
`linetype`

Table: (\#tab:aes) Common `ggplot2` aesthetics.
