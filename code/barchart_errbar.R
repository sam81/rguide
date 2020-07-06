### This file contains functions adapted from the lattice package
### for R.
### This file is made available under the terms of the GNU General Public
### License, version 2, or at your option, any later version,
### incorporated herein by reference.
###
### This program is distributed in the hope that it will be
### useful, but WITHOUT ANY WARRANTY; without even the implied
### warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
### PURPOSE.  See the GNU General Public License for more
### details.
###
### You should have received a copy of the GNU General Public
### License along with this program; if not, write to the Free
### Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
### MA 02110-1301, USA

prepanel.barchart_errbar <- function(x, y, plot.ci=FALSE, ci.l=NULL, ci.u=NULL, horizontal=TRUE, ...) {
    if (horizontal=="FALSE"){
        list(ylim=range(y, ci.l, ci.u))
    } else if (horizontal == TRUE){
        list(xlim=range(x, ci.l, ci.u))
    }
}


panel.barchart_errbar <-
    function(x, y, box.ratio = 1, box.width = box.ratio / (1 + box.ratio),
             plot.ci=FALSE, ci.l=NULL, ci.u=NULL,
             horizontal = TRUE,
             origin = NULL, reference = TRUE,
             stack = FALSE,
             groups = NULL, 
             col = if (is.null(groups)) plot.polygon$col else superpose.polygon$col,
             border = if (is.null(groups)) plot.polygon$border else superpose.polygon$border,
             lty = if (is.null(groups)) plot.polygon$lty else superpose.polygon$lty,
             lwd = if (is.null(groups)) plot.polygon$lwd else superpose.polygon$lwd,
             ...,
             identifier = "barchart")
{
    plot.polygon <- trellis.par.get("plot.polygon")
    superpose.polygon <- trellis.par.get("superpose.polygon")
    reference.line <- trellis.par.get("reference.line")

    ## this function doesn't have a subscripts argument (which would
    ## have made barchart always pass the subscripts to the trellis
    ## object, which is unnecessary when groups = NULL).  To work
    ## around this, we have to do some things that may seem a bit odd

    keep <- 
        (function(x, y, groups, subscripts, ...) {
            !is.na(x) & !is.na(y) &
            if (is.null(groups)) TRUE
            else !is.na(groups[subscripts])
        })(x = x, y = y, groups = groups, ...)

    if (!any(keep)) return()
    x <- as.numeric(x[keep])
    y <- as.numeric(y[keep])

    if (!is.null(groups))
    {
        groupSub <- function(groups, subscripts, ...)
            groups[subscripts[keep]]

        ## This is to make sure `levels' are calculated based on the
        ## whole groups vector and not just the values represented in
        ## this particular panel (which might make the key
        ## inconsistent and/or cause other problems)

        if (!is.factor(groups)) groups <- factor(groups)
        nvals <- nlevels(groups)
        groups <- as.numeric(groupSub(groups, ...))
    }


    if (horizontal)
    {
        ## No grouping
        if (is.null(groups))
        {
            if (is.null(origin))
            {
                origin <- current.panel.limits()$xlim[1]
                reference <- FALSE
            }
            height <- box.width # box.ratio / (1 + box.ratio)
        
            if (reference)
                panel.abline(v = origin,
                             col = reference.line$col,
                             lty = reference.line$lty,
                             lwd = reference.line$lwd,
                             identifier = paste(identifier, "abline", sep = "."))

            panel.rect(x = rep(origin, length(y)),
                       y = y,
                       height = rep(height, length(y)),
                       width = x - origin,
                       border = border, col = col,
                       lty = lty, lwd = lwd,
                       just = c("left", "centre"),
                       identifier = identifier)

            ## if (plot.ci == TRUE){
            ##     panel.arrows(ci.l, y, ci.u, y, code=3, length=height*1.1/3, angle=90, col='black', cex=2, lwd=1.5)
            ## }

        }

        ## grouped, with stacked bars

        else if (stack)
        {
            if (!is.null(origin) && origin != 0)
                warning("'origin' forced to 0 for stacked bars")
 
##             vals <- seq_len(nlevels(groups))
##             groups <- as.numeric(groupSub(groups, ...))
##             ## vals <- sort(unique(groups))
##             nvals <- length(vals)

            col <- rep(col, length.out = nvals)
            border <- rep(border, length.out = nvals)
            lty <- rep(lty, length.out = nvals)
            lwd <- rep(lwd, length.out = nvals)

            height <- box.width # box.ratio / (1 + box.ratio)

            if (reference)
                panel.abline(v = origin,
                             col = reference.line$col,
                             lty = reference.line$lty,
                             lwd = reference.line$lwd,
                             identifier = paste(identifier, "abline", sep = "."))

            for (i in unique(y))
            {
                ok <- y == i
                ord <- sort.list(groups[ok])
                pos <- x[ok][ord] > 0
                nok <- sum(pos, na.rm = TRUE)
                if (nok > 0)
                    panel.rect(x = cumsum(c(0, x[ok][ord][pos][-nok])),
                               y = rep(i, nok),
                               col = col[groups[ok][ord][pos]],
                               border = border[groups[ok][ord][pos]],
                               lty = lty[groups[ok][ord][pos]],
                               lwd = lwd[groups[ok][ord][pos]],
                               height = rep(height, nok), # rep(height[i], nok),
                               width = x[ok][ord][pos],
                               just = c("left", "centre"),
                               identifier = paste(identifier, "pos", i, sep = "."))
                neg <- x[ok][ord] < 0
                nok <- sum(neg, na.rm = TRUE)
                if (nok > 0)
                    panel.rect(x = cumsum(c(0, x[ok][ord][neg][-nok])),
                               y = rep(i, nok),
                               col = col[groups[ok][ord][neg]],
                               border = border[groups[ok][ord][neg]],
                               lty = lty[groups[ok][ord][neg]],
                               lwd = lwd[groups[ok][ord][neg]],
                               height = rep(height, nok), # rep(height[i], nok),
                               width = x[ok][ord][neg],
                               just = c("left", "centre"),
                               identifier = paste(identifier, "neg", i, sep = "."))
            }
        }

        ## grouped, with side by side bars

        else
        {
            if (is.null(origin))
            {
                origin <- current.panel.limits()$xlim[1]
                reference <- FALSE
            }
##             vals <- seq_len(nlevels(groups))
##             groups <- as.numeric(groupSub(groups, ...))
##             ## vals <- sort(unique(groups))
##             nvals <- length(vals)

            col <- rep(col, length.out = nvals)
            border <- rep(border, length.out = nvals)
            lty <- rep(lty, length.out = nvals)
            lwd <- rep(lwd, length.out = nvals)

            height <- box.width / nvals # box.ratio/(1 + nvals * box.ratio)
            if (reference)
                panel.abline(v = origin,
                             col = reference.line$col,
                             lty = reference.line$lty,
                             lwd = reference.line$lwd,
                             identifier = paste(identifier, "abline", sep = "."))
            for (i in unique(y))
            {
                ok <- y == i
                nok <- sum(ok, na.rm = TRUE)
                panel.rect(x = rep(origin, nok), 
                           y = (i + height * (groups[ok] - (nvals + 1)/2)),
                           col = col[groups[ok]],
                           border = border[groups[ok]],
                           lty = lty[groups[ok]],
                           lwd = lwd[groups[ok]],
                           height = rep(height, nok), # rep(height[i], nok),
                           width = x[ok] - origin,
                           just = c("left", "centre"),
                           identifier = paste(identifier, "y", i, sep = "."))
            }
        }
    }
    
    ## if not horizontal

    else
    {
        if (is.null(groups))
        {
            if (is.null(origin))
            {
                origin <- current.panel.limits()$ylim[1]
                reference <- FALSE
            }
            width <- box.width # box.ratio/(1+box.ratio)

            if (reference)
                panel.abline(h = origin,
                             col = reference.line$col,
                             lty = reference.line$lty,
                             lwd = reference.line$lwd,
                             identifier = paste(identifier, "abline", sep = "."))

            panel.rect(x = x,
                       y = rep(origin, length(x)),
                       col = col, border = border,
                       lty = lty, lwd = lwd,
                       width = rep(width, length(x)),
                       height = y - origin,
                       just = c("centre", "bottom"),
                       identifier = identifier)

            if (plot.ci == TRUE){
                panel.arrows(x, ci.l, x, ci.u, code=3, length=width*1.1/3, angle=90, col='black', cex=2, lwd=1.5)
            }
        }
        else if (stack)
        {

            if (!is.null(origin) && origin != 0)
                warning("'origin' forced to 0 for stacked bars")

##             vals <- seq_len(nlevels(groups))
##             groups <- as.numeric(groupSub(groups, ...))
##             ## vals <- sort(unique(groups))
##             nvals <- length(vals)

            col <- rep(col, length.out = nvals)
            border <- rep(border, length.out = nvals)
            lty <- rep(lty, length.out = nvals)
            lwd <- rep(lwd, length.out = nvals)

            width <- box.width # box.ratio/(1 + box.ratio)

            if (reference)
                panel.abline(h = origin,
                             col = reference.line$col,
                             lty = reference.line$lty,
                             lwd = reference.line$lwd,
                             identifier = paste(identifier, "abline", sep = "."))

            for (i in unique(x))
            {
                ok <- x == i
                ord <- sort.list(groups[ok])
                pos <- y[ok][ord] > 0
                nok <- sum(pos, na.rm = TRUE)
                if (nok > 0)
                    panel.rect(x = rep(i, nok),
                               y = cumsum(c(0, y[ok][ord][pos][-nok])),
                               col = col[groups[ok][ord][pos]],
                               border = border[groups[ok][ord][pos]],
                               lty = lty[groups[ok][ord][pos]],
                               lwd = lwd[groups[ok][ord][pos]],
                               width = rep(width, nok),
                               height = y[ok][ord][pos],
                               just = c("centre", "bottom"),
                               identifier = paste(identifier, "pos", i, sep = "."))
                neg <- y[ok][ord] < 0
                nok <- sum(neg, na.rm = TRUE)
                if (nok > 0)
                    panel.rect(x = rep(i, nok),
                               y = cumsum(c(0, y[ok][ord][neg][-nok])),
                               col = col[groups[ok][ord][neg]],
                               border = border[groups[ok][ord][neg]],
                               lty = lty[groups[ok][ord][neg]],
                               lwd = lwd[groups[ok][ord][neg]],
                               width = rep(width, nok),
                               height = y[ok][ord][neg],
                               just = c("centre", "bottom"),
                               identifier = paste(identifier, "neg", i, sep = "."))
            }
        }
        else
        {
            if (is.null(origin))
            {
                origin <- current.panel.limits()$ylim[1]
                reference = FALSE
            }
##             vals <- seq_len(nlevels(groups))
##             groups <- as.numeric(groupSub(groups, ...))
##             ## vals <- sort(unique(groups))
##             nvals <- length(vals)

            col <- rep(col, length.out = nvals)
            border <- rep(border, length.out = nvals)
            lty <- rep(lty, length.out = nvals)
            lwd <- rep(lwd, length.out = nvals)

            width <- box.width / nvals # box.ratio/(1 + nvals * box.ratio)
            if (reference)
                panel.abline(h = origin,
                             col = reference.line$col,
                             lty = reference.line$lty,
                             lwd = reference.line$lwd,
                             identifier = paste(identifier, "abline", sep = "."))
            for (i in unique(x))
            {
                ok <- x == i
                nok <- sum(ok, na.rm = TRUE)
                panel.rect(x = (i + width * (groups[ok] - (nvals + 1)/2)),
                           y = rep(origin, nok), 
                           col = col[groups[ok]],
                           border = border[groups[ok]],
                           lty = lty[groups[ok]],
                           lwd = lwd[groups[ok]],
                           width = rep(width, nok),
                           height = y[ok] - origin,
                           just = c("centre", "bottom"),
                           identifier = paste(identifier, "x", i, sep = "."))

                if (plot.ci == TRUE){
                    panel.arrows((i + width * (groups[ok] - (nvals + 1)/2)), ci.l[ok], (i + width * (groups[ok] - (nvals + 1)/2)), ci.u[ok], code=3, length=width*1.1/3, angle=90, col='black', cex=2, lwd=1.5)
                }
            }
        }
    }
}

 
