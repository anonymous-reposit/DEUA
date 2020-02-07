clear all;
clc;

dxp_fis = newfis('fuzz_EUA');

% 增加模糊语言变量x, 即AVG
dxp_fis = addvar(dxp_fis, 'input', '均资源利用率 X',  [0, 1]);              
dxp_fis = addmf(dxp_fis,  'input', 1,'LA', 'zmf', [0.1, 0.2]);     % 增加模糊语言名称，即模糊集合  资源利用率低
dxp_fis = addmf(dxp_fis,  'input', 1,'MA', 'gbellmf', [0.1, 2, 0.3]); % 资源利用率中
dxp_fis = addmf(dxp_fis,  'input', 1,'HA', 'smf', [0.4, 0.8]);     % 资源利用率高

% 增加模糊语言变量y, 即STD
dxp_fis=addvar(dxp_fis,'input', '资源利用率均方差y',[0, 1]);               
dxp_fis=addmf(dxp_fis,'input',2,'LS','zmf',[0.05, 0.1]);     % STD低
dxp_fis=addmf(dxp_fis,'input',2,'MS','gbellmf',[0.1, 4, 0.2]);   % STD中
dxp_fis=addmf(dxp_fis,'input',2,'HS','smf',[0.2, 0.4]);   % STD高
 
% 模糊输出变量z, 即比率Beta
dxp_fis=addvar(dxp_fis,'output',  '权重beta',[0, 1]);               
dxp_fis=addmf(dxp_fis,'output',1, 'VL','trimf',[0, 0, 0.1]);      % 很短
dxp_fis=addmf(dxp_fis,'output',1, 'L','trimf', [0, 0.2, 0.4]);    % 短
dxp_fis=addmf(dxp_fis,'output',1, 'M','trimf', [0.2, 0.4, 0.6]);  % 中等
dxp_fis=addmf(dxp_fis,'output',1, 'H','trimf', [0.4, 0.6, 0.8]);  % 中等
dxp_fis=addmf(dxp_fis,'output',1, 'VH','trimf',[0.6, 0.8, 1]);    % 中等
dxp_fis=addmf(dxp_fis,'output',1, 'HH','trimf',[0.8, 1, 1]);      % 中等
%[输入1条件索引  输入2条件索引 输出1条件索引 1 1] 
% 最后两个分别表示该条规则的权重和个条件的关系
% 1-AND，2-OR
rule=[
          1 1 1 1 1;                    
   		  1 2 1 1 1;
          1 3 2 1 1;          
          2 1 3 1 1;
          2 2 3 1 1;
          2 3 4 1 1;          
          3 1 6 1 1;
          3 2 6 1 1;
          3 3 5 1 1;
];
dxp_fis = addrule(dxp_fis,rule);
% ruleview('洗衣时间');  %动态仿真
ruleview(dxp_fis);  