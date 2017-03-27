function c = cceptraux( signal, debut, tfenetre, nbcoeff )
% Recuperation du troncon du signal
% de taille tfenetre et commençant a debut
x = ...
% Ponderation par la fct de Hamming
% afin d'eviter les effets de Gibbs 
y = hamming(x);
% Calcul du cepstre
z = cepstre(y);
% Recuperation des nbcoeff coefficients de z
% dont la partie imaginaire est nulle.
% 
c = ...
end

