clear
clc
%img = imread('3.jpg');
%img = imread('2.jpg');
img = imread('bird.jpg');
%---------------------------------------%
% Init Image Size
row = size(img, 1);
col = size(img, 2);
img = imresize(img,[round(250/col*row) 250]);
img = im2double(rgb2lab(img));
%---------------------------------------%
% Multi-Scale saliency enhancement
tic;
S1 = Saliency(img, 1);
S2 = Saliency(img, 0.8);
S3 = Saliency(img, 0.5);
S4 = Saliency(img, 0.3);
S = S1 + S2 + S3 + S4;
toc;
%---------------------------------------%
%including the immediate context
[foci, mask]= Foci(S);
%---------------------------------------%
% Visualization
subplot(2,2,1);
imshow(lab2rgb(img));

subplot(2,2,2);
imshow(S);

subplot(2,2,3);
imshow(mask);

subplot(2,2,4);
imshow(foci);
%print(gcf,'-dpng','abc.png')
%---------------------------------------%