clear all
clc

% EUA_Basestations_ori.mat (经纬度) => EUA_BaseStations.mat (米)


% 左下角基准点：-37.82117612446662, 144.9549965367283
% 左上角基准点：-37.81313439053935, 144.9513187173424
% 右下角基准点：-37.81524024624075, 144.9748200238013

% 左上: (-37.813134, 144.951319)
% 右下: (-37.815240, 144.974820)

% 验证是否垂直
P_0 = [144.9549965367283, -37.82117612446662];   % 左下角基准点
P_1 = [144.9513187173424, -37.81313439053935];   % 左上角基准点
P_2 = [144.9748200238013, -37.81524024624075];   % 右下角基准点

V_1 = P_1 - P_0;
V_2 = P_2 - P_0;

% 夹角：弧度制,转角度制乘180/pi
% 夹角为 97.9070 度， 需要更改 P_0 点的位置
% acos(dot(V_1, V_2)/(norm(V_1)*norm(V_2))) * 180/pi

% P_0 和 P_1 构成的直线
% [k, b] = getKandB(P_0(1), P_0(2), P_1(1), P_1(2));

% 尝试新点
% x = 144.95618048521;
% y = k * x + b;
% P_0 = [x, y];

% V_1 = P_1 - P_0;
% V_2 = P_2 - P_0;

% 夹角：弧度制,转角度制乘180/pi
% 夹角为 97.9070 度， 需要更改 P_0 点的位置
% acos(dot(V_1, V_2)/(norm(V_1)*norm(V_2))) * 180/pi
% 这个点可以的


[k1, b1] = getKandB(P_0(1), P_0(2), P_1(1), P_1(2));
[k2, b2] = getKandB(P_0(1), P_0(2), P_2(1), P_2(2));
A1 = k1; B1 = -1; C1 = b1;
A2 = k2; B2 = -1; C2 = b2;

load('EUA_Basestations_ori.mat');

xScale = P_2(1) - P_0(1);   % 1880
yScale = P_1(2) - P_0(2);   % 968

BSPosition = [];
for i=1:length(BasestationPosition)
    Px = [BasestationPosition(i, 2), BasestationPosition(i, 1)];
    dx = abs(A1*Px(1) + B1*Px(2) + C1) / sqrt(A1*A1 + B1*B1);
    dy = abs(A2*Px(1) + B2*Px(2) + C2) / sqrt(A2*A2 + B2*B2);
    BSPosition(i, :) = [dx/xScale*1880, dy/yScale*968];
end


figure();
set(gcf, 'Position', [200, 200, 600, 300]);
for i=1:length(BasestationPosition)
  plot(BSPosition(i,1), BSPosition(i,2), '*')  
  hold on
end

max(BSPosition(:, 1))
max(BSPosition(:, 2))


save('EUA_BaseStations', 'BSPosition');


function [k,b] = getKandB(x1, y1, x2, y2)
    k = (y1-y2) / (x1-x2);
    b1 = y1-k*x1;
    b2 = y2-k*x2;
    b = (b1+b2)/2;
end




