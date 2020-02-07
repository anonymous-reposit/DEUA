clear all;
clc;

figure();
set(gcf,'Position',[400,100,520,380]);

alpha = 1;

subplot(2,1,1);

x = [1:13] .*500 + 4500;

UC_input     = importdata('../../Python/DEUA/OutPut/EUA/UC.txt');
LD_input     = importdata('../../Python/DEUA/OutPut/EUA/LD.txt');
FFD_input    = importdata('../../Python/DEUA/OutPut/EUA/FFD.txt');
FUZZY_input  = importdata('../../Python/DEUA/OutPut/EUA/FC.txt');
Random_input = importdata('../../Python/DEUA/OutPut/EUA/Random.txt');
Tre_input    = importdata('../../Python/DEUA/OutPut/EUA/Threshold.txt');

UC_ori     = str2num(UC_input{2});
LD_ori     = str2num(LD_input{2});
FFD_ori    = str2num(FFD_input{2});
FUZZY_ori  = str2num(FUZZY_input{2});
Tr_ori     = str2num(Tre_input{2});
Random_ori = str2num(Random_input{2});

UC = [];
LD = [];
FFD = [];
FUZZY = [];
Tr = [];
Random = [];

for i=1:2:13
    UC(end+1) = UC_ori(i);
    LD(end+1) = LD_ori(i);
    FFD(end+1) = FFD_ori(i);
    FUZZY(end+1) = FUZZY_ori(i);
    Tr(end+1) = Tr_ori(i) * alpha;
    Random(end+1) = Random_ori(i);
end

UC_EUA     = mean(UC);
LD_EUA     = mean(LD);
FFD_EUA    = mean(FFD);
FUZZY_EUA  = mean(FUZZY);
Tr_EUA     = mean(Tr);
Random_EUA = mean(Random);

% plot(x,BFD_1,x,BFD_2,x,FFD,x,FUZZY,x,Random,x,Tr_1,x,Tr_2, 'LineWidth', 2);
d = [UC;LD;FFD;Tr;Random;FUZZY];
bar(d');
grid on;
set(gca, 'GridAlpha', 0.4);
set(gca,'xticklabel',{'2000','3000','4000','5000','6000','7000','8000'})
l = legend('UC','LB','FFD','TM','Random','FC','Location', 'NorthWest');
set(l,'Orientation','horizon')
xlabel('Edge user count in 24 hours');
ylabel('Total Cost (cent)');
title('EUA dataset');
ylim([0 110000]);


subplot(2,1,2);
x = [1:13] .*500 + 4500;
UC_input     = importdata('../../Python/DEUA/OutPut/Telecom/UC.txt');
LD_input     = importdata('../../Python/DEUA/OutPut/Telecom/LD.txt');
FFD_input    = importdata('../../Python/DEUA/OutPut/Telecom/FFD.txt');
FUZZY_input  = importdata('../../Python/DEUA/OutPut/Telecom/FC.txt');
Random_input = importdata('../../Python/DEUA/OutPut/Telecom/Random.txt');
Tre_input    = importdata('../../Python/DEUA/OutPut/Telecom/Threshold.txt');

UC_ori     = str2num(UC_input{2});
LD_ori     = str2num(LD_input{2});
FFD_ori    = str2num(FFD_input{2});
FUZZY_ori  = str2num(FUZZY_input{2});
Tr_ori     = str2num(Tre_input{2});
Random_ori = str2num(Random_input{2});

UC = [];
LD = [];
FFD = [];
FUZZY = [];
Tr = [];
Random = [];

for i=1:2:13
    UC(end+1) = UC_ori(i);
    LD(end+1) = LD_ori(i);
    FFD(end+1) = FFD_ori(i);
    FUZZY(end+1) = FUZZY_ori(i);
    Tr(end+1) = Tr_ori(i) * alpha;
    Random(end+1) = Random_ori(i);
end

UC_Telecom     = mean(UC);
LD_Telecom     = mean(LD);
FFD_Telecom    = mean(FFD);
FUZZY_Telecom  = mean(FUZZY);
Tr_Telecom     = mean(Tr);
Random_Telecom = mean(Random);


% plot(x,BFD_1,x,BFD_2,x,FFD,x,FUZZY,x,Random,x,Tr_1,x,Tr_2, 'LineWidth', 2);
d = [UC;LD;FFD;Tr;Random;FUZZY];
bar(d');
grid on;
% set(gca, 'GridLineStyle', ':');
set(gca, 'GridAlpha', 0.4);
set(gca,'xticklabel',{'6000','7000','8000','9000','10000','11000','12000'})
l = legend('UC','LB','FFD','TM','Random','FC','Location', 'NorthWest');
set(l,'Orientation','horizon')
xlabel('Edge user count in 24 hours');
ylabel('Total Cost (cent)');
title('Telecom dataset');
ylim([0 175000]);


UC_Total     = (UC_EUA + UC_Telecom) / 2;
LD_Total     = (LD_EUA + LD_Telecom) / 2;
FFD_Total    = (FFD_EUA + FFD_Telecom) / 2;
FUZZY_Total  = (FUZZY_EUA + FUZZY_Telecom) / 2;
Tr_Total     = (Tr_EUA + Tr_Telecom) / 2;
Random_Total = (Random_EUA + Random_Telecom) / 2;

(UC_Total - FUZZY_Total) / UC_Total
(LD_Total - FUZZY_Total) / LD_Total
(Tr_Total - FUZZY_Total) / Tr_Total
(FFD_Total - FUZZY_Total) / FFD_Total
(Random_Total - FUZZY_Total) / Random_Total