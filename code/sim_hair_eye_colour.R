set.seed(9630)
data(HairEyeColor)
HairEyeColorFemale = HairEyeColor[,,2]

n = 260
hairColOpts = c("Black", "Brown", "Red", "Blond")
eyeColOpts = c("Brown", "Blue", "Hazel", "Green")

pHair = numeric()
for (hcol in hairColOpts){
    pHair = c(pHair, sum(HairEyeColorFemale[hcol,]) / sum(HairEyeColorFemale))
}

hair = character(n)
eyes = character(n)

for (i in 1:n){
    hair[i] = sample(hairColOpts, 1, p=pHair)
    eyes[i] = sample(eyeColOpts, 1, p=HairEyeColorFemale[hair[i],]/sum(HairEyeColorFemale[hair[i],]))
}

dat = data.frame(hair=hair, eyes=eyes)
write.table(dat, file="../datasets/hair_eyes.txt", col.names=T, row.names=F)
