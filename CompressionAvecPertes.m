% Filename of the image to load
ImToUse = 'lena.gif';

%Read the image
Im = imread(ImToUse);

figure(1)
imshow(Im, [0,31])

I_dec = pred(Im, 1, -1, 1);
figure(2)
imshow(I_dec, displayrange = [mean(mean(I_dec)) - 0.1, mean(mean(I_dec)) +0.1])