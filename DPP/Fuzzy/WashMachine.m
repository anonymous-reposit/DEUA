dxp_fis=newfis('fuzz_wash');
%增加模糊语言变量x
dxp_fis=addvar(dxp_fis,'input','污泥量x',[0,100]);              
dxp_fis=addmf(dxp_fis,'input',1,'SD','trimf',[0,0,50]);     %增加模糊语言名称，即模糊集合  污泥少
dxp_fis=addmf(dxp_fis,'input',1,'MD','trimf',[0,50,100]);   %污泥中
dxp_fis=addmf(dxp_fis,'input',1,'LD','trimf',[50,100,100]); %污泥多
 %增加模糊语言变量y
dxp_fis=addvar(dxp_fis,'input','油脂量y',[0,100]);               
dxp_fis=addmf(dxp_fis,'input',2,'NG','trimf',[0,0,50]);     %无油脂
dxp_fis=addmf(dxp_fis,'input',2,'MG','trimf',[0,50,100]);   %油脂中
dxp_fis=addmf(dxp_fis,'input',2,'LG','trimf',[50,100,100]); %油脂多
 %模糊输出变量z
dxp_fis=addvar(dxp_fis,'output','洗涤时间z',[0,60]);               
dxp_fis=addmf(dxp_fis,'output',1,'VS','trimf',[0,0,10]);    %很短
dxp_fis=addmf(dxp_fis,'output',1,'S','trimf',[0,10,25]);    %短
dxp_fis=addmf(dxp_fis,'output',1,'M','trimf',[10,25,40]);   %中等
dxp_fis=addmf(dxp_fis,'output',1,'L','trimf',[25,40,60]);   %长
dxp_fis=addmf(dxp_fis,'output',1,'VL','trimf',[40,60,60]);  %很长
%[输入1条件索引  输入2条件索引 输出1条件索引 1 1] 
% 最后两个分别表示该条规则的权重和个条件的关系
% 1-AND，2-OR
rule=[
          1 1 1 1 1;                    
   		  1 2 3 1 1;
          1 3 4 1 1;          
          2 1 2 1 1;
          2 2 3 1 1;
          2 3 4 1 1;          
          3 1 3 1 1;
          3 2 4 1 1;
          3 3 5 1 1;
];
dxp_fis = addrule(dxp_fis,rule);
% ruleview('洗衣时间');  %动态仿真
ruleview(dxp_fis);  