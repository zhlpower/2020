# CorpoCerebro_RLS_log.R
# (versao nao padronizada, transformacao logaritmica para regressão)

alfa <- 0.05

library(readxl)
library(dplyr)

source("eiras.jitter.R")
source("eiras.friendlycolor.R")
source("eiras.cor.test.boot.R")

col_Corpo <- eiras.friendlycolor(14) # verde
pch_Corpo <- 22
col_Cerebro <- eiras.friendlycolor(39) # cinza
pch_Cerebro <- 21

CorpoCerebro <- read_excel("CorpoCerebro.xlsx")
CorpoCerebro$Corpo_log <- log(CorpoCerebro$Corpo)
CorpoCerebro$Cerebro_log <- log(CorpoCerebro$Cerebro)

# HT x HB
eiras.cor.test.boot (CorpoCerebro$Corpo_log, CorpoCerebro$Cerebro_log,
                     alpha=alfa, B=0, 
                     method="lm",
                     jitter=0,
                     xlab="log[Corpo (kg)]", ylab="log[Cerebro (g)]", 
                     bg=col_Cerebro, col="black", pch=pch_Cerebro)
