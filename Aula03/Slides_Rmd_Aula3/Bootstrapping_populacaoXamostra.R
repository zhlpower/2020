# Bootstrapping_populacaoXamostra.R
source ("friendlycolor.R")

# Uma variavel qualquer
N <- 1000000 # tamanho da populacao
mu1 <- 80 # media de 2/3 da populacao
sigma1 <- 30 # desvio padrao de 2/3 da populacao
mu2 <- 180 # media de 1/3 da populacao
sigma2 <- 50 # desvio padrao de 2/3 da populacao
n <- 100 # tamanho de cada amostra
B <- 3000 # numero de amostras
# set.seed(123)

# criando uma populacao ficticia
pop_valores <- round(rnorm(2*N/3, mean=mu1, sd=sigma1),0)
pop_valores <- c(pop_valores,
                 round(rnorm(1*N/3, mean=mu2, sd=sigma2),0))
mean_pop <- mean(pop_valores)
sd_pop <- sd(pop_valores)

filepdf <- NA # "bootstrapping_popassimetria.pdf" 
if (!is.na(filepdf)) 
{
  pdf(filepdf, width = 11.02, height = 8.27)
}
# tamanho do texto
f_cex <- 1 # tamanho na tela
if (!is.na(filepdf)) 
{
  f_cex <- 1.7 # tamanho no pdf
}

# texto explicativo
cat("\nPopulacao ficticia\n")
plot(NA,NA,xlim=c(0,100),ylim=c(0,100),xlab=NA,ylab=NA,axes = FALSE)
txt_col <- 0
txt_lin <- 100
txt_inc <- 6
# titulo
text(txt_col,txt_lin,"Populacao",pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
txt_lin <- txt_lin-txt_inc; # pula uma linha
text(txt_col,txt_lin,"Apresentamos uma populacao simulada.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
txt_lin <- txt_lin-txt_inc; # pula uma linha
text(txt_col,txt_lin,"A populacao e representada em azul; a barra azul na",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"parte alta do grafico mostra a media e os desvios-padrao.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
if (is.na(filepdf)) 
{
  # Aguarda [enter]
  text(0,0,"Pressione [enter] (na Console) para continuar",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
  readline(prompt="Pressione [enter] para continuar")
}
cat("Exibindo a populacao\n")
# distribuicao dos valores nesta populacao ficticia
dpop_valores <- density(pop_valores)
plot (dpop_valores, main="Populacao ficticia", 
      xlab = "Valor", ylab = "densidade",
      xlim = c(min(mu1,mu2)-4*max(sigma1,sigma2),
               max(mu1,mu2)+4*max(sigma1,sigma2)),
      ylim = c(0,max(dpop_valores$y)*1.3),
      col = friendlycolor(10),
      lwd=2, type = "l")
tp <- 44
for (i in -3:3)
{
  lines(c(mean_pop-i*sd_pop, mean_pop),
        c(max(dpop_valores$y)*1.2,max(dpop_valores$y)*1.2),
        lwd=10, lty=1, col = paste(friendlycolor(8),tp,sep="") )
}
legend("right", 
       c("Distribuicao", "Media +-3 d.p."), 
       col=c(friendlycolor(8),paste(friendlycolor(8),"44",sep="")),
       lwd=c(2,10), 
       lty=c(1,1), 
       box.lwd=0, bg="transparent")  
# pausa para ver o grafico
Sys.sleep(5)

# amostras da populacao ficticia
# texto explicativo
cat("\nFazendo amostragem\n")
plot(NA,NA,xlim=c(0,100),ylim=c(0,100),xlab=NA,ylab=NA,axes = FALSE)
txt_col <- 0
txt_lin <- 100
txt_inc <- 6
# titulo
text(txt_col,txt_lin,"Amostragem (sampling)",pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
txt_lin <- txt_lin-txt_inc; # pula uma linha
text(txt_col,txt_lin,paste("Retiraremos desta populacao ",B," amostras com n = ",n,".", sep=""),pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"As amostras aparecem em laranja.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"Ao final das amostragens, uma linha pontilhada vertical",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"em vermelho corresponde a media das medias amostrais.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"Na parte alta do grafico a barra horizontal em vermelho",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"mostra a media das medias amostrais e a media dos",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"desvios-padrao amostrais.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"A banda vertical, em amarelo, representa as ",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"médias amostrais individuais",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
txt_lin <- txt_lin-txt_inc; # pula uma linha
text(txt_col,txt_lin,"Repare que a media das medias amostrais coincide com",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"a media populacional e que a media dos desvios-padrao",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"amostrais coincide com o d.p. populacional.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
if (is.na(filepdf)) 
{
  # Aguarda [enter]
  text(0,0,"Pressione [enter] (na Console) para continuar",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
  readline(prompt="Pressione [enter] para continuar")
}
cat("Aguarde: amostrando (observe o grafico)\n")
# reapresenta a populacao
plot (dpop_valores, main=paste("Amostragem (",B," amostras com n = ",n,")",sep=""), 
      xlab = "Valor", ylab = "densidade",
      xlim = c(min(mu1,mu2)-4*max(sigma1,sigma2),
               max(mu1,mu2)+4*max(sigma1,sigma2)),
      ylim = c(0,max(dpop_valores$y)*1.3),
      col = friendlycolor(10),
      lwd=2, type = "l")
# plota media e dp populacional
tp <- 44
for (i in -3:3)
{
  lines(c(mean_pop-i*sd_pop, mean_pop),
        c(max(dpop_valores$y)*1.2,max(dpop_valores$y)*1.2),
        lwd=10, lty=1, col = paste(friendlycolor(8),tp,sep="") )
}
amo_med <- c() # guardando as medias amostras
amo_sd <- c() # guardando os d.p. amostras
for (a in 1:B)
{
  amostra <- sample(pop_valores, n, replace=FALSE)
  amo_med <- c(amo_med,mean(amostra))
  amo_sd <- c(amo_sd,sd(amostra))
  amo_dens <- density(amostra, bw = 4)
  lines(amo_dens, col=paste(friendlycolor(22),"04",sep=""), lwd=0.4)
}
mean_amo <- mean(amo_med)
sd_amo <- mean(amo_sd)
# replota a populacao
abline(v=amo_med, col=paste(friendlycolor(24),"01",sep=""))
abline(v=mean_amo, lwd=2, lty=3, col=friendlycolor(19))
# replota media e dp populacional
tp <- 44
for (i in -3:3)
{
  lines(c(mean_pop-i*sd_pop, mean_pop),
        c(max(dpop_valores$y)*1.2,max(dpop_valores$y)*1.2),
        lwd=10, lty=1, col = paste(friendlycolor(8),tp,sep="") )
}
tp <- 44
for (i in -3:3)
{
  lines(c(mean_amo-i*sd_amo, mean_amo),
        c(max(dpop_valores$y)*1.3,max(dpop_valores$y)*1.3),
        lwd=10, lty=1, col = paste(friendlycolor(19),tp,sep="") )
}
legend(x=mean_pop+2*sd_pop, y=max(dpop_valores$y)*1.1,
       c("Distribuicao pop.", 
         "Media pop +-3 d.p.",
         paste(B,"amostras"),
         "Media(sampling)",
         "Sampling +-3 d.p."
       ), 
       col=c(
         friendlycolor(8),
         paste(friendlycolor(8),"44",sep=""),
         friendlycolor(22),
         friendlycolor(19),
         paste(friendlycolor(19),"44",sep="")
       ),
       lwd=c(2,10,2,2,10), 
       lty=c(1,1,1,3,1), 
       box.lwd=0, bg="transparent",
       cex=0.8)  

txt <- c()
txt <- c(txt,paste("Populacao e Sampling"))
txt <- c(txt,paste(" "))
txt <- c(txt,paste("Populacao:"))
txt <- c(txt,paste("  media populacional:",round(mean_pop,3)))
txt <- c(txt,paste("  d.p. populacional:",round(sd_pop,3)))
txt <- c(txt,paste(" "))
txt <- c(txt,paste("Amostras:",B,"com n =",n))
txt <- c(txt,paste("  media das medias amostrais:",round(mean_amo,3)))
txt <- c(txt,paste("  media dos d.p. amostrais:",round(sd_amo,3)))
plot(NA,NA,xlim=c(0,100),ylim=c(0,100),xlab=NA,ylab=NA,axes = FALSE)
txt_col <- 0
txt_lin <- 100
txt_inc <- 6
# titulo
text(txt_col,txt_lin,txt[1],pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
# texto
for (t in 2:length(txt))
{
  text(txt_col,txt_lin,txt[t],pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
}


# texto explicativo
cat("\nDistribuicao das medias amostrais\n")
plot(NA,NA,xlim=c(0,100),ylim=c(0,100),xlab=NA,ylab=NA,axes = FALSE)
txt_col <- 0
txt_lin <- 100
txt_inc <- 6
# titulo
text(txt_col,txt_lin,"Distribuicao das medias amostrais",pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"(Teorema Central do Limite)",pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
txt_lin <- txt_lin-txt_inc; # pula uma linha
text(txt_col,txt_lin,"Independentemente da forma da distribuicao da populacao original,",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"a distribuicao das medias amostrais tem distribuicao NORMAL",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"com media igual a media da populacao e com certo desvio-padrao.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"Este ultimo desvio-padrao recebe o nome de Erro Padrao da Media (EPM),",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"o qual (em teoria) e estimado pelo desvio-padrao da populacao",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"dividido pela raiz quadrada do tamanho (n) de cada amostra.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
txt_lin <- txt_lin-txt_inc; # pula uma linha
text(txt_col,txt_lin,"O proximo grafico mostra a distribuicao das medias amostrais",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"e distribuicoes normais sobrepostas (pontilhadas)",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"mostrando sua adequacao (a que tem a cor da linha solida",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"usa os valores amostrados; em preto a distribuicao teorica).",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
if (is.na(filepdf)) 
{
  # Aguarda [enter]
  text(0,0,"Pressione [enter] (na Console) para continuar",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
  readline(prompt="Pressione [enter] para continuar")
}
cat("Exibindo o EPM\n")

# apresenta o EPM por amostragem
damo_med <- density(amo_med)
plot (damo_med, main=paste("Distribuicao de Medias Amostrais\n(",B," amostras com n = ",n,")",sep=""), 
      xlab = "Valor", ylab = "densidade",
      ylim = c(0, max(damo_med$y)*1.3),
      col = friendlycolor(19),
      lwd=3, type = "l")
sd_epmamostral <- sd(amo_med)
minx <- mean_amo-5*sd_epmamostral
maxx <- mean_amo+5*sd_epmamostral
byx <- (maxx-minx)/100
x_normal <- seq(from=minx, to=maxx, by=byx)
y_normal <- dnorm(x_normal, mean=mean_amo, sd=sd_epmamostral)
lines(x_normal,y_normal, lwd=2, lty=3, col = friendlycolor(19))
sd_epmteorico <- sd_pop/(n^0.5)
minx <- mean_pop-5*sd_epmteorico
maxx <- mean_pop+5*sd_epmteorico
byx <- (maxx-minx)/100
x_normal <- seq(from=minx, to=maxx, by=byx)
y_normal <- dnorm(x_normal, mean=mean_pop, sd=sd_epmteorico)
lines(x_normal,y_normal, lwd=1, lty=4)
legend("topright",
       c("Distribuicao", 
         "Nl. simulada",
         "Nl. teorica"
       ), 
       col=c(
         friendlycolor(19),
         friendlycolor(19),
         "#000000"
       ),
       lwd=c(3,2,1), 
       lty=c(1,3,4), 
       box.lwd=0, bg="transparent",
       cex=0.8)  
# pausa para ver o grafico
Sys.sleep(10)

txt <- c()
txt <- c(txt,paste("Populacao, Sampling e EPM"))
txt <- c(txt,paste(" "))
txt <- c(txt,paste("Populacao:"))
txt <- c(txt,paste("  media populacional:",round(mean_pop,3)))
txt <- c(txt,paste("  d.p. populacional:",round(sd_pop,3)))
txt <- c(txt,paste(" "))
txt <- c(txt,paste("Amostras:",B,"com n =",n))
txt <- c(txt,paste("  media das medias amostrais:",round(mean_amo,3)))
txt <- c(txt,paste("  media dos d.p. amostrais:",round(sd_amo,3)))
txt <- c(txt,paste(" "))
txt <- c(txt,paste("EPM:"))
txt <- c(txt,paste("  EPM (desvio-padrao das medias amostrais):",round(sd_epmamostral,3)))
txt <- c(txt,paste("  EPM estimado em teoria: d.p.populacional/(n^0.5):",round(sd_epmteorico,3)))
plot(NA,NA,xlim=c(0,100),ylim=c(0,100),xlab=NA,ylab=NA,axes = FALSE)
txt_col <- 0
txt_lin <- 100
txt_inc <- 6
# titulo
text(txt_col,txt_lin,txt[1],pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
# texto
for (t in 2:length(txt))
{
  text(txt_col,txt_lin,txt[t],pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
}

# Passando para a pratica
# texto explicativo
cat("\nPopulacao e amostra unica\n")
plot(NA,NA,xlim=c(0,100),ylim=c(0,100),xlab=NA,ylab=NA,axes = FALSE)
txt_col <- 0
txt_lin <- 100
txt_inc <- 6
# titulo
text(txt_col,txt_lin,"Saindo da fantasia",pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
txt_lin <- txt_lin-txt_inc; # pula uma linha
text(txt_col,txt_lin,paste("Ninguem faz ",B," amostras de uma populacao.", sep=""),pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"Na pratica somente uma amostra e obtida.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
if (is.na(filepdf)) 
{
  # Aguarda [enter]
  text(0,0,"Pressione [enter] (na Console) para continuar",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
  readline(prompt="Pressione [enter] para continuar")
}
# reapresenta a populacao
plot (dpop_valores, main=paste("Populacao e amostra unica com n = ",n,sep=""), 
      xlab = "Valor", ylab = "densidade",
      xlim = c(min(mu1,mu2)-4*max(sigma1,sigma2),
               max(mu1,mu2)+4*max(sigma1,sigma2)),
      ylim = c(0,max(dpop_valores$y)*1.3),
      col = friendlycolor(10),
      lwd=2, type = "l")
# amostra unica
amostra_unica <- sample(pop_valores, n, replace=FALSE)
mean_amouni <- mean(amostra_unica)
sd_amouni <- sd(amostra_unica)
amouni_dens <- density(amostra_unica, bw = 4)
lines(amouni_dens, col=paste(friendlycolor(22),sep=""), lwd=3)
abline(v=mean_amouni, lwd=2, lty=3, col=friendlycolor(19))
tp <- 44
for (i in -3:3)
{
  lines(c(mean_pop-i*sd_pop, mean_pop),
        c(max(dpop_valores$y)*1.2,max(dpop_valores$y)*1.2),
        lwd=10, lty=1, col = paste(friendlycolor(8),tp,sep="") )
}
tp <- 44
for (i in -3:3)
{
  lines(c(mean_amouni-i*sd_amouni, mean_amouni),
        c(max(dpop_valores$y)*1.3,max(dpop_valores$y)*1.3),
        lwd=10, lty=1, col = paste(friendlycolor(19),tp,sep="") )
}
legend(x=mean_pop+2*sd_pop, y=max(dpop_valores$y)*1.1,
       c("Distribuicao pop.", 
         "Media pop +-3 d.p.",
         "Amostra unica",
         "Media amostral",
         "Media amostral +-3 d.p."
       ), 
       col=c(
         friendlycolor(8),
         paste(friendlycolor(8),"44",sep=""),
         friendlycolor(22),
         friendlycolor(19),
         paste(friendlycolor(19),"44",sep="")
       ),
       lwd=c(2,10,2,2,10), 
       lty=c(1,1,1,3,1), 
       box.lwd=0, bg="transparent",
       cex=0.8)  
# pausa para ver o grafico
Sys.sleep(10)

txt <- c()
txt <- c(txt,paste("Populacao e Amostra Unica"))
txt <- c(txt,paste(" "))
txt <- c(txt,paste("Populacao:"))
txt <- c(txt,paste("  media populacional:",round(mean_pop,3)))
txt <- c(txt,paste("  d.p. populacional:",round(sd_pop,3)))
txt <- c(txt,paste(" "))
txt <- c(txt,paste("Amostra com n =",n))
txt <- c(txt,paste("  media amostral:",round(mean_amouni,3)))
txt <- c(txt,paste("  d.p. amostral:",round(sd_amouni,3)))
plot(NA,NA,xlim=c(0,100),ylim=c(0,100),xlab=NA,ylab=NA,axes = FALSE)
txt_col <- 0
txt_lin <- 100
txt_inc <- 6
# titulo
text(txt_col,txt_lin,txt[1],pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
# texto
for (t in 2:length(txt))
{
  text(txt_col,txt_lin,txt[t],pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
}

# texto explicativo
cat("\nAmostra unica\n")
plot(NA,NA,xlim=c(0,100),ylim=c(0,100),xlab=NA,ylab=NA,axes = FALSE)
txt_col <- 0
txt_lin <- 100
txt_inc <- 6
# titulo
text(txt_col,txt_lin,"Saindo da fantasia",pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
txt_lin <- txt_lin-txt_inc; # pula uma linha
text(txt_col,txt_lin,"Mais do que isto: não conhecemos a população e, portanto,",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"não fazemos ideia se temos uma amostra representativa.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
if (is.na(filepdf)) 
{
  # Aguarda [enter]
  text(0,0,"Pressione [enter] (na Console) para continuar",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
  readline(prompt="Pressione [enter] para continuar")
}
# reapresenta a populacao
plot (NA, main=paste("Amostra unica com n = ",n,sep=""), 
      xlab = "Valor", ylab = "densidade",
      xlim = c(min(mu1,mu2)-4*max(sigma1,sigma2),
               max(mu1,mu2)+4*max(sigma1,sigma2)),
      ylim = c(0,max(dpop_valores$y)*1.3)
)
# reapresenta a ultima amostra 
lines(amouni_dens, col=paste(friendlycolor(22),sep=""), lwd=3)
abline(v=mean_amouni, lwd=2, lty=3, col=friendlycolor(19))
tp <- 44
for (i in -3:3)
{
  lines(c(mean_amouni-i*sd_amouni, mean_amouni),
        c(max(dpop_valores$y)*1.3,max(dpop_valores$y)*1.3),
        lwd=10, lty=1, col = paste(friendlycolor(19),tp,sep="") )
}
legend(x=mean_pop+2*sd_pop, y=max(dpop_valores$y)*1.1,
       c("Amostra unica",
         "Media amostral",
         "Media amostral +-3 d.p."
       ), 
       col=c(
         friendlycolor(22),
         friendlycolor(19),
         paste(friendlycolor(19),"44",sep="")
       ),
       lwd=c(2,2,10), 
       lty=c(1,3,1), 
       box.lwd=0, bg="transparent",
       cex=0.8)  
# pausa para ver o grafico
Sys.sleep(10)

# texto explicativo
cat("\nRemostragem com bootstrapping\n")
plot(NA,NA,xlim=c(0,100),ylim=c(0,100),xlab=NA,ylab=NA,axes = FALSE)
txt_col <- 0
txt_lin <- 100
txt_inc <- 6
# titulo
text(txt_col,txt_lin,"Bootstrapping",pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
txt_lin <- txt_lin-txt_inc; # pula uma linha
text(txt_col,txt_lin,"O que podemos fazer é um processo similar ao anterior,",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,paste("fazendo ",B," reamostragens de ",n," elementos COM REPOSICAO.",sep=""),pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
if (is.na(filepdf)) 
{
  # Aguarda [enter]
  text(0,0,"Pressione [enter] (na Console) para continuar",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
  readline(prompt="Pressione [enter] para continuar")
}
cat("Aguarde: executando o bootstrapping (observe o grafico).\n")
# reapresenta a amostra
plot (amouni_dens, main=paste("Bootstrapping (",B," reamostras com n = ",n,")",sep=""), 
      xlab = "Valor", ylab = "densidade",
      xlim = c(min(mu1,mu2)-4*max(sigma1,sigma2),
               max(mu1,mu2)+4*max(sigma1,sigma2)),
      ylim = c(0,max(dpop_valores$y)*1.3),
      col = friendlycolor(22),
      lwd=2, type = "l")
tp <- 44
for (i in -3:3)
{
  lines(c(mean_amouni-i*sd_amouni, mean_amouni),
        c(max(dpop_valores$y)*1.3,max(dpop_valores$y)*1.3),
        lwd=10, lty=1, col = paste(friendlycolor(19),tp,sep="") )
}
boot_med <- c() # guardando as medias amostras do bootstrapping
boot_sd <- c() # guardando os d.p. amostras do bootstrapping
for (a in 1:B)
{
  amostra <- sample(amostra_unica, n, replace=TRUE)
  boot_med <- c(boot_med,mean(amostra))
  boot_sd <- c(boot_sd,sd(amostra))
  amo_dens <- density(amostra, bw = 4)
  lines(amo_dens, col=paste(friendlycolor(15),"04",sep=""), lwd=0.4)
}
# replota a amostra unica
lines (amouni_dens, lwd=3, col = friendlycolor(22))
mean_boot <- mean(boot_med)
sd_boot <- mean(boot_sd)
abline(v=boot_med, col=paste(friendlycolor(24),"04",sep=""))
abline(v=mean_boot, lwd=2, lty=3, col=friendlycolor(13))
# replota media e dp da amostra unica
tp <- 44
for (i in -3:3)
{
  lines(c(mean_amouni-i*sd_amouni, mean_amouni),
        c(max(dpop_valores$y)*1.3,max(dpop_valores$y)*1.3),
        lwd=10, lty=1, col = paste(friendlycolor(19),tp,sep="") )
}
# plota media e dp do bootstrapping
tp <- 44
for (i in -3:3)
{
  lines(c(mean_boot-i*sd_boot, mean_boot),
        c(max(dpop_valores$y)*1.2,max(dpop_valores$y)*1.2),
        lwd=10, lty=1, col = paste(friendlycolor(13),tp,sep="") )
}
legend(x=mean_pop+2*sd_pop, y=max(dpop_valores$y)*1.1,
       c("Dist. da amostra", 
         "Media am +-3 d.p.",
         paste(B,"amostras"),
         "Media geral (bootstrp.)",
         "Medias bootstrp",
         "Bootstrp. +-3 d.p."
       ), 
       col=c(
         friendlycolor(22),
         paste(friendlycolor(19),"44",sep=""),
         friendlycolor(15),
         friendlycolor(13),
         paste(friendlycolor(24),"20",sep=""),
         paste(friendlycolor(13),"44",sep="")
       ),
       lwd=c(2,10,2,2,10,10), 
       lty=c(1,1,1,3,1,1), 
       box.lwd=0, bg="transparent",
       cex=0.8)  

# pausa para ver o grafico
Sys.sleep(10)

txt <- c()
txt <- c(txt,paste("Amostra com Bootstrapping"))
txt <- c(txt,paste(" "))
txt <- c(txt,paste("Amostra com n =",n))
txt <- c(txt,paste("  media amostral:",round(mean_amouni,3)))
txt <- c(txt,paste("  d.p. amostral:",round(sd_amouni,3)))
txt <- c(txt,paste(" "))
txt <- c(txt,paste("Reamostras:",B,"com n =",n))
txt <- c(txt,paste("  media das medias amostrais:",round(mean_boot,3)))
txt <- c(txt,paste("  media dos d.p. amostrais:",round(sd_boot,3)))
plot(NA,NA,xlim=c(0,100),ylim=c(0,100),xlab=NA,ylab=NA,axes = FALSE)
txt_col <- 0
txt_lin <- 100
txt_inc <- 6
# titulo
text(txt_col,txt_lin,txt[1],pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
# texto
for (t in 2:length(txt))
{
  text(txt_col,txt_lin,txt[t],pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
}

# texto explicativo
cat("\nDistribuicao das medias amostrais do bootstrapping\n")
plot(NA,NA,xlim=c(0,100),ylim=c(0,100),xlab=NA,ylab=NA,axes = FALSE)
txt_col <- 0
txt_lin <- 100
txt_inc <- 6
# titulo
text(txt_col,txt_lin,"Distribuicao das medias amostrais",pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"(Teorema Central do Limite com Bootstrapping)",pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
txt_lin <- txt_lin-txt_inc; # pula uma linha
text(txt_col,txt_lin,"Novamente, independentemente da forma da distribuicao da amostra,",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"a distribuicao das medias amostrais tem distribuicao NORMAL",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"com media igual a media da amostra e com certo desvio-padrao.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"Este ultimo desvio-padrao e, tambem, o Erro Padrao da Media (EPM).",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
txt_lin <- txt_lin-txt_inc; # pula uma linha
text(txt_col,txt_lin,"Embora nao conhecamos a populacao na pratica, neste exemplo podemos",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"comparar o EPM obtido pelo bootstrapping com o que obtivemos por",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"amostras repetidas a partir da populacao ficticia que criamos.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
txt_lin <- txt_lin-txt_inc; # pula uma linha
text(txt_col,txt_lin,"O proximo grafico mostra a distribuicao das medias amostrais",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"por amostras da populacao e pelo processo de bootstrapping,",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"para comparacao.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"Distribuicoes normais sobrepostas (pontilhadas) usando a media e d.p.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
text(txt_col,txt_lin,"dos dois processos sao tambem apresentadas.",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
if (is.na(filepdf)) 
{
  # Aguarda [enter]
  text(0,0,"Pressione [enter] (na Console) para continuar",pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
  readline(prompt="Pressione [enter] para continuar")
}
cat("Exibindo o EPM\n")


# reapresenta o EPM por amostragem
damo_med <- density(amo_med)
plot (damo_med, main=paste("Distribuicao de Medias Amostrais\n(",B," amostras com n = ",n,")",sep=""), 
      xlab = "Valor", ylab = "densidade",
      ylim = c(0, max(damo_med$y)*1.3)
      )
# banda do bootstrapping
abline(v=boot_med, col=paste(friendlycolor(24),"11",sep=""))
lines(damo_med, col = friendlycolor(19), lwd=3, type = "l")

abline(v=mean_amo, lwd=2, lty=3, col=friendlycolor(19))
sd_epmamostral <- sd(amo_med)
minx <- mean_amo-5*sd_epmamostral
maxx <- mean_amo+5*sd_epmamostral
byx <- (maxx-minx)/100
x_normal <- seq(from=minx, to=maxx, by=byx)
y_normal <- dnorm(x_normal, mean=mean_amo, sd=sd_epmamostral)
lines(x_normal,y_normal, lwd=2, lty=3, col = friendlycolor(19))
cat ("\nEPM por amostragens a partir da populacao:\n")
cat ("\tmedia das medias amostrais:",mean_amo,"\n")
cat ("\tEPM (desvio-padrao das medias amostrais):",sd_epmamostral,"\n")

# apresenta o EPM obtido por bootstrapping
dboot_med <- density(boot_med)
lines (dboot_med,
      col = friendlycolor(15),
      lwd=3, type = "l")
abline(v=mean_boot, lwd=2, lty=3, col=friendlycolor(15))
sd_epmboot <- sd(boot_med)
minx <- mean_boot-5*sd_epmboot
maxx <- mean_boot+5*sd_epmboot
byx <- (maxx-minx)/100
x_normal <- seq(from=minx, to=maxx, by=byx)
y_normal <- dnorm(x_normal, mean=mean_boot, sd=sd_epmboot)
lines(x_normal,y_normal, lwd=2, lty=3, col = friendlycolor(15))
icx <- quantile (boot_med, probs=c(0.025,0.975))
icy <- rep(max(damo_med$y)*1.3,3)
icy <- icy * c(0.95,0.9,0.85)
lines(c(icx[1],icx[1],icx[1],icx[2],icx[2],icx[2]), 
      c(icy[1],icy[3],icy[2],icy[2],icy[1],icy[3]),
      lwd=3, col = friendlycolor(15))
points(mean_boot, icy[2], pch=21, bg = friendlycolor(45), col = friendlycolor(15), cex=2)
points(mean_pop, icy[2], pch=21, bg = friendlycolor(19), col = friendlycolor(19), cex=2)
legend("topright",
       c("Dist. sampling", 
         "Normal sampling",
         "Dist. bootstrapping",
         "Normal bootstrapping",
         "Media populacao",
         "Media bootstrapping"
       ), 
       col=c(
         friendlycolor(19),
         friendlycolor(19),
         friendlycolor(15),
         friendlycolor(15),
         friendlycolor(19),
         friendlycolor(15)
       ),
       pt.bg=c(NA,NA,NA,NA,friendlycolor(19),friendlycolor(45)),
       lwd=c(3,2,3,2,NA,NA), 
       lty=c(1,3,1,3,NA,NA), 
       pch=c(NA,NA,NA,NA,21,21),
       box.lwd=0, bg="transparent",
       cex=0.8)  

txt <- c()
txt <- c(txt,paste("Amostra Unica e Bootstrapping"))
txt <- c(txt,paste(" "))
txt <- c(txt,paste("Amostra com n =",n))
txt <- c(txt,paste("  media amostral:",round(mean_amouni,3)))
txt <- c(txt,paste("  d.p. amostral:",round(sd_amouni,3)))
txt <- c(txt,paste(" "))
txt <- c(txt,paste("Reamostras:",B,"com n =",n))
txt <- c(txt,paste("  media das medias amostrais:",round(mean_boot,3)))
txt <- c(txt,paste("  media dos d.p. amostrais:",round(sd_boot,3)))
txt <- c(txt,paste(" "))
txt <- c(txt,paste("EPM por bootstrapping a partir da amostra:"))
icx <- round(icx,3)
txt <- c(txt,paste("  media das medias amostrais:",round(mean_boot,3),"[",icx[1],",",icx[2],"]"))
txt <- c(txt,paste("  EPM (desvio-padrao das medias amostrais):",round(sd_epmboot,3)))
txt <- c(txt,paste(" "))
txt <- c(txt,paste(" "))
txt <- c(txt,paste("Populacao (QUE NUNCA VIMOS):"))
txt <- c(txt,paste("  media populacional:",round(mean_pop,3)))
txt <- c(txt,paste("  d.p. populacional:",round(sd_pop,3)))
plot(NA,NA,xlim=c(0,100),ylim=c(0,100),xlab=NA,ylab=NA,axes = FALSE)
txt_col <- 0
txt_lin <- 100
txt_inc <- 6
# titulo
text(txt_col,txt_lin,txt[1],pos=4, cex=f_cex*1.5); txt_lin <- txt_lin-txt_inc;
# texto
for (t in 2:length(txt))
{
  text(txt_col,txt_lin,txt[t],pos=4, cex=f_cex*1); txt_lin <- txt_lin-txt_inc;
}

# fim
cat("\nDemonstracao encerrada\n")

if (!is.na(filepdf)) 
{
  dev.off()
}