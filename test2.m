row = size(S,1);
col = size(S,2);
mask =im2bw(S,0.5);
imshow(mask);
[rr,cc] = find(mask == 1);
num = size(rr,1);
for i = 1:row
    for j = 1:col
        if mask(i,j) > 0.6
            foci(i,j) = S(i,j);
        else
            % 取得最大值
            d_min = inf;
            for i_a = 1: num
                d_temp = (abs(i-rr(i_a)).^2 + abs(j-cc(i_a)).^2)/max(col,row).^2*50;
                d_min = min(d_min, d_temp);
            end
            foci(i,j) = S(i,j)*max(0,1- d_min);
        end
    end
end