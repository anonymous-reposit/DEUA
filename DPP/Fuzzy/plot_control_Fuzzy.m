clear all;
clc;

% addpath('./phymhan-matlab-axis-label-alignment-178fcae');

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
set(gcf,'Position',[400,100,440,400]);

surf(x, y, z, 'linewidth', 0.000001);
set(gca, 'GridAlpha', 0.2);

% xlabel('mean resource utilization rate \rho');
% ylabel('standard deviation of resource utilization rates \tau');
zlabel('weight value \beta');
% set(gca,'xtick',[1 3 5 7 9],'xticklabel',{'first','third','five','seven','nine'})
xlim([0 1]);
ylim([0 0.5]);
zlim([0 1]);
set(gca,'xtick',[0 0.2 0.4 0.6 0.8 1.0]);
set(gca,'ytick',[0 0.1 0.2 0.3 0.4 0.5]);
set(gca,'ztick',[0 0.2 0.4 0.6 0.8 1.0]);
colormap default
% shading interp




