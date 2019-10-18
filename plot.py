import matplotlib.pyplot as plt
import sys

input_file=sys.argv[1]

toplot = []
for line in open(input_file,"r").readlines():
    toplot.append(int(line.split(" ")[2]))
plt.hist(toplot)
plt.title("Histogram of SNV count per 20kb")
plt.savefig(input_file.replace("txt","png"))

