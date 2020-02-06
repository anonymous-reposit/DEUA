#!python
#!/usr/bin/env python
from scipy.io import loadmat


data = loadmat('./strategy.mat')
s = data['strategy']
print(s)

# print(s[0,0])
# print(s[0,1])
# print(s[1,:])
# print(len(s))

# data = loadmat('./reqPosition')
# x = data['x']
# y = data['y']
# print(len(x))
# print(len(y))
# print(x[0])
# print(y[0])

# data = loadmat('./reqArrivalTime.mat')
# time = data['time']
# print(len(time))
# print(time[0])
# print(time)
