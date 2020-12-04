% Filename of the image to load
ImToUse = 'lena.gif';

%Read the image
Im = im2double(imread(ImToUse));

figure(1)
imshow(Im, [])

I_dec = pred(Im, 1, -1, 1);
figure(2)
imshow(I_dec, [])