clear all
clc

format long g;

load('EUA_Req_Position.mat');
xs = max(UPosition(:,1));
ys = max(UPosition(:,2));
scale = 40;
xm = ceil(xs / scale);
ym = ceil(ys / scale);


% max x value = 1947.8367956637    2000 / 50 = 40
% max y value = 1045.83633704022   1050 / 50 = 21

x = zeros(xm, ym);
y = zeros(xm, ym);
z = zeros(xm, ym);

for i=1:length(UPosition)
    xind = ceil(UPosition(i,1) / scale);
    yind = ceil(UPosition(i,2) / scale);
    z(xind, yind) = z(xind, yind) + 1;
end



% .         经度lo                纬度la
P_0 = [144.9549965367283, -37.82117612446662];   % 左下角基准点
P_1 = [144.9513187173424, -37.81313439053935];   % 左上角基准点
P_2 = [144.9748200238013, -37.81524024624075];   % 右下角基准点


[k1, b1] = getKandB(P_0(1), P_0(2), P_1(1), P_1(2));

xs = P_0(1) - P_1(1);
d  = xs / (ym-1);
bases = [];
bases(end+1, :) = P_1;
for i=1:(ym-1)
    lo = P_1(1) + d*i;
    la = k1*lo+b1;
    bases(end+1, :) = [lo, la];
end

[k2, b2] = getKandB(P_0(1), P_0(2), P_2(1), P_2(2));
xs = P_2(1) - P_0(1);
d  = xs / xm;
dest = [];
for i=1:(ym-1)
    P_0 = bases(i,:);
    b2  = P_0(2) - k2*P_0(1);
    P_2 = [P_0(1)+xs, k2*(P_0(1)+xs)+b2];
    tar = [];
    for j=1:xm
        lo = P_0(1) + d*j;
        la = k2*lo+b2;
        % tar(end+1, :) = [lo, la];
        % dest(end+1, :) = [lo, la];
        fprintf('{"lng":%f,"lat":%f,"count":%.3f}, \n', lo, la, z(j,i))
    end
end

function [k,b] = getKandB(x1, y1, x2, y2)
    k = (y1-y2) / (x1-x2);
    b1 = y1-k*x1;
    b2 = y2-k*x2;
    b = (b1+b2)/2;
end




