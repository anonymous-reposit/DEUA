clear all;
clc;


load('EUA_Req_Position_ori.mat');
load('EUA_Req_Time.mat');
N = length(time);
xs = max(UPosition(:,1));
ys = max(UPosition(:,2));
scale = 100;
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

% 如何生成一些新的请求？
rule = [];
acc = 0;
tot = sum(sum(z));
for i=1:xm
    for j=1:ym
        if z(i, j) ~= 0
            per = z(i, j)/tot;
            rule(end+1, :) = [acc+per, i, j];
            acc = acc + per;
        end
    end
end

UPosition = [];
for i=1:N
    r = rand();
    for i=1:length(rule)
        if r < rule(i,1)
            xind = rule(i,2);
            yind = rule(i,3);
            % z(xind,yind) = z(xind,yind) + 1;
            x = rand()*scale + (xind-1)*scale;
            y = rand()*scale + (yind-1)*scale;
            UPosition(end+1, :) = [x, y];
            break;
        end
    end
end

save('EUA_Req_Position.mat', 'UPosition');

% surf(x, y, z);
% contourf(x, y, z);
% colorbar

