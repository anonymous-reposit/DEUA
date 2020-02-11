clear all;
clc;

dxp_fis = newfis('fuzz_EUA');

% x, AVG
dxp_fis = addvar(dxp_fis, 'input', '均资源利用率 X',  [0, 1]);              
dxp_fis = addmf(dxp_fis,  'input', 1,'LA', 'zmf',     [0, 0.14]);     % 增加模糊语言名称，即模糊集合  资源利用率低
dxp_fis = addmf(dxp_fis,  'input', 1,'MA', 'gaussmf', [0.05, 0.14]); % 资源利用率中
dxp_fis = addmf(dxp_fis,  'input', 1,'HA', 'smf',     [0.14, 0.32]);     % 资源利用率高

% y, STD
dxp_fis=addvar(dxp_fis,'input', '资源利用率均方差y',[0, 1]);               
dxp_fis=addmf(dxp_fis,'input',2,'LS','zmf',     [0, 0.1]);     % STD低
dxp_fis=addmf(dxp_fis,'input',2,'MS','gaussmf', [0.05, 0.1]);   % STD中
dxp_fis=addmf(dxp_fis,'input',2,'HS','smf',     [0.2, 0.5]);   % STD高
 
% z, Beta
dxp_fis=addvar(dxp_fis,'output',  '权重beta',[0, 1]);               
dxp_fis=addmf(dxp_fis,'output',1, 'VL','gaussmf', [0.05, 0.0]);      % 很短
dxp_fis=addmf(dxp_fis,'output',1, 'L', 'gaussmf', [0.05, 0.2]);    % 短
dxp_fis=addmf(dxp_fis,'output',1, 'M', 'gaussmf', [0.05, 0.4]);  % 中等
dxp_fis=addmf(dxp_fis,'output',1, 'H', 'gaussmf', [0.05, 0.7]);  % 中等
dxp_fis=addmf(dxp_fis,'output',1, 'VH','gaussmf', [0.05, 0.8]);    % 中等
dxp_fis=addmf(dxp_fis,'output',1, 'HH','gaussmf', [0.05, 1.0]);      % 中等

rule=[
          1 1 1 1 1;      % VL
   		  1 2 1 1 1;      % VL
          1 3 1 1 1;      % VL        
          2 1 3 1 1;      % M
          2 2 2 1 1;      % L
          2 3 1 1 1;      % VL         
          3 1 6 1 1;      % HH
          3 2 5 1 1;      % VH
          3 3 4 1 1;      % H
];
dxp_fis = addrule(dxp_fis,rule);
ruleview(dxp_fis);  


strategy = [];
options = evalfisOptions;
options.NumSamplePoints = 100;

% i: Resource Utilization Average
% j: Resource Utilization STD
for i=1:100
    for j=1:100
        strategy(i,j) = evalfis(dxp_fis, [i/100; j/100], options);
        strategy(i,j) = strategy(i,j) + 0.02;
    end
end

% save('strategy.mat', 'strategy')

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
set(gcf,'Position',[400,100,550,480]);

surf(x, y, z, 'linewidth', 0.01);
xlabel('\rho');
ylabel('\tau');
zlabel('\beta');
% set(gca,'xtick',[1 3 5 7 9],'xticklabel',{'first','third','five','seven','nine'})
xlim([0 1]);
ylim([0 0.5]);
zlim([0 1]);
set(gca,'xtick',[0 0.2 0.4 0.6 0.8 1.0]);
set(gca,'ytick',[0 0.1 0.2 0.3 0.4 0.5]);
set(gca,'ztick',[0 0.2 0.4 0.6 0.8 1.0]);
colormap default

save('strategy.mat', 'strategy')