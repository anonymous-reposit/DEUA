clear all
clc;


load('Uber_ReqTime.mat');

reqTime = [];
for i=1:length(UberReqTime)
    hh = floor(UberReqTime(i));
    mm = (UberReqTime(i) - hh) * 100;
    reqTime(end+1) = hh*60 + mm;
end

reqTime = [reqTime';reqTime'];

N = length(reqTime);
num=100;        
[x,c]=hist(reqTime,num);
dc=24/num;        
x=x/N/dc;        
 
bar(c,x,1); hold on;    
xlabel('request arrival time (h)');
ylabel('proportion');
time = int32(sort(reqTime));
save('EUA_Req_Time.mat', 'time')
