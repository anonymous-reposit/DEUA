clear all;
clc;

load('Telecom_BaseStations_ori.mat');
load('Telecom_BaseStations.mat');
[startTime, endTime, latitude, longitude, id] = textread('data_6_10-16.txt','%f%f%f%f%s');

Reqs = {};
for i=1:length(startTime)
    la = latitude(i);
    lo = longitude(i);
    for j=1:length(BSPosition_ori)
        if la == BSPosition_ori(j,2) && lo == BSPosition_ori(j,1)
               hour = floor(startTime(i));
               minute = startTime(i) - floor(startTime(i));
               reqTime = int32(hour * 60 + minute*100);
            Reqs{end+1} = [reqTime j];
        end
    end
end


ReqTime = [];
ReqPos = [];
for i=1:length(Reqs)
    serverInd = Reqs{i}(2);
    serverX   = BSPosition(serverInd,1);
    serverY   = BSPosition(serverInd,2);
    dist      = rand() * 500;
    alpha     = rand() * 2 * pi;
    reqX      = abs(serverX + cos(alpha) * dist);
    reqY      = abs(serverY + sin(alpha) * dist);
    ReqPos(end+1, :) = [reqX reqY];
    ReqTime(end+1) = Reqs{i}(1);
end
% time = sort(ReqTime);
% UPosition = ReqPos;
% save('Telcom_Requests.mat', 'time', 'UPosition');

[time, ind] = sort(ReqTime);
time = time';
x = ReqPos(:, 1);
y = ReqPos(:, 2);
x = x(ind);
y = y(ind);
save('Telecom_Requests.mat', 'time', 'x', 'y');
