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
%以上为生成随机数列a的过程，以下为统计检验随机数列是否符合分布
num=100;         %分100个区间统计
[x,c]=hist(reqTime,num);    %统计不同区间出现的个数
dc=24/num;        %区间大小
x=x/N/dc;         %根据统计结果计算概率密度
 
bar(c,x,1); hold on;  %根据统计结果画概率密度直方图
xlabel('请求到达时间(h)');
ylabel('请求数占总请求的的比例');
time = int32(sort(reqTime));
save('EUA_Req_Time.mat', 'time')
