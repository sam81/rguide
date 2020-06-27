# Orienting

- adding files: _bookdown.yml
- settings/appearance: _output.yml and index.Rmd

# Bugs

- equation labesl are not supported for ebook version. Consider dropping ebook version.

# TODO

- GLOBAL
  * Switch to lower case figure/table captions
  * use built-in datasets of datasets from packages instead of made up datasets or simulations
  * add rmarkdown chapter?
  * add Bayesian stats (JAGS, STAN) chapter?
  * add chapter on psychophysics (dprime, psychometric functions)?
- 01_installing_R:
  * add section on installing packages on Mac and say that you can use the `Linux` method of package installation also on Windows and Mac
- 02_a_simple_introduction_to_R:
  * check that both `<-` and `=` are mentioned
  * add section with overview/map of the guide and links to jump around?
- 03_organizing_a_working_session:
 * add Rscript?
- 04_data_manipulation:
  * section on reshape2 and dcast / tidyr pivot_wider
- 05_printing_data:
  * add link to printing tibbles?
- 06_file_IO:
  * add HDF5
- 07_graphics
  * add example of two-column barplot
  * color section add viridis, RColorBrewer, and colorblind palette
- 08_fonts:

- 09_ggplot2:
  * publication quality tweaks and cowplot
  * common charts: add histograms, density plots, boxplots, lollipop plots, stripcharts
- 10_plotly:
  * add more examples, check if pdf issue can be fixed
- 11_lattice:
  * mention things that can't be done in ggplot2: shingles and 3d plots
- 12_tidyverse:

- 13_distributions:
  * add uniform, t, gamma distributions
- 14_hypotheses:

- 15_cor_reg:
  * add more regression examples and diagnostics
  * dummy coding
- 16_anova:
  * add ez for ANOVA
  * emmeans?
- 17_mcomp:

- 18_programming:
  * add `for` and `while` loops
- 19_administration_maintenance:

- 20_ess:
  * mention poly-R?
- 21_sweave:

- 22_sound:

- 23_bibliographies:

- 24_packages:

- 25_commands:

- 26_resources:

- 27_colors_table

- Bibliography:
  * move to refs_long and set to copy refs_long on release
  
# Packages need to build the book

install.packages(c("bookdown", "car", "cowplot", "dplyr", "ggplot2", "gplots", "gtools", "lattice", "latticeExtra", "plotly", "tibble", "tidyr", "webshot"))


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
