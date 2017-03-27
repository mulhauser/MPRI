function [score, dyn] = calculScore(ref, test)
mref = mceptraux(ref, 480, 160, 5);
mtest = mceptraux(test, 480, 160, 5);
% remplissage de la matrice dist

lMVA = length(mref);
lMVA2 = length(mtest);
distEucli = [];
for a = 1: 1 : lMVA
    for b = 1 : 1 : lMVA2
        distEucli(a,b) = sqrt( ((mref(a,1)- mtest(b,1)).^2) + ((mref(a,2)- mtest(b,2)).^2) + ((mref(a,3)- mtest(b,3)).^2) + ((mref(a,4)- mtest(b,4)).^2) + ((mref(a,5)- mtest(b,5)).^2));
        %il faut faire une boucle si on change le nbcoef ici on a 5
        %for i = 1 : 1 : nbcoef
        %distEucli[b,a] = abs(ones(lMVA2,1)*MVA - MVA2.*ones(1,lMVA));
    end
end

% calcul de la distance

%algo Bellman
dyn = [];
%on affecte dans une 1er etape tous les "sommets" a  un coef infini (choix
%de codage -1)
for r = 1 : 1 : lMVA
    for s = 1 : 1 : lMVA2
        dyn(r,s) = -1;
    end
end
dyn(1,1) = 0;

distance = [];

for k = 1 : 1 : lMVA
    for l = 1 : 1 : lMVA2
        if k > 1 && l > 1
            val1 = dyn(k-1,l-1);
            val2 = dyn(k-1,l);
            val3 = dyn(k,l-1);
            mini = min(val1,min(val2,val3));
            if mini == val1
                dyn(k,l) = val1 + distEucli(k-1,l-1);
            elseif mini == val2
                dyn(k,l) = val2 + distEucli(k-1,l);
            elseif mini == val3
                dyn(k,l) = val3 + distEucli(k,l-1);
            end
        elseif k > 1
            dyn(k,l) = distEucli(k-1,l) + dyn(k-1,l);
        elseif l > 1
            dyn(k,l) = distEucli(k,l-1) + dyn(k,l-1);
        %else
        %    cout(k,l) = distEucli(k,l);
        end
    end
end

% position intiale pour le calcul du score final

score = dyn(size(mref,1),size(mtest,1));
%score = dyn(1,1);
end
