function [chaine] = seance2() 
dir = './fichiers_wav/';
droite = 'adroite1.wav';
droite2 = 'adroite2.wav';

wav_file = strcat(dir,droite);
wav_file2 = strcat(dir,droite2);

w = audioread(wav_file)';
w2 = audioread(wav_file2)';

%longueur du signal
longueurSig = length(w) - 480;
longueurSig2 = length(w2) - 480;

%nb de fenetre qu il nous faut, et on prends un peut plus ( l arrondi sup)
%nbFenetres = longueurSig / 160;
%arrondi = ceil(nbFenetres);

MVA=[];
%on boucle sur le signal et on prends des fenetres de 480 espaces de 160
%on se deplace de 0 a arrondi(fin du signal) en faisant des pas de 160
for c = 1 : 160 : longueurSig
    finInter = c + 480 - 1;
    fenetre = w(c:finInter);
    
    va = seance1(fenetre);
    %remplissage de la matrice en prenant le resultat d'avant a chaque
    %iteration
    MVA = [MVA;va];
   
    %plot(seance1(fenetre));
    
end

%on remplit la 2eme matrice 
MVA2=[];
for c = 1 : 160 : longueurSig2
    finInter = c + 480 - 1;
    fenetre = w2(c:finInter);
    
    va = seance1(fenetre);
    MVA2 = [MVA2;va];

    
end

%inversion des matrices
 MVA = MVA.';
 MVA2 = MVA2.'; 

%disp(MVA);
%disp(MVA2);

%Construction du tableau contenant les distance euclidiennes et calcul de
%ces distances, nb de colonne = au nb de vecteur de test, nb de ligne = nb
%de vecteur de reference
%MVA vecteur reference, MVA2 vecteur test
%On extrait le ieme vecteur acoustique
%MVA(i,:)
%function d=eucldist(v,x,c,M)
%M taille vecteur x, c taille du vecteur v
% v vecteur 1xc et x vecteur 1xM 
%d = abs(ones(M,1)*v-x'*ones(1,c))
% VOIR LA FORMULE





%distance euclidienne entre les vecteurs accoustique

% tableau ou on stock les resultats
lMVA = length(MVA);
lMVA2 = length(MVA2);
distEucli = [];
for a = 1: 1 : lMVA
    for b = 1 : 1 : lMVA2
        %disp(MVA(:,a));
        %disp(MVA(:,b));
        distEucli(a,b) = sqrt( ((MVA(1,a)- MVA2(1,b)).^2) + ((MVA(2,a)- MVA2(2,b)).^2) + ((MVA(3,a)- MVA2(3,b)).^2) + ((MVA(4,a)- MVA2(4,b)).^2) + ((MVA(5,a)- MVA2(5,b)).^2));
       %distEucli[b,a] = abs(ones(lMVA2,1)*MVA - MVA2.*ones(1,lMVA));
    end
end

%disp(distEucli);



%algo Bellman
cout = [];
%on affecte dans une 1er etape tous les "sommets" a  un coef infini (choix
%de codage -1)
for r = 1 : 1 : lMVA
    for s = 1 : 1 : lMVA2
        cout(r,s) = -1;
    end
end
cout(1,1) = 0;

distance = [];

for k = 1 : 1 : lMVA
    for l = 1 : 1 : lMVA2
        if k > 1 && l > 1
            val1 = cout(k-1,l-1);
            val2 = cout(k-1,l);
            val3 = cout(k,l-1);
            mini = min(val1,min(val2,val3));
            if mini == val1
                cout(k,l) = val1 + distEucli(k-1,l-1);
            elseif mini == val2
                cout(k,l) = val2 + distEucli(k-1,l);
            elseif mini == val3
                cout(k,l) = val3 + distEucli(k,l-1);
            end
        elseif k > 1
            cout(k,l) = distEucli(k-1,l) + cout(k-1,l);
        elseif l > 1
            cout(k,l) = distEucli(k,l-1) + cout(k,l-1);
       % else
        %    cout(k,l) = distEucli(k,l);
        end
    end
end

fin = 1;
long = 0;
chaine = [];


i = 1;
while k > 1 && l > 1
    val10 = cout(k-1,l-1);
    val20 = cout(k-1,l);
    val30 = cout(k,l-1);
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
    
    
%     if val == cout(k-1,l-1)
%         chaine = strcat(chaine,'BD;');
%         k = k-1;
%         l = l-1;
%     elseif val == cout(k-1,l)
%         disp('V');
%         chaine = strcat(chaine,'D;');
%         k = k-1;
%     elseif val == cout(k,l-1)
%         disp('V');
%         chaine = strcat(chaine, 'B;');
%         l = l -1;
%     end
%end

%disp(min(min(3,4),5));




end

    
    
    
    
