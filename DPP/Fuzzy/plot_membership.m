clear all;
clc;

x = 0:0.01:1;
ML = zmf(x,[0, 0.14]); 
MM = gaussmf(x,[0.05, 0.14]);
MH = smf(x,[0.14, 0.32]);

x2 = 0:0.005:0.5;
SL = zmf(x,[0, 0.1]); 
SM = gaussmf(x,[0.05, 0.1]);
SH = smf(x,[0.2, 0.5]);

x3 = 0:0.01:1;
VL = gaussmf(x,[0.05, 0.0]);
L  = gaussmf(x,[0.05, 0.2]);
M  = gaussmf(x,[0.05, 0.4]);
H  = gaussmf(x,[0.05, 0.6]);
VH = gaussmf(x,[0.05, 0.8]);
HH = gaussmf(x,[0.05, 1.0]);


figure();
set(gcf,'Position',[400,100,420,270]);

subplot(3,1,1);
plot(x,ML, 'Linewidth', 1.4);
hold on;
plot(x,MM, 'Linewidth', 1.4);
hold on;
plot(x,MH, 'Linewidth', 1.4);
hold on;
xlabel('Mean value of resource utilization rates \rho');
set(gca, 'GridAlpha', 0.4);
grid on;
text(0,0.8,'ML')
text(0.113,0.8,'MM')
text(0.28,0.8,'MH')

subplot(3,1,2);
plot(x2,SL, 'Linewidth', 1.4);
hold on;
plot(x2,SM, 'Linewidth', 1.4);
hold on;
plot(x2,SH, 'Linewidth', 1.4);
hold on;
xlabel('Standard deviation of resource utilization rates \tau');
set(gca, 'GridAlpha', 0.4);
grid on;
text(0,0.8,'SL')
text(0.038,0.8,'SM')
text(0.22,0.8,'SH')

subplot(3,1,3);
plot(x3,VL, 'Linewidth', 1.4);
hold on;
plot(x3,L, 'Linewidth', 1.4);
hold on;
plot(x3,M, 'Linewidth', 1.4);
hold on;
plot(x3,H, 'Linewidth', 1.4);
hold on;
plot(x3,VH, 'Linewidth', 1.4);
hold on;
plot(x3,HH, 'Linewidth', 1.4);
hold on;
xlabel('Weight value \beta');
set(gca, 'GridAlpha', 0.4);
grid on;
text(0,0.8,'VL')
text(0.19,0.8,'L')
text(0.39,0.8,'M')
text(0.59,0.8,'H')
text(0.78,0.8,'VH')
text(0.97,0.8,'EH')






