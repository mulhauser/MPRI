function [va] = seance1(fenetre, tfenetre, nbcoef) 
% dir = './fichiers_wav/';
% droite = 'adroite1.wav';
% 
% wav_file = strcat(dir,droite);
% w = audioread(wav_file)';
% signal = w(1001:1480);
%affichage d'une fenetre du signal de base
%plot(signal);

%on multiplie le signal obtenu avec la fenetre de hamming
ham = hamming(tfenetre);
s = ham' .* fenetre; % le ' est pour inverse le signal 
%plot(s); % affichage 

%transformee de fourier de notre signal
four = fft(s);
%calcul de sa valeur absolue
absolute = abs(four);
%log de ce signal
logsig = log(absolute);
%plot(logsig);

%on reapplique le fft sur ce signal
ffsig = real(fft(logsig)); % on prend la partie reel du signal
%plot(ffsig);

%applique filtre passe bas
ffspecs = ffsig;
ffspecs(nbcoef:length(ffsig)-nbcoef-1) = ffsig(nbcoef:length(ffsig)-nbcoef-1) .* 0;
%plot(ffspecs);

%on re applique la transfo inverse de fourier pour voir les formants(mais
%pas a mettre dans l'algo la prog dyn s'arrete avant)
%iff = real(ifft(ffspecs));
%plot(iff);

%affichage du vecteur accoustique
va = ffspecs(1:nbcoef);

end

