##colors() lists all available named colors
## 3 columns x 33 rows
seq(1,657,by=99)

t1 = colors()[1:99]
t2 = colors()[100:(99*2)]
t3 = colors()[(99*2+1):(99*3)]
t4 = colors()[(99*3+1):(99*4)]
t5 = colors()[(99*4+1):(99*5)]
t6 = colors()[(99*5+1):(99*6)]
t7 = colors()[(99*6+1):(99*7)]

tc = list(t1=t1, t2=t2, t3=t3, t4=t4, t5=t5, t6=t6, t7=t7)

## png("t1.png", width=6, height=8, units="in", res=300)
## plot.new(); plot.window(xlim=c(0,8), ylim=c(0,33), xaxs="i", yaxs="i")
## par(mar=c(0,0,0,0), oma=c(0,0,0,0))
## cn = 1
## for (cl in 1:3){
##     for (rw in 33:1){
##         rect(((cl-1)*3)-1, rw-1, ((cl*3)-2.5)-1, rw-0.2, col=t1[cn])
##         text(((cl*3)-2.5)-1, rw-0.8, as.character(t1[cn]), pos=4, cex=1)
##         #text((cl*3)-2, rw-0.8, as.character((cl-1)*3))
##         cn = cn + 1
##     }
## }
## box()
## axis(1)
## axis(2)
## dev.off()

for (i in 1:7){
    png(paste0("../Figures/t", i, ".png"), width=6, height=8, units="in", res=600)
    plot.new(); plot.window(xlim=c(0,8), ylim=c(0,33), xaxs="i", yaxs="i")
    par(mar=c(0,0,0,0), oma=c(0,0,0,0))
    cn = 1
    for (cl in 1:3){
        for (rw in 33:1){
            if (is.na(tc[[paste0("t", i)]][cn]) == FALSE){
                rect(((cl-1)*3)-1, rw-1, ((cl*3)-2.5)-1, rw-0.2, col=tc[[paste0("t", i)]][cn])
                text(((cl*3)-2.5)-1, rw-0.8, as.character(tc[[paste0("t", i)]][cn]), pos=4, cex=0.9)
            }
            cn = cn + 1
        }
    }
    box()
    axis(1)
    axis(2)
    dev.off()
}
