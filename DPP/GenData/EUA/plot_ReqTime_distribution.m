clear all;
clc;

load('EUA_Req_Time.mat');

figure()
set(gcf,'Position',[400,100,285,156.75]);

time = double(time);
[y,c] = hist(time, 1*24);
x = [0:23];
%  c = uisetcolor([0.6 0.8 1])
% , 'FaceColor',[ 0.309803921568627         0.309803921568627         0.309803921568627])
b = bar(x, y, 0.8);
set(b,'FaceColor',[0.3922 0.6235 0.9882]);

xlabel("Time (o'clock)")
ylabel('User arrival strength')
set(gca,'xtick',[0 3 6 9 12 15 18 21 24]);
xlim([-0.8 24]);
ylim([0 1100]);
grid on;