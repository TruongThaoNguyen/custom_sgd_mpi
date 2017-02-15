VERSION=1.4

#CXX=g++
CXX=mpic++
CXXFLAGS   = -pipe -O3 -fopenmp -std=c++11

# Options for Stampede
#CXX = mpicxx
#CXXFLAGS = -O2 -I$MKLROOT/include -mkl=parallel -openmp


ALL: mpi-ccdr1-omp mpi-sgd-omp

mpi-ccdr1-omp: smat.o ccdr1-mpi-omp.cpp
	${CXX} ${CXXFLAGS} -o mpi-ccdr1-omp smat.o ccdr1-mpi-omp.cpp 

mpi-sgd-omp: util-mpi.o sgd-mpi-omp.cpp
	${CXX} ${CXXFLAGS} -o mpi-sgd-omp util-mpi.o sgd-mpi-omp.cpp 

mpi-sgd-omp-old: util-mpi.o sgd-mpi-omp-bk.cpp
	${CXX} ${CXXFLAGS} -o mpi-sgd-omp-old util-mpi.o sgd-mpi-omp-bk.cpp 

smat.o: smat.cpp smat.h
	${CXX} ${CXXFLAGS} -c -o smat.o smat.cpp

util-mpi.o: util-mpi.h util-mpi.cpp
	${CXX} ${CXXFLAGS} -c -fopenmp -o util-mpi.o util-mpi.cpp 

tar: 
	make clean; cd ../;  tar cvzf libpmf-mpi-${VERSION}.tgz libpmf-mpi-${VERSION}/

clean:
	rm -f mpi-* *.o
