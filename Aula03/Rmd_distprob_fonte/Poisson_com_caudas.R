# Distribuicao de Poisson

# altere o que deseja
lambda <- 2.75
max_plotar <- 10 # valor maximo para plotar (Poisson vai a + infinito)
cauda <- 3 # a partir de onde hachurar e calcular p da area
cor = "#1965B0" # RGB

hachura <- 500/max_plotar
if (hachura < 10) {hachura <- 10}
if (hachura > 35) {hachura <- 35}

# calculo
probs <- dpois(0:max_plotar,lambda)
eventos <- 0:max_plotar
cor_transparencia <- paste(cor,"88",sep="")

cat("\nDistribuicao de Poisson\n")

prob_acm <- 0;
prob_esq <- 0;
cat ("Evento\tProbabilidade\tAcumulada\n")
for (i in 1:(max_plotar+1))
{
  prob_acm <- prob_acm+probs[i]
  cat (eventos[i],"\t",probs[i],"\t",prob_acm,"\n")
  if (eventos[i] < cauda)
  {
    prob_esq <- prob_esq+probs[i] 
  }
}
prob_dir <- 1-prob_esq
cat ("etc...\n")

plot (eventos, probs, main="Poisson", 
      xlab="Eventos", ylab="Probabilidade",
      lwd=3, col=cor, type = "h")
points(eventos, probs, col=cor, bg=cor, pch=21)
# cauda direita
lines (eventos[eventos>=cauda], probs[eventos>=cauda], 
       col=paste(cor,"88",sep=""), lwd=hachura, type="h")

cat("\ncauda eventos >=",cauda,", p =",prob_dir)
cat("\n")

# Cores adequadas para daltonicos
# Silveira's implemented

# violet
# [0] = "#882E72"; # violeta escuro
# [1] = "#994F88"; # violeta 5
# [2] = "#AA6F9E"; # violeta 4
# [3] = "#BA8DB4"; # violeta 3
# [4] = "#CAACCB"; # violeta 2
# [5] = "#D9CCE3"; # violeta claro

# blue
# [6] = "#0d5092"; # azul naval
# [7] = "#1965B0"; # azul cobalto
# [8] = "#437DBF"; # azul 2
# [9] = "#6195CF"; # azul 3
# [10] = "#7BAFDE"; # azul celeste
# [11] = "#a0d8d8"; # azul claro

# green
# [12] = "#507052"; # verde musgo
# [13] = "#26a169"; # verde médio
# [14] = "#4EB265"; # verde folha
# [15] = "#90C987"; # verde claro 1
# [16] = "#a6da9a"; # verde claro 2
# [17] = "#CAE0AB"; # verde claro 3

# orange
# [18] = "#ac4d12"; # ocre
# [19] = "#E65518"; # laranja escuro
# [20] = "#EE8026"; # laranja 3
# [21] = "#F4A736"; # laranja 2
# [22] = "#F7CB45"; # laranja claro
# [23] = "#F7F056"; # amarelo

# red
# [24] = "#42150A"; # marrom escuro
# [25] = "#72190E"; # marrom médio
# [26] = "#A5170E"; # marrom claro
# [27] = "#a30b1b"; # bordô
# [28] = "#a3261b"; # terra
# [29] = "#f43328"; # tijolo

# gray
# [30] = "#111111"; # cinza 1
# [31] = "#222222"; # cinza 2
# [32] = "#333333"; # cinza 3
# [33] = "#444444"; # cinza 4
# [34] = "#555555"; # cinza 5
# [35] = "#666666"; # cinza 6
# [36] = "#777777"; # cinza 7
# [37] = "#888888"; # cinza 8
# [38] = "#999999"; # cinza 9
# [39] = "#aaaaaa"; # cinza 10
# [40] = "#bbbbbb"; # cinza 11
# [41] = "#cccccc"; # cinza 12
# [42] = "#dddddd"; # cinza 13
# [43] = "#eeeeee"; # cinza 14
# [44] = "#000000"; # preto
# [45] = "#ffffff"; # branco

