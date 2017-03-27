function [scores, noms] = compareBase(signal, dir)
noms{1} = 'agauche1.wav';
noms{2} = 'adroite1.wav';
noms{3} = 'avance1.wav';
noms{4} = 'recule1.wav';
noms{5} = 'enhaut1.wav';
noms{6} = 'enbas1.wav';
for i = 1:6
    wav_file = strcat(dir,noms{i});
    w = audioread(wav_file)';
    [scores{i},dyn] = calculScore(w, signal);
    l = longueurChemin(dyn);
    scores{i} = scores{i}/l;
    fprintf('%s:\t%f(%d)\n',noms{i},scores{i},l);

    
end
end