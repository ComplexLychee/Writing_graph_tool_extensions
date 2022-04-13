This repository provdies an example of writting C++ extensions of the graph-tool library for Mac (iOS system) users.

We basically add a few notes to the Makefile, and all the other files are exactly the same as what is given in the official page of the [graph-tool library](https://graph-tool.skewed.de/static/doc/demos/cppextensions/cppextensions.html).

```
CXX=/usr/local/Cellar/llvm/12.0.0/bin/clang # 1)
CXXFLAGS=-O3 -fopenmp -std=gnu++17 -Wall -fPIC `pkg-config --cflags --libs graph-tool-py3.9` -shared # 2)

# BoostPython links.
BOOSTLIBRARIES = -L/usr/local/Cellar/boost-python3/1.76.0/lib -L/usr/local/Cellar/libomp/11.0.0/lib # 3)

# Collect links.
LIBRARIES = $(BOOSTLIBRARIES)

ALL: libkcore.so

libkcore.so: kcore.hh kcore.cc
	${CXX} ${CXXFLAGS} ${LIBRARIES} kcore.cc -o libkcore.so 
```

### Common errors
1. Use the correct compiler: it is necessary to use the same compiler as the one complies the Python which you plan to use. This can be found by running the following 

```python
import sys
sys.version

>>> '3.9.5 (default, May  4 2021, 03:33:11) \n[Clang 12.0.0 (clang-1200.0.32.29)]'
```

If you install graph-tool using homebrew, check the directory where homebrew installed packages.
```
brew info llvm
```
In my case, it is `/usr/local/Cellar/llvm`, which is specified in the first line of the Makefile. Running `clang` simply uses default compiler of your machine, which might cause error.

2. Use the correct version of graph-tool: remember to check the version of your python and adjust the second line in the Makefile correspondingly.


3. Specify the path to linkers: the following error might happen if the path for the boost library path is not correctly specified

```
ld: library not found for -lboost_python39-mt
clang-12: error: linker command failed with exit code 1 (use -v to see invocation)
```
To solve this problem, you need to figure out the path where files `	libboost_python39-mt.a` and `libboost_python39-mt.dylib` are stored and explicitly specify it in the Makefile.

