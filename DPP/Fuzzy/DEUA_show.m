clear all;
clc;

dxp_fis = newfis('fuzz_EUA');

% x, AVG
dxp_fis = addvar(dxp_fis, 'input', 'mean value of resource utilization rate X',  [0, 1]);              
dxp_fis = addmf(dxp_fis,  'input', 1,'LA', 'zmf', [0.1, 0.2]);        % utilization rate low
dxp_fis = addmf(dxp_fis,  'input', 1,'MA', 'gbellmf', [0.1, 2, 0.3]); % utilization rate mid
dxp_fis = addmf(dxp_fis,  'input', 1,'HA', 'smf', [0.4, 0.8]);     % utilization rate high

% y, STD
dxp_fis=addvar(dxp_fis,'input', 'std of resource utilization rate y',[0, 1]);               
dxp_fis=addmf(dxp_fis,'input',2,'LS','zmf',[0.05, 0.1]);     % STD low 
dxp_fis=addmf(dxp_fis,'input',2,'MS','gbellmf',[0.1, 4, 0.2]);   % STD mid
dxp_fis=addmf(dxp_fis,'input',2,'HS','smf',[0.2, 0.4]);   % STD high
 
% z, Beta
dxp_fis=addvar(dxp_fis,'output',  'weight value beta',[0, 1]);               
dxp_fis=addmf(dxp_fis,'output',1, 'VL','trimf',[0, 0, 0.1]);      % very low
dxp_fis=addmf(dxp_fis,'output',1, 'L','trimf', [0, 0.2, 0.4]);    % low
dxp_fis=addmf(dxp_fis,'output',1, 'M','trimf', [0.2, 0.4, 0.6]);  % medium
dxp_fis=addmf(dxp_fis,'output',1, 'H','trimf', [0.4, 0.6, 0.8]);  % high
dxp_fis=addmf(dxp_fis,'output',1, 'VH','trimf',[0.6, 0.8, 1]);    % very high
dxp_fis=addmf(dxp_fis,'output',1, 'HH','trimf',[0.8, 1, 1]);      % extreme high

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
ruleview(dxp_fis);  