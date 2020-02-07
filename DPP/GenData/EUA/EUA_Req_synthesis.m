clear all;
clc;

load('EUA_Req_Position.mat');
load('EUA_Req_Time.mat');
x = UPosition(:, 1);
y = UPosition(:, 2);
time = int32(sort(time));
save('EUA_Requests.mat', 'x', 'y', 'time');