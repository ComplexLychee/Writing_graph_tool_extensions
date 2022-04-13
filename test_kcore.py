from kcore import kcore_decomposition
import graph_tool.all as gt
g = gt.collection.data["football"]
c = kcore_decomposition(g)
print(c.a)