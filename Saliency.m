function [S_r] = Saliency(Img, r)
patchSize = round(r*[7 7]);
channels = size(Img, 3);
ROW = ceil(size(Img,1)/ patchSize(1));
COL = ceil(size(Img,2)/ patchSize(2));                % 得到每一行Patch的个数
SIZE = ROW*COL;
K = 65;                                                  % K 个最相近的

Patch(:,:,1) = im2col(Img(:,:,1), patchSize, 'distinct');
Patch(:,:,2) = im2col(Img(:,:,2), patchSize, 'distinct');
Patch(:,:,3) = im2col(Img(:,:,3), patchSize, 'distinct');

% Init Size
d_color = zeros(SIZE, SIZE, 3);
d_posi = zeros(SIZE, SIZE, 3);
d = zeros(SIZE, SIZE);
S_r = zeros(SIZE,1);

for c = 1:channels
    for i = 1:SIZE
        for j = 1:SIZE
            d_color(i,j,c) = sum(abs(Patch(:, i, c) - Patch(:, j, c)))/size(Patch,1);
            d_posi(i,j,c) = sqrt((floor(i/COL) - floor(j/COL)).^2+(mod(i,COL) - mod(j,COL)).^2);  % 计算列数和行数差
        end
    end
    d_color(:,:,c) = d_color(:,:,c) ./ max(max(d_color(:,:,c)));
    d_posi(:,:,c) = d_posi(:,:,c) ./ max(ROW,COL);
    d = d + d_color(:,:,c) ./ (1.0 + 3.0 * d_posi(:,:,c));
end

% 得到最近K个Patch
for i = 1:SIZE
    d_sort = sort(d(i,:));
    S_r(i) = 1- exp((-1/K)*sum(d_sort(1:K)));
end
S_r = reshape(S_r,ROW,COL);
S_r = imresize(S_r,[size(Img,1) size(Img,2)]);