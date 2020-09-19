# Orienting

- adding files: _bookdown.yml
- settings/appearance: _output.yml and index.Rmd

# Bugs

- equation labesl are not supported for ebook version. Consider dropping ebook version.

# TODO

- GLOBAL
  * use built-in datasets or datasets from packages instead of made up datasets or simulations
  * add rmarkdown chapter?
  * add Bayesian stats (JAGS, STAN) chapter?
  * add chapter on psychophysics (dprime, psychometric functions)?

- 01_getting_started_with_R:
  * add section on installing packages on Mac and say that you can use the `Linux` method of package installation also on Windows and Mac
  * add section with overview/map of the guide and links to jump around
- 02_organizing_a_working_session:
 * add Rscript?
- 03_data_manipulation:
  * %in% operator
  * section on reshape2 and dcast / tidyr pivot_wider
- 04_programming:
  * add more about functions, e.g. `...` argument, returning multiple arguments through lists
- 05_file_IO:
  * add HDF5
- 06_graphics

- 07_ggplot2:
  * common charts: add histograms, density plots, boxplots, lollipop plots, stripcharts
- 08_plotly:
  * add more examples
- 09_lattice:
  * mention things that can't be done in ggplot2: shingles and 3d plots
- 10_graphics_common:

- 11_figures_for_publication:

- 12_tidyverse:

- 13_distributions:
  * add uniform, t, gamma distributions
- 14_hypotheses:
  * emmeans
  * use example of spotting errors while reading a document. Within or between-subject variables can be background color, font color, font style, medium (paper, PC screen, tablet).
- 15_cor_reg:
  * add more regression examples and diagnostics
  * dummy coding
- 16_mcomp:

- 17_administration_maintenance:

- 18_ess:
  * mention poly-R?
- 19_writing_reports:
  * add brief rmarkdown introduction

- 20_sound:

- 21_packages:

- 22_commands:

- 23_resources:

- 24_colors_table

  
# Packages need to build the book

install.packages(c("bookdown", "car", "cowplot", "dplyr", "ez", "ggplot2", "gplots", "gtools", "lattice", "latticeExtra", "plotly", "tibble", "tidyr", "webshot"))


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

- to prevent messages from appearing in rmarkdown chunks when loading a package use `message=FALSE`

## Citations

[@sarkar2008]

## Links

[I'm an inline-style link](https://www.google.com)

## References to sections {#sectag}

\@ref(sectag)

## Custom blocks

```{block, type='rmdwarning'}
A warning
```

with block2 I get a dash 
```{block2, type='rmdwarning'}
A warning
```

not sure what's the issue, need to see 
https://bookdown.org/yihui/rmarkdown-cookbook/custom-blocks.html 
https://bookdown.org/yihui/bookdown/custom-blocks.html

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
