clear all;
clc;


a=linspace(0,2*pi,100);
y1=100*sin(a);
y2=50*cos(a);
y3=tan(a);
y4=log(a);
y=[y1;y2;y3;y4];
figure()
p=plot(a,y);

legend(p(1:2),'sin','cos');
ah=axes('position',get(gca,'position'),'visible','off');
legend(ah,p(3:4),'tan','log','location','west');