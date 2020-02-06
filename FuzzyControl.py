#!/usr/bin/python
# -*- coding: UTF-8 -*-

import sys
import os
import re
import pickle
import numpy as np
from scipy.io import loadmat

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

# load fuzzy control strategy
data = loadmat('../../Matlab/Fuzzy/strategy.mat')
strategy = data['strategy']


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

            if len(avaSS) != 0:
                avg = int(round(np.mean(avaSU), 2) * 100)
                std = int(round(np.std(avaSU), 2) * 100)
                beta = strategy[avg, std]

                # Score 1: From the user consolidation perspective
                reqReleaseTime = env.Reqs.ReleaseTime[reqNo]
                scores_1 = []
                for s in avaSS:
                    gap = int(env.ServerReleaseTime[s]) - reqReleaseTime
                    if gap < 0:
                        gap = abs(gap) * 1.5
                    scores_1.append(gap)
                maxS = max(scores_1)
                minS = min(scores_1)
                span = maxS - minS
                if span == 0:
                    for i in range(len(scores_1)):
                        scores_1[i] = 1
                else:
                    for i in range(len(scores_1)):
                        scores_1[i] = 1 - ((scores_1[i]-minS) / span)

                # Score 2: From the load balance perspective
                scores_2 = env.getServerUtlizations(avaSS)
                maxS = 1 - min(scores_2)
                minS = 1 - max(scores_2)
                span = maxS - minS
                for i in range(len(scores_2)):
                    scores_2[i] = 1 - scores_2[i]
                    scores_2[i] = (scores_2[i] - minS) / span

                # combine two scores to the final score
                FinalScore = []
                for i in range(len(scores_1)):
                    score = (1-beta) * scores_1[i] + beta * scores_2[i]
                    FinalScore.append(score)

                ind = np.argmax(FinalScore)
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

f = open("OutPut/"+dataSet+"/FC.txt", 'w')
f.writelines(rejs.__str__())
f.writelines('\n')
f.writelines(costs.__str__())
f.close()