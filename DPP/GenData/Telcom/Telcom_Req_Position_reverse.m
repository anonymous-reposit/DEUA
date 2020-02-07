clear all;
clc;

load('Telecom_Requests.mat');
UPosition = [];
UPosition(:, 1) = x;
UPosition(:, 2) = y;
xs = max(UPosition(:,1));
ys = max(UPosition(:,2));
scale = 200;
xm = ceil(xs / scale);
ym = ceil(ys / scale);


% max x value = 1947.8367956637    2000 / 50 = 40
% max y value = 1045.83633704022   1050 / 50 = 21

x = zeros(xm, ym);
y = zeros(xm, ym);
z = zeros(xm, ym);

for i=1:length(UPosition)
    xind = ceil(UPosition(i,1) / scale);
    yind = ceil(UPosition(i,2) / scale);
    z(xind, yind) = z(xind, yind) + 1;
end

% 经度 121.442130   121.510040
% 纬度 31.207868    31.244629
la_gap = 121.510040 - 121.442130;
lo_gap = 31.244629 - 31.207868;
la_scal = la_gap / xm;
lo_scal = lo_gap / ym;

for i=1:xm
    for j=1:ym
        la = la_scal * (i + 2) + 121.442130;
        lo = lo_scal * (j + 2) + 31.207868;
        fprintf('{"lng":%f,"lat":%f,"count":%.3f}, \n', la, lo, z(i,j))
    end
end


