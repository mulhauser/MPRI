function m = mceptraux(signal, tfenetre, shift, nbcoeff)
% Decoupe le signal en trames
% Calcule les coefficients cepstraux sur chacune d'elles
% Les range dans le tableaux m ayant autant de lignes qu'il y a de trames
% Chaque ligne est un vecteur cepstral et comporte nbcoeff valeur

%longueur du signal
longueurSig = length(signal) - tfenetre;

%nb de fenetre qu il nous faut, et on prends un peut plus ( l arrondi sup)
%nbFenetres = longueurSig / 160;
%arrondi = ceil(nbFenetres);

m=[];
%on boucle sur le signal et on prends des fenetres de 480 espaces de 160
%on se deplace de 0 a arrondi(fin du signal) en faisant des pas de 160
for c = 1 : shift : longueurSig
    finInter = c + tfenetre - 1;
    fenetre = signal(c:finInter);
    
    va = seance1(fenetre,tfenetre,nbcoeff);
    %remplissage de la matrice en prenant le resultat d'avant a chaque
    %iteration
    m = [m;va];
   
    %plot(seance1(fenetre));
    
end

end
