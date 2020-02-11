clear all;
clc;

[startTime, endTime, latitude, longitude, id] = textread('data_6_10-16.txt','%f%f%f%f%s');

EdgeServers = {};

for i=1:length(startTime)
    flag = 1;
    la = latitude(i);  % latitude
    lo = longitude(i); % longitude
    for j=1:length(EdgeServers)
        if EdgeServers{j}(1) == la && EdgeServers{j}(2) == lo
            flag = 0;
            break;
        end
    end    
    if flag
        EdgeServers{end+1} = [la lo];
    end
end

BSPosition = [];
BSPosition_ori = [];
for i=1:length(EdgeServers)
    la = EdgeServers{i}(1);  % latitude 1 =  111km
    lo = EdgeServers{i}(2);  % longitude 111km
    % lower left (31.207868, 121.442130)
    % upper right (31.244629, 121.510040)
    
    % upper left (31.244629, 121.442130)
    % lower right (31.207868, 121.510040)
    % if la > 31.155837 && la < 31.299173 && lo > 121.314609 && lo < 121.647857
    if la > 31.207868 && la < 31.244629 && lo > 121.442130 && lo < 121.510040
        BSPosition_ori(end+1, :) = [lo, la];
        la = (la - 31.207868) * 111 * 1000;
        lo = (lo - 121.442130) * 111 * 1000;
        BSPosition(end+1, :) = [lo, la];
    end
end

figure();

for i=1:length(BSPosition)
    plot(BSPosition(i,1), BSPosition(i,2), 'o');
    hold on;
end

save('Telecom_BaseStations', 'BSPosition');
save('Telecom_BaseStations_ori', 'BSPosition_ori');
