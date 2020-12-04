clear variables;
close all;

% Filename of the image to load
ImToUse = 'lena.gif';
%Number of bins of the hist
N = 31; 

%Parameters of the liearisation
a = 1;
b = -1;
c = 1;

%Read the image
Im = double(imread(ImToUse));
I_dec = pred(Im, a, b, c);

%Size of the the image
s = size(Im);

%Get histograms
[hInit, vals] = hist(reshape(Im, [s(2)*s(1),1]), 0:31);
[hDec, vals_dec] = hist(reshape(I_dec, [s(2)*s(1),1]), -31:31);

%Get correlation coefficient
corh = corrcoef(Im);
corv = corrcoef(Im');

corh_dec = corrcoef(I_dec);
corv_dec = corrcoef(I_dec');

%Get the huffman code and dictionnary
[I_C, dictionnaire] = codage(I_dec);

I_decode=decodage(I_C,dictionnaire,s(1),s(2));

I_R = INVpred(I_decode, a, b, c);


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


%Affichage des coefficients de corrélation
figure(2)
subplot(221)
plot(corh(1,1:10))
title 'coefficient correlation horizontal pour image origine'
subplot(222)
plot(corv(1,1:10))
title 'coefficient correlation vertical pour image origine'
subplot(223)
plot(corh_dec(1,1:10))
title 'coefficient correlation horizontal pour image decorrelee'
subplot(224)
plot(corv_dec(1,1:10))
title 'coefficient correlation vertical pour image decorrelee'


%Visualisation of the decoding
figure(3)
subplot(231)
imshow(Im, [])
title 'Image origine'
colorbar
subplot(231)
imshow(I_R, [])
title 'Image reconstruite'
colorbar
subplot(225)
imshow(Im - I_R, [])
title(['Difference entre les deux images \n min = ', min(min(Im - I_R)), '\n max = ', max(max(Im - I_R))])
colorbar
subplot(234)
imshow(I_dec, [])
title 'Image decorrelee'
colorbar
subplot(225)
imshow(I_decode, [])
title 'Image decodee'
colorbar
subplot(225)
imshow(I_decode - I_dec, [])
title(['Difference entre les deux images \n min = ', min(min(I_decode - I_dec)), '\n max = ', max(max(I_decode - I_dec))])
colorbar





