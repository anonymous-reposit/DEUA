clear all;
clc;

load('Telcom_BaseStations.mat');

r = 500;

max(BSPosition(:, 1))
max(BSPosition(:, 2))
% 0.54147347
% 0.54134539
% max x value = 7522.46999999954
% max y value = 4072.25699999967

figure();
for i=1:length(BSPosition)
    x = BSPosition(i,1);
    y = BSPosition(i,2);
  % plot(x, y, '.')  
  circle(x, y, r);
  hold on
end
title('Fixed base station location');
xlabel('meter');
ylabel('meter');
xlim([0 7600]);
ylim([0 4100]);

max(BSPosition(:,1))
max(BSPosition(:,2))






