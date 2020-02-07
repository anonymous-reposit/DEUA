clear all;
clc;

figure();
set(gcf,'Position',[400,100,510,380]);

subplot(2,1,1);

x = [1:13] .*500 + 1500;

UC_input     = importdata('../../Python/DEUA/OutPut/EUA/UC.txt');
LD_input     = importdata('../../Python/DEUA/OutPut/EUA/LD.txt');
FFD_input    = importdata('../../Python/DEUA/OutPut/EUA/FFD.txt');
FUZZY_input  = importdata('../../Python/DEUA/OutPut/EUA/FC.txt');
Random_input = importdata('../../Python/DEUA/OutPut/EUA/Random.txt');
Tre_input    = importdata('../../Python/DEUA/OutPut/EUA/Threshold.txt');

UC_ori     = str2num(UC_input{1});
LD_ori     = str2num(LD_input{1});
FFD_ori    = str2num(FFD_input{1});
FUZZY_ori  = str2num(FUZZY_input{1});
Tr_ori     = str2num(Tre_input{1});
Random_ori = str2num(Random_input{1});

UC     = (1 - UC_ori./x).*100;
LD     = (1 - LD_ori./x).*100;
FFD    = (1 - FFD_ori./x).*100;
FUZZY  = (1 - FUZZY_ori./x).*100;
Tr     = (1 - Tr_ori./x).*100;
Random = (1 - Random_ori./x).*100;

UC_EUA     = mean(UC);
LD_EUA     = mean(LD);
FFD_EUA    = mean(FFD);
FUZZY_EUA  = mean(FUZZY);
Tr_EUA     = mean(Tr);
Random_EUA = mean(Random);


plot(x,UC, '-o', 'LineWidth', 1.5); hold on;
plot(x,LD, '-x', 'LineWidth', 1.5); hold on;
plot(x,FFD,   '-d', 'LineWidth', 1); hold on;
plot(x,Tr,    '-+', 'LineWidth', 1); hold on;
plot(x,Random,'-s','LineWidth', 1); hold on;
plot(x,FUZZY, '-^','LineWidth', 1, 'MarkerFaceColor',[0.3020    0.7490    0.9294]); hold on;
grid on;
set(gca, 'GridAlpha', 0.4);
legend('UC','LB','FFD','TM', 'Random', 'FC','Location', 'SouthWest');
title('EUA dataset');
xlabel('Edge user count in 24 hours');
ylabel('User allocation rate (%)');

subplot(2,1,2);

x = [1:13] .*500 + 5500;

UC_input     = importdata('../../Python/DEUA/OutPut/Telecom/UC.txt');
LD_input     = importdata('../../Python/DEUA/OutPut/Telecom/LD.txt');
FFD_input    = importdata('../../Python/DEUA/OutPut/Telecom/FFD.txt');
FUZZY_input  = importdata('../../Python/DEUA/OutPut/Telecom/FC.txt');
Random_input = importdata('../../Python/DEUA/OutPut/Telecom/Random.txt');
Tre_input    = importdata('../../Python/DEUA/OutPut/Telecom/Threshold.txt');

UC_ori     = str2num(UC_input{1});
LD_ori     = str2num(LD_input{1});
FFD_ori    = str2num(FFD_input{1});
FUZZY_ori  = str2num(FUZZY_input{1});
Tr_ori     = str2num(Tre_input{1});
Random_ori = str2num(Random_input{1});

UC     = (1 - UC_ori./x).*100;
LD     = (1 - LD_ori./x).*100;
FFD    = (1 - FFD_ori./x).*100;
FUZZY  = (1 - FUZZY_ori./x).*100;
Tr     = (1 - Tr_ori./x).*100;
Random = (1 - Random_ori./x).*100;

UC_Telecom     = mean(UC);
LD_Telecom     = mean(LD);
FFD_Telecom    = mean(FFD);
FUZZY_Telecom  = mean(FUZZY);
Tr_Telecom     = mean(Tr);
Random_Telecom = mean(Random);

plot(x,UC, '-o', 'LineWidth', 1.5); hold on;
plot(x,LD, '-x', 'LineWidth', 1.5); hold on;
plot(x,FFD,   '-d', 'LineWidth', 1); hold on;
plot(x,Tr,    '-+', 'LineWidth', 1); hold on;
plot(x,Random,'-s','LineWidth', 1); hold on;
plot(x,FUZZY, '-^','LineWidth', 1, 'MarkerFaceColor',[0.3020    0.7490    0.9294]); hold on;
ylim([95 99]);
grid on;
set(gca, 'GridAlpha', 0.4);
legend('UC','LB','FFD','TM','Random', 'FC','Location', 'SouthWest');
title('Telecom dataset');
xlabel('Edge user count in 24 hours');
ylabel('User allocation rate (%)');



UC_Total     = (UC_EUA + UC_Telecom) / 2;
LD_Total     = (LD_EUA + LD_Telecom) / 2;
FFD_Total    = (FFD_EUA + FFD_Telecom) / 2;
FUZZY_Total  = (FUZZY_EUA + FUZZY_Telecom) / 2;
Tr_Total     = (Tr_EUA + Tr_Telecom) / 2;
Random_Total = (Random_EUA + Random_Telecom) / 2;

FUZZY_Total - UC_Total
FUZZY_Total - LD_Total
FUZZY_Total - FFD_Total
FUZZY_Total - Tr_Total
FUZZY_Total - Random_Total


