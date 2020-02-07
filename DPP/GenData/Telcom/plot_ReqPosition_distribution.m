clear all;
clc;

load('Telcom_Requests.mat');
UPosition = [];
UPosition(:, 1) = x;
UPosition(:, 2) = y;
xs = max(UPosition(:,1));
ys = max(UPosition(:,2));
scale = 400;
xm = ceil(xs / scale);
ym = ceil(ys / scale);


% max x value = 1947.8367956637    2000 / 50 = 40
% max y value = 1045.83633704022   1050 / 50 = 21

x = zeros(xm, ym);
y = zeros(xm, ym);
z = zeros(xm, ym);

for i=1:ym
    x(:, i) = [1:xm];
end

for i=1:xm
    y(i, :) = [1:ym];
end

for i=1:length(UPosition)
    xind = ceil(UPosition(i,1) / scale);
    yind = ceil(UPosition(i,2) / scale);
    z(xind, yind) = z(xind, yind) + 1;
end

surf(x, y, z);
contourf(x, y, z);
colorbar

% 如何生成一些新的请求？
