import sys
import numpy
import math
data = []
k = 7
with open(sys.argv[1]) as f:
    for line in f.readlines()[1:]:
        current =  line.split(",")
        data.append(float(current[1].strip()))

meanData = [numpy.mean(data[x:min(x+k,len(data))]) for x in range(0,len(data),k)]

with open(sys.argv[1]+'.weekly','w') as out:
    out.write("Date,Price\n")
    for i in range(len(meanData)):
        out.write(str(i)+','+str(meanData[i])+"\n")