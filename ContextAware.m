clear
clc
%img = imread('1.jpg');
%img = imread('2.jpg');
img = imread('bird.jpg');
%---------------------------------------%
row = size(img, 1);
col = size(img, 2);
img = imresize(img,[round(250/col*row) 250]);
img = im2double(rgb2lab(img));
%---------------------------------------%
tic;
S1 = Saliency(img, 1);
S2 = Saliency(img, 0.8);
S3 = Saliency(img, 0.5);
S = (S1 + S2 + S3);

figure
subplot(1,2,1);
imshow(lab2rgb(img));
subplot(1,2,2);
imshow(S);
toc;
%S2 = Saliency(img, 2);
%S3 = Saliency(img, 3);

%d_posi = norm(d_posi)
%PatchSize = 
%Dcolo
