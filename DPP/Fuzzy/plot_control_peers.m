clear all;
clc;

load('strategy.mat');

[d_AVG, d_STD] = size(strategy);

x = zeros(d_AVG, d_STD);
y = zeros(d_AVG, d_STD);
z = strategy;

for i=1:d_STD
    x(:, i) = [1:d_AVG] / 100;
end

for i=1:d_AVG
    y(i, :) = [1:d_STD] / 100;
end

figure();
set(gcf,'Position',[400,100,225,180]);


x = [0:0.1:1];
y1 = [];
y2 = [];
y3 = [];
for i=1:11
    y1(end+1) = 1;
    y2(end+1) = 0;
    if i<4
        y3(end+1) = 0;
    else
        y3(end+1) = 1;
    end
end


subplot(3,1,1);
plot(x,y1, 'linewidth', 1.4);
ylabel('\beta');
% set(get(gca,'ylabel'),'rotation',360);
text(0.01,1.5,'RC')
grid on;

subplot(3,1,2);
plot(x,y2, 'linewidth', 1.4);
ylabel('\beta');
% set(get(gca,'ylabel'),'rotation',360);
text(0.01,0.5,'LD')
grid on;

subplot(3,1,3);
plot(x,y3, 'linewidth', 1.4);
xlabel('\rho');
ylabel('\beta');
% set(get(gca,'ylabel'),'rotation',360);
text(0.01,0.8,'Threshold')
grid on;



