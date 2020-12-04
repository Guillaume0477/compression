clear variables;
close all;

% Filename of the image to load
ImToUse = 'lena.gif';
%Number of bins of the hist
N = 31; 

%Read the image
Im = double(imread(ImToUse));
I_dec = pred(Im, 1, -1, 1);

%Size of the the image
s = size(Im);

%Get histograms
[hInit, vals] = hist(reshape(Im, [s(2)*s(1),1]), 0:31);
[hDec, vals_dec] = hist(reshape(I_dec, [s(2)*s(1),1]), -31:31);

%Get correlation coefficient
%corh = corrcoef(Im);
%corv = corrcoef(Im');

%corh_dec = corrcoef(I_dec);
%corv_dec = corrcoef(I_dec');

%Get the huffman code and dictionnary
[I_C, dictionnaire] = codage(I_dec);


%Visualisation
figure(1)
subplot(221)
imshow(Im, [])
title 'Image origine'
colorbar
subplot(222)
imshow(I_dec, [])
title 'Image decorrelee'
colorbar
subplot(223)
bar(vals, hInit)
title 'histogramme origine'
subplot(224)
bar(vals_dec, hDec)
title 'histogramme decorrele'


%Affichage des coefficients de corrÃ©lation
figure(2)
subplot(221)
plot(corh(1,1:10))
title 'coefficient corrélation horizontal pour image origine'
subplot(222)
plot(corv(1,1:10))
title 'coefficient corrélation vertical pour image origine'
subplot(223)
plot(corh_dec(1,1:10))
title 'coefficient corrélation horizontal pour image décorrélée'
subplot(224)
plot(corv_dec(1,1:10))
title 'coefficient corrélation vertical pour image décorrélée'






