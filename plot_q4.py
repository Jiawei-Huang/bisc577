import matplotlib.pyplot as plt
import sys
import numpy as np

out=sys.argv[2]
inp = sys.argv[1]
raw = open(inp,"r").read().split("\n")
toplot = []
for i in raw:
    try:
        toplot.append(int(i))
    except:
        print(i)

plt.hist(toplot,bins=10000)
plt.xlim(-17000,17000)
plt.title("distribution of the lengths of structural variants of " + out)
plt.savefig(out +".q4.png")
