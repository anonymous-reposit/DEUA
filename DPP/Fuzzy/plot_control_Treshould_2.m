clear all;
clc;

d = 100;

x = zeros(d, d);
y = zeros(d, d);
z = zeros(d, d);

for i=1:d
    x(:, i) = [1:d] / d;
end

for i=1:d
    y(i, :) = [1:d] / d;
end

for i=1:d
    for j=1:d
        if i < 20
            z(i,j) = 1;
        end
        if i >=20 && i < 40
            z(i,j) = i/d;
        end
        if i >=40
            z(i,j) = 0;
        end        
    end
end

surf(x, y, z);
xlabel('AVG');
ylabel('STD');
zlabel('Beta');