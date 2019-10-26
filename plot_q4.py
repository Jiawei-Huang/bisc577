import matplotlib.pyplot as plt
import sys
import numpy as np
#import seaborn as sns

out=sys.argv[2]
inp = sys.argv[1]
raw = open(inp,"r").read().split("\n")
toplot = []
for i in raw:
    try:
        toplot.append(int(i))
    except:
        print(i)

#plt.hist(toplot,bins=10000)
#sns.displot(toplot, bins=np.linspace(-2000,2000,100))
plt.hist(toplot, bins=np.linspace(-2000,2000,100))
#plt.xlim(-17000,17000)
plt.xlabel("length of structual variants")
plt.ylabel("counts of each bin")
plt.title("distribution of the lengths of structural variants of " + out)
plt.savefig(out +".q4.png")
