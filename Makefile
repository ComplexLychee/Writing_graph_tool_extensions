CXX=/usr/local/Cellar/llvm/12.0.0/bin/clang # 1)
CXXFLAGS=-O3 -fopenmp -std=gnu++17 -Wall -fPIC `pkg-config --cflags --libs graph-tool-py3.9` -shared # 2)

# BoostPython links.
BOOSTLIBRARIES = -L/usr/local/Cellar/boost-python3/1.76.0/lib -L/usr/local/Cellar/libomp/11.0.0/lib # 3)

# Collect links.
LIBRARIES = $(BOOSTLIBRARIES)

ALL: libkcore.so

libkcore.so: kcore.hh kcore.cc
	${CXX} ${CXXFLAGS} ${LIBRARIES} kcore.cc -o libkcore.so 