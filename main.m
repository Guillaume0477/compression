clear variables;
close all;

% Filename of the image to load
%ImToUse = 'Lena.gif';
ImToUse = 'Mandrill.gif';
%Number of bins of the hist
N = 31; 

%Parameters of the liearisation
a = 1;
b = -1;
c = 1;

%Read the image
Im_int = imread(ImToUse);
Im = double(Im_int);

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compression sans pertes %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%entropie
ent_sans_perte = entropy(I_dec)




%Get the huffman code and dictionnary
[I_C, dictionnaire] = codage(I_dec);



%Decode
I_decode=decodage(I_C,dictionnaire,s(1),s(2));
%Reconstruct the image
I_R = INVpred(I_decode, a, b, c);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Visualisation de la compression sans pertes %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
subplot(232)
imshow(I_R, [])
title 'Image reconstruite'
colorbar
subplot(233)
imshow(Im - I_R, [])
title(['Difference entre les deux images : min = ', num2str(min(min(Im - I_R))), ': max = ', num2str(max(max(Im - I_R)))])
colorbar
subplot(234)
imshow(I_dec, [])
title 'Image decorrelee'
colorbar
subplot(235)
imshow(I_decode, [])
title 'Image decodee'
colorbar
subplot(236)
imshow(I_decode - I_dec, [])
title(['Difference entre les deux images codees : min = ', num2str(min(min(I_decode - I_dec))), ': max = ', num2str(max(max(I_decode - I_dec)))])
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compression avec pertes %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

I_DCT = DCTransf(Im);


%Get histograms
[hInit, vals] = hist(reshape(Im, [s(2)*s(1),1]), 0:31);
[hDCT, vals_DCT] = hist(reshape(I_DCT, [s(2)*s(1),1]),2*255);

%Get correlation coefficient
corh = corrcoef(Im);
corv = corrcoef(Im');

corh_DCT = corrcoef(I_DCT);
corv_DCT = corrcoef(I_DCT');


%entropie
entropie_DCT_avant_quant = entropy(I_DCT)

I_Q = Quantif(I_DCT);

entropie_DCT_apres_quant = entropy(I_Q)

[hQ, vals_Q] = hist(reshape(I_Q, [s(2)*s(1),1]),2*255);
%[hQ, vals_Q] = hist(reshape(I_Q(1:8,1:8), [8*8,1]), -lim:lim);

[I_C,dico] = codage(I_Q);
I_Decode = decodage(I_C,dico,s(1),s(2));
I_Rec = INVDCTransf(I_Decode);


%PSNR


mse_DCT = mean(mean((I_DCT - I_Q).^2)) 
PSNR_DCT = 10*log10((255^2)/mean(mean((Im - I_Rec).^2)))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Visualisation compression avec pertes %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(4)
subplot(131)
imshow(Im, [])
title 'Image origine'
subplot(132)
imshow(log(abs(I_DCT)), [-5,5])
title 'Image decorrelee DCT'
subplot(133)
imshow(log(abs(I_Q)), [-5,5])
title 'Image decorrelee DCT quantifié'



%Visualisation
figure(5)
subplot(221)
imshow(Im, [])
title 'Image origine'
colorbar
subplot(222)
imshow(I_DCT, [])
title 'Image decorrelee DCT quantifié'
colorbar
subplot(223)
bar(vals_Q, log(hQ))
%bar(vals_Q, hQ)
title (['histogramme decorrele DCT quantifié : min = ', num2str(min(min(vals_Q))), ': max = ', num2str(max(max(vals_Q)))])
subplot(224)
bar(vals_DCT, log(hDCT))
%bar(vals_DCT, hDCT)
title 'histogramme decorrele DCT'


%Affichage des coefficients de corrÃ©lation
figure(6)
subplot(221)
plot(corh(1,1:8))
title 'coefficient correlation horizontal pour image origine'
subplot(222)
plot(corv(1,1:8))
title 'coefficient correlation vertical pour image origine'
subplot(223)
plot(corh_DCT(1,1:8))
title 'coefficient correlation horizontal pour image decorrelee DCT'
subplot(224)
plot(corv_DCT(1,1:8))
title 'coefficient correlation vertical pour image decorrelee DCT'






figure(7)
subplot(231)
imshow(Im, [])
title 'Image origine'
colorbar
subplot(232)
imshow(I_Rec, [])
title (['Image reconstruite : PSNR = ',num2str(PSNR_DCT)])
colorbar
subplot(233)
imshow(Im - I_Rec, [])
title(['Difference entre les deux images : min = ', num2str(min(min(Im - I_Rec))), ': max = ', num2str(max(max(Im - I_Rec)))])
colorbar
subplot(234)
imshow(I_Q, [])
title 'Image decorrelee'
colorbar
subplot(235)
imshow(I_Decode, [])
title 'Image decodee'
colorbar
subplot(236)
imshow(I_Decode-I_Q, [])
title(['Difference entre les deux images codees : min = ', num2str(min(min(I_Decode - I_Q))), ': max = ', num2str(max(max(I_Decode - I_Q)))])
colorbar