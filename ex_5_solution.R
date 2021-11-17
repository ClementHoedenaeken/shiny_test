library(data.table)

# Charger le tableau mtcars dans la variable voitures (sous forme de data.table)
voitures <- as.data.table(mtcars)

# Structure du tableau
str(voitures)

# Contenu du tableau (aide intégrée à R, fonctionne pour toutes les 
# fonctions qui viennent de packages)
?mtcars

# Sélection de lignes (voitures 6 cylindres)
voitures[cyl==6,]

# Calcul sur des colonnes (consommation moyenne des voitures)
voitures[, mean(mpg)]

# Ajout d'une nouvelle colonne (conversion l/100 km )
# 1 gallon = 3.79 l
# 1 mile = 1.60934 km
voitures[,conso:=3.79/(mpg*1.60934)*100]
# Remarquez que l'on modifie dynamiquement le tableau plutôt 
# que de copier-coller toutes les valeurs

# Calculs par groupes via le 3ème élément de la synthaxe : by
# Calcul de la consommation moyenne des voitures par nombre de cylindres
voitures[,mean(conso),by=.(cyl)]
# Conclusion : Les voitures ayant un plus grand nombre de cylindres consomment plus. 

# Les 3 composantes de la syntaxe data.table
# Consommation moyenne par nombre de cylindres des voitures ayant une transmission automatique
voitures[am==0,mean(conso),by=.(cyl)]

# Meilleure visualisation en enchainant par une mise en ordre selon le nombre de cylindres
voitures[am==0,mean(conso),by=.(cyl)][order(cyl)]

# Charger le fichier altcrime
altcrime <- fread("atlcrime.csv")

# Comparatif temps d'importation du fichier
#Méthode classique
system.time(
  altcrime_classic <- read.csv("atlcrime.csv")
)
#Méthode utilisant fread (fonction du package data.table)
system.time(
  altcrime_rapid <- fread("atlcrime.csv")
)

# Nombre de crime par quartier
R1 <- altcrime[,.N,by=.(neighborhood)]

# Nombre de vols de voiture par quartier
R2 <- altcrime[crime=="AUTO THEFT",.N,by=.(neighborhood)]

# Crime le plus probable dans
R3 <- altcrime[neighborhood=="Campbellton Road",.N,by=.(crime)]
