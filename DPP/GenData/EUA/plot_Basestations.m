clear all;
clc;

load('EUA_BaseStations.mat');

r = 200;

% max x value = 1941.40981732591
% max y value = 1051.30510285845

figure();
set(gcf, 'Position', [200, 200, 970.7, 525.65]);
for i=1:length(BSPosition)
    x = BSPosition(i,1);
    y = BSPosition(i,2);
  % plot(x, y, '.')  
  circle(x, y, r)
  hold on
end
title('Fixed base station location');
xlabel('meter');
ylabel('meter');
xlim([0 1950]);
ylim([0 1055]);

max(BSPosition(:,1))
max(BSPosition(:,2))






