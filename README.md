Mulhauser Rémy
Wolkowicz Michel

Dans le fichier test1.m nous avons rajouté une ligne de code : " scores = cell2mat(scores); "
Celle-ci à pour but de convertir la variable score en format de matrice et non de cellule comme elle l'est actuellement.

Sans cette ligne de code, le fichier test1.m génère une erreur suite à un mauvais format pour la fonction "frpintf" et "sort". ("Error using fprintf. Function is not defined for 'cell' inputs.")

De cette façon le programme fonctionne correctement et retourne une note de 18.

