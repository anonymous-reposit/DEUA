clear all
clc;

x1 = [1:100];
y1 = [];
for i=1:100
    if i < 20
        y1(end+1) = 1;
    else
        y1(end+1) = 0;
    end
end

x2 = [1:100];
y2 = [];
for i=1:100
    if i < 20
        y2(end+1) = 1;
    elseif i < 40
        y2(end+1) = (-1/20)*i+2;
    else
        y2(end+1) = 0;
    end
end

plot(x1,y1,x2,y2,'LineWidth', 2);