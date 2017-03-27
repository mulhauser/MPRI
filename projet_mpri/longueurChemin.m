function l = longueurChemin(dyn)
% Calcul de la longueur du chemin minimal
% menant de la position (m,n) a la position (1,1)
%
% m et n sont le nbres de vecteurs cepstraux caracterisant
% les mots de ref et de test respectivement.

[k, l] = size(dyn);
% l = 1;
% while r~=1 || c~=1
% end

fin = 1;
long = 0;
chaine = [];


i = 1;
while k~=1 || l~=1
    val10 = realmax;
    val20 = realmax;
    val30 = realmax;
    if k == 1 && l > 1
        val30 = dyn(k,l-1);
    elseif k > 1 && l > 1
        val10 = dyn(k-1,l-1);
        val20 = dyn(k-1,l);
        val30 = dyn(k,l-1);
    elseif k > 1 && l == 1
        val20 = dyn(k-1,l);
    end    
    mini = min(val10,min(val20,val30));
    if mini == val10
        chaine(i,1) = val10;
        k = k-1;
        l = l-1;
        chaine(i,2) = k;
        chaine(i,3) = l;
        i = i+1;
    elseif mini == val20
        chaine(i,1) = val20;
        k = k-1;
        chaine(i,2) = k;
        chaine(i,3) = l;
        i = i+1;
    elseif mini == val30
        chaine(i,1) = val30;
        l = l-1;
        chaine(i,2) = k;
        chaine(i,3) = l;
        i = i+1;
    end
    
end

l = size(chaine,1);

end
