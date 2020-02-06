#!/usr/bin/python
# -*- coding: UTF-8 -*-

import sys
import os
import re
import pickle
import numpy as np


dataSet = str(sys.argv[1])
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
        reqs, avaServers = env.getReqs2()
        for i in range(len(reqs)):
            reqNo = reqs[i]
            avaS  = np.array(avaServers[i])
            avaSU = env.getServerUtlizations(avaS)
            avaSS = np.array(env.getAvaServers(reqNo))

            # consolidate edge users
            if len(avaSS) != 0:
                reqReleaseTime = env.Reqs.ReleaseTime[reqNo]
                scores_1 = []
                for s in avaSS:
                    gap = int(env.ServerReleaseTime[s]) - reqReleaseTime
                    if gap < 0:
                        gap = abs(gap) * 1.5
                    scores_1.append(gap)

                ind = np.argmin(scores_1)
                serverNo = avaSS[ind]
                env.allocateResource(reqNo, serverNo)
            else:
                env.rejectRequest()

        env.timeStep()
        isdone = env.isDone()

    rejs.append(env.rejectCount)
    costs.append(env.totalTost)

print(rejs)
print(costs)

f = open("OutPut/"+dataSet+"/UC.txt", 'w')
f.writelines(rejs.__str__())
f.writelines('\n')
f.writelines(costs.__str__())
f.close()