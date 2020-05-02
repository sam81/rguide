# Orienting

- adding files: _bookdown.yml
- settings/appearance: _output.yml and index.Rmd

# TODO

- data.Rmd: ADD FILE CONNECTIONS, CAT, PASTE
- data IO add RDS and HDF5
- add ggplot2 publication quality tweaks and cowplot
- color section add viridis, RColorBrewer, and colorblind palette
- add more regression examples and diagnostics
- section on reshape2 and dcast
- add ez for ANOVA
- add binomial distribution

# Packages need to build the book

install.packages("bookdown", "ggplot2", "gplots", "gtools", "lattice", "plotly", "webshot")


# Bookdown quirks

- code chunk needs to have one empty line after it ends otherwise figure is labeled as such in LaTeX

- looks like bookdown doesn't like underscores in anchor names, for example {#data_manip} doesn't seem to work, need to change to {#datamanip}

- install.packages("webshot") for plotly figure in pdf

- preview_chapter does not seem to work if render_book is not called first render_book("00_preface.Rmd")

- to precent messages from appearing in rmarkdown chunks when loading a package use message=FALSE
