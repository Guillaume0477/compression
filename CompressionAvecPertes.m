% Filename of the image to load
ImToUse = "lena.gif";

%Read the image
Im = imread(ImToUse);

figure(1)
imshow(Im, [0,31])