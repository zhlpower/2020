# GraficoNormalPadrao.R
source ("friendlycolor.R")
# normal
media <- 0
desvpad <- 1
x <- seq(from=media-5*desvpad, to=media+5*desvpad, by=0.01)
y <- dnorm(x, mean=media, sd=desvpad)
xy <- data.frame(x,y)
plot(x,y,
     main="Distribuicao normal padronizada", xlab="x", ylab=NA,
     xlim=c(media-4*desvpad,media+4*desvpad),
     axes=FALSE,
     type="l",lwd=2
     )
desvios <- c(-3,-2,-1, 0, 1, 2, 3)
axis(side = 1, at = media+desvios*desvpad)
# caudas
prob.cauda <- pnorm(media+desvios*desvpad, mean=media, sd=desvpad)
x.cauda <- qnorm(prob.cauda, mean=media, sd=desvpad)
# amarelo, verde, azul, NA, azul, verde, amarelo
cor <- c(24, 15, 9, NA, 9, 15, 24) 
for (d in 1:3) # 3, 2 e 1 desvios-padrao
{
  polx <- xy$x[xy$x>=x.cauda[d] & xy$x<=x.cauda[8-d]]
  poly <- xy$y[xy$x>=x.cauda[d] & xy$x<=x.cauda[8-d]]
  polx <- c(min(polx), polx, max(polx))
  poly<- c(0, poly, 0)
  polygon(polx,poly,border=NA,col=friendlycolor(cor[d]))
}
