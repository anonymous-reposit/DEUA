#!/usr/bin/python
# -*- coding: UTF-8 -*-

import sys
import os
import re
import pickle
import random


# parameter 1 : dataset name, i.e., EUA or Telecom
dataSet = str(sys.argv[1])

# define user count list
files = os.listdir("./Envs/")
reqCounts = []
TelecomReqCounts = []
for f in files:
    if len(re.findall(dataSet, f)) != 0:
        reqCounts.append(int(re.findall('\d+', f)[0]))
reqCounts.sort()

rejs  = []
costs = []
for reqCount in reqCounts:
    dataset = './Envs/' + dataSet + '-' + str(reqCount)
    with open(dataset, 'rb') as file:
        env = pickle.load(file)

    isdone = False
    while not isdone:
        reqs, avaServers = env.getReqs()

        for i in range(len(reqs)):
            reqNo = reqs[i]
            avaS = avaServers[i]

            if len(avaS) != 0:
                # randomly select a destine edge server for current edge user
                serverIndex = random.randrange(len(avaS))
                serverNo = avaS[serverIndex]
                env.allocateResource(reqNo, serverNo)
            else:
                env.rejectRequest()

        env.timeStep()
        isdone = env.isDone()

    rejs.append(env.rejectCount)
    costs.append(env.totalTost)

print(rejs)
print(costs)

f = open("OutPut/"+dataSet+"/Random.txt", 'w')
f.writelines(rejs.__str__())
f.writelines('\n')
f.writelines(costs.__str__())
f.close()