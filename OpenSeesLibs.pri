#ITPACK, developed at the Center for Numerical Analysis, the University of Texas at Austin, is a collection of
#subroutines for solving large sparse linear systems by adaptive accelerated iterative algorithms.
#currently not using ITPACK in OTHER folder due to fortran useage.No brew formula.
#website: https://web.ma.utexas.edu/CNA/ITPACK/ gives ITPACK2C that could be implemented in the future
contains (DEFINES, _ITPACK){

INCLUDEPATH += \
    $$PWD/SRC/system_of_eqn/linearSOE/itpack \

HEADERS += \
   $$PWD/SRC/system_of_eqn/linearSOE/itpack/ItpackLinSOE.h \
   $$PWD/SRC/system_of_eqn/linearSOE/itpack/ItpackLinSolver.h \

SOURCES += \
   $$PWD/SRC/system_of_eqn/linearSOE/itpack/ItpackLinSOE.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/itpack/ItpackLinSolver.cpp \

}

contains (DEFINES, _SUPERLU){

HEADERS += \
   $$PWD/SRC/system_of_eqn/linearSOE/sparseGEN/SuperLU.h \


SOURCES += \
   $$PWD/SRC/system_of_eqn/linearSOE/sparseGEN/SuperLU.cpp \

macx: {

LIBS += -L/opt/local/lib/ -lsuperlu


INCLUDEPATH += /opt/local/include
DEPENDPATH += /opt/local/include

#PRE_TARGETDEPS += /Users/steve/Desktop/C++Libraries/SuperLU/Install/lib/libsuperlu.a

}

}

contains (DEFINES, _SUPERLUMT){

HEADERS += \
   $$PWD/SRC/system_of_eqn/linearSOE/sparseGEN/SuperLU_MT_util.h \
   $$PWD/SRC/system_of_eqn/linearSOE/sparseGEN/ThreadedSuperLU.h \

macx:{

LIBS += -L/opt/local/lib/ -lsuperlu_mt_PTHREAD

INCLUDEPATH += /opt/local/include/superlu_mt/superlu_mt/
DEPENDPATH += /opt/local/include/superlu_mt/superlu_mt/

PRE_TARGETDEPS += /opt/local/lib/libsuperlu_mt_PTHREAD.a

}

}


contains (DEFINES, _SUPERLUDIST){

HEADERS += \
   $$PWD/SRC/system_of_eqn/linearSOE/sparseGEN/DistributedSuperLU.h \
   $$PWD/SRC/system_of_eqn/linearSOE/sparseGEN/DistributedSparseGenColLinSOE.h \
   $$PWD/SRC/system_of_eqn/linearSOE/sparseGEN/DistributedSparseGenRowLinSOE.h \
   $$PWD/SRC/system_of_eqn/linearSOE/sparseGEN/DistributedSparseGenRowLinSolver.h \

SOURCES += \
   $$PWD/SRC/system_of_eqn/linearSOE/sparseGEN/DistributedSuperLU.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/sparseGEN/DistributedSparseGenColLinSOE.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/sparseGEN/DistributedSparseGenRowLinSOE.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/sparseGEN/DistributedSparseGenRowLinSolver.cpp \

#SuperLU depends on parmetis
if(!contains (DEFINES, _PARMETIS)){

DEFINES += _PARMETIS

}

macx: {

LIBS += -L/opt/local/lib/ -lsuperlu_dist

INCLUDEPATH += /opt/local/include/superlu_dist/
DEPENDPATH += /opt/local/include/superlu_dist/


}

}

#PARMETIS is an MPI-based parallel library that implements a variety of algorithms for partitioning and repartitioning unstructured graphs and for computing fill-reducing orderings of sparse matrices.
contains (DEFINES, _PARMETIS){

macx: {

LIBS += -L/opt/local/lib/ -llibparmetis

INCLUDEPATH += /opt/local/include
DEPENDPATH += /opt/local/include

}

}


#'METIS' is a type of GraphPartitioner and numberer
#Unstructured Graph Partitioning And Sparse Matrix Ordering System', developed by G. Karypis and V. Kumar at the University of Minnesota.
contains (DEFINES, _METIS){

HEADERS += \
   $$PATH_TO_METIS/include/Metis.h \
   $$PWD/SRC/graph/partitioner/Metis.h \
   #$$PWD/SRC/graph/numberer/MetisNumberer.h \


#SOURCES += \
   $$PWD/SRC/graph/partitioner/Metis.cpp \
   #$$PWD/SRC/graph/numberer/MetisNumberer.cpp \


macx: {

LIBS += -L/opt/local/lib/ -llibmetis

INCLUDEPATH +=  /opt/local/include
DEPENDPATH += /opt/local/include

}

}


# A Two-Dimensional Quality Mesh Generator and Delaunay Triangulator.
# Go to triangle.c for more info
contains (DEFINES, _TRIANGLE){

INCLUDEPATH += \
    $$PWD/OTHER/Triangle \

SOURCES += \
   #$$PWD/OTHER/Triangle/showme.c \
   $$PWD/OTHER/Triangle/triangle.c \
   #$$PWD/OTHER/Triangle/tricall.c \ #main function

}


contains (DEFINES, _ARPACK){

HEADERS += \
   $$PWD/SRC/system_of_eqn/eigenSOE/ArpackSOE.h \
   $$PWD/SRC/system_of_eqn/eigenSOE/ArpackSolver.h \
   $$PWD/SRC/system_of_eqn/eigenSOE/BandArpackSOE.h \
   $$PWD/SRC/system_of_eqn/eigenSOE/BandArpackSolver.h \
   $$PWD/SRC/system_of_eqn/eigenSOE/SymArpackSOE.h \
   $$PWD/SRC/system_of_eqn/eigenSOE/SymArpackSolver.h \

SOURCES += \
   $$PWD/SRC/system_of_eqn/eigenSOE/ArpackSOE.cpp \
   $$PWD/SRC/system_of_eqn/eigenSOE/ArpackSolver.cpp \
   $$PWD/SRC/system_of_eqn/eigenSOE/BandArpackSOE.cpp \
   $$PWD/SRC/system_of_eqn/eigenSOE/BandArpackSolver.cpp \
   $$PWD/SRC/system_of_eqn/eigenSOE/SymArpackSOE.cpp \
   $$PWD/SRC/system_of_eqn/eigenSOE/SymArpackSolver.cpp \

macx: {
LIBS += -L/opt/local/lib/ -llibarpack.2 -llibarpack
INCLUDEPATH += /opt/local/include/arpack/
DEPENDPATH += /opt/local/include/arpack/
}

}


#An AMD degree-of-freedom numbering object to provide the mapping between the degrees-of-freedom at the nodes and the equation numbers.
#The AMD numberer uses the approximate minimum degree scheme to order the matrix equations.
#Algorithm 837: AMD, An approximate minimum degree ordering algorithm, P. Amestoy, T. A. Davis, and I. S. Duff, ACM Transactions on Mathematical Software, vol 30, no. 3, Sept. 2004, pp. 381-388.
#An approximate minimum degree ordering algorithm, P. Amestoy, T. A. Davis, and I. S. Duff, SIAM Journal on Matrix Analysis and Applications, vol 17, no. 4, pp. 886-905, Dec. 1996.
#Direct Methods for Sparse Linear Systems, T. A. Davis, SIAM, Philadelphia, Sept. 2006. Part of the SIAM Book Series on the Fundamentals of Algorithms.
contains (DEFINES, _AMD){

INCLUDEPATH += \
    $$PWD/OTHER/AMD \

HEADERS += \
   $$PWD/OTHER/AMD/amd.h \
   $$PWD/OTHER/AMD/amd_internal.h \
   $$PWD/OTHER/AMD/SuiteSparse_config.h \
   $$PWD/OTHER/AMD/UFconfig.h \
   $$PWD/SRC/graph/numberer/AMDNumberer.h \

SOURCES += \
   $$PWD/OTHER/AMD/amd_1.c \
   $$PWD/OTHER/AMD/amd_2.c \
   $$PWD/OTHER/AMD/amd_aat.c \
   $$PWD/OTHER/AMD/amd_control.c \
   $$PWD/OTHER/AMD/amd_defaults.c \
   $$PWD/OTHER/AMD/amd_dump.c \
   $$PWD/OTHER/AMD/amd_global.c \
   $$PWD/OTHER/AMD/amd_info.c \
   $$PWD/OTHER/AMD/amd_order.c \
   $$PWD/OTHER/AMD/amd_post_tree.c \
   $$PWD/OTHER/AMD/amd_postorder.c \
   $$PWD/OTHER/AMD/amd_preprocess.c \
   $$PWD/OTHER/AMD/amd_valid.c \
   $$PWD/OTHER/AMD/SuiteSparse_config.c \
   $$PWD/SRC/graph/numberer/AMDNumberer.cpp \

}


contains (DEFINES, _TETGEN){

INCLUDEPATH += \
    $$PWD/OTHER/Tetgen \
    $$PWD/OTHER/tetgen1.4.3 \

HEADERS += \

SOURCES += \
   #$$PWD/OTHER/Tetgen/predicates.cxx \   #Use these two or the two below
   #$$PWD/OTHER/Tetgen/tetgen.cxx \       #Use these two or the two below
   $$PWD/OTHER/tetgen1.4.3/predicates.cxx \
   $$PWD/OTHER/tetgen1.4.3/tetgen.cxx \
}

#LAPACK — Linear Algebra PACKage
#LAPACK is written in Fortran 90 and provides routines for solving systems of simultaneous linear equations, least-squares solutions of linear systems of equations, eigenvalue problems, and singular value problems.
#The associated matrix factorizations (LU, Cholesky, QR, SVD, Schur, generalized Schur) are also provided, as are related computations such as reordering of the Schur factorizations and estimating condition numbers.
#Dense and banded matrices are handled, but not general sparse matrices. In all areas, similar functionality is provided for real and complex matrices, in both single and double precision.
#Using OS X built in library for LAPACK
contains (DEFINES, _LAPACK){

HEADERS += \
   $$PWD/SRC/system_of_eqn/linearSOE/bandGEN/BandGenLinLapackSolver.h \
   $$PWD/SRC/system_of_eqn/linearSOE/fullGEN/FullGenLinLapackSolver.h \
   $$PWD/SRC/system_of_eqn/linearSOE/bandSPD/BandSPDLinLapackSolver.h \
   $$PWD/SRC/system_of_eqn/linearSOE/bandGEN/DistributedBandGenLinSOE.h \
   $$PWD/SRC/analysis/integrator/KRAlphaExplicit_TP.h \
   $$PWD/SRC/analysis/integrator/KRAlphaExplicit.h \
   $$PWD/SRC/analysis/algorithm/equiSolnAlgo/accelerator/DifferenceAccelerator.h \
   $$PWD/SRC/analysis/algorithm/equiSolnAlgo/accelerator/DifferenceAccelerator2.h \
   $$PWD/SRC/analysis/algorithm/equiSolnAlgo/accelerator/KrylovAccelerator.h \
   $$PWD/SRC/analysis/algorithm/equiSolnAlgo/accelerator/KrylovAccelerator2.h \
   $$PWD/SRC/analysis/algorithm/equiSolnAlgo/KrylovNewton.h \
   $$PWD/SRC/system_of_eqn/eigenSOE/FullGenEigenSolver.h \
   $$PWD/SRC/system_of_eqn/eigenSOE/SymBandEigenSolver.h \


SOURCES += \
   $$PWD/SRC/system_of_eqn/linearSOE/bandGEN/BandGenLinLapackSolver.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/fullGEN/FullGenLinLapackSolver.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/bandSPD/BandSPDLinLapackSolver.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/bandGEN/DistributedBandGenLinSOE.cpp \
   $$PWD/SRC/analysis/integrator/KRAlphaExplicit_TP.cpp \
   $$PWD/SRC/analysis/integrator/KRAlphaExplicit.cpp \
   $$PWD/SRC/analysis/algorithm/equiSolnAlgo/accelerator/DifferenceAccelerator.cpp \
   $$PWD/SRC/analysis/algorithm/equiSolnAlgo/accelerator/DifferenceAccelerator2.cpp \
   $$PWD/SRC/analysis/algorithm/equiSolnAlgo/accelerator/KrylovAccelerator.cpp \
   $$PWD/SRC/analysis/algorithm/equiSolnAlgo/accelerator/KrylovAccelerator2.cpp \
   $$PWD/SRC/analysis/algorithm/equiSolnAlgo/KrylovNewton.cpp \
   $$PWD/SRC/system_of_eqn/eigenSOE/FullGenEigenSolver.cpp \
   $$PWD/SRC/system_of_eqn/eigenSOE/SymBandEigenSolver.cpp \

macx: {

LIBS += -L/System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/ -lLAPACK

INCLUDEPATH += /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A
DEPENDPATH  += /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A

#Need to include the library below so that we do not get a blacs_gridexit error in Python. It looks like this function is not included in the accelerate framework
LIBS += -L/opt/local/lib/ -llibscalapack

INCLUDEPATH += -L/opt/local/include
DEPENDPATH += -L/opt/local/include

}

}

# The BLAS (Basic Linear Algebra Subprograms) are routines that provide standard building blocks for performing basic vector and matrix operations.
# Using OS X built in library for BLAS
contains (DEFINES, _CBLAS){

macx: {

LIBS += -L/System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/ -lBLAS

INCLUDEPATH += /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A
DEPENDPATH += /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A

}

}

#MUMPS : a parallel sparse direct solver
#MUMPS: MUltifrontal Massively Parallel sparse direct Solver
contains (DEFINES, _MUMPS){

INCLUDEPATH += \
    $$PWD/SRC/system_of_eqn/linearSOE/mumps \

HEADERS += \
   $$PWD/SRC/system_of_eqn/linearSOE/mumps/MumpsParallelSOE.h \
   $$PWD/SRC/system_of_eqn/linearSOE/mumps/MumpsParallelSolver.h \
   $$PWD/SRC/system_of_eqn/linearSOE/mumps/MumpsSOE.h \
   $$PWD/SRC/system_of_eqn/linearSOE/mumps/MumpsSolver.h \

SOURCES += \
   $$PWD/SRC/system_of_eqn/linearSOE/mumps/MumpsParallelSOE.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/mumps/MumpsParallelSolver.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/mumps/MumpsSOE.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/mumps/MumpsSolver.cpp \
   #$$PWD/SRC/system_of_eqn/linearSOE/mumps/c_example.c \
   #$$PWD/SRC/system_of_eqn/linearSOE/mumps/c_example1.cpp \
   #$$PWD/SRC/system_of_eqn/linearSOE/mumps/example.cpp \

macx: {

LIBS += -L/opt/local/lib/ -llibdmumps -llibmumps_common -llibpord
INCLUDEPATH += /opt/local/include
DEPENDPATH += /opt/local/include/

}

}

# Portable, Extensible Toolkit for Scientific Computation
# PETSc, pronounced PET-see (the S is silent), is a suite of data structures and routines for the scalable (parallel) solution of scientific applications modeled by partial differential equations.
# It supports MPI, and GPUs through CUDA or OpenCL, as well as hybrid MPI-GPU parallelism. PETSc (sometimes called PETSc/Tao) also contains the Tao optimization software library.
contains (DEFINES, _PETSC){

INCLUDEPATH += \
    $$PWD/SRC/system_of_eqn/linearSOE/petsc \

HEADERS += \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/ActorPetscSOE.h \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/oldpetsc.h \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/PetscSOE.h \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/PetscSolver.h \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/PetscSparseSeqSolver.h \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/ShadowPetscSOE.h \

SOURCES += \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/ActorPetscSOE.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/badPetscSOE.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/main.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/PetscSOE.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/PetscSolver.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/PetscSparseSeqSolver.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/ShadowPetscSOE.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/petsc/TclPetsc.cpp \


macx: {

LIBS +=
INCLUDEPATH +=
DEPENDPATH +=

}

}


#CSPARSE - A Concise Sparse Matrix Package in C
#CSPARSE is a C library which implements a number of direct methods for sparse linear systems, by Timothy Davis.
contains (DEFINES, _CSPARSE){

INCLUDEPATH += \
    $$PWD/OTHER/CSPARSE \

HEADERS += \
   $$PWD/OTHER/CSPARSE/cs.h \

SOURCES += \
   $$PWD/OTHER/CSPARSE/cs_add.c \
   $$PWD/OTHER/CSPARSE/cs_amd.c \
   $$PWD/OTHER/CSPARSE/cs_chol.c \
   $$PWD/OTHER/CSPARSE/cs_cholsol.c \
   $$PWD/OTHER/CSPARSE/cs_compress.c \
   $$PWD/OTHER/CSPARSE/cs_counts.c \
   $$PWD/OTHER/CSPARSE/cs_cumsum.c \
   $$PWD/OTHER/CSPARSE/cs_dfs.c \
   $$PWD/OTHER/CSPARSE/cs_dmperm.c \
   $$PWD/OTHER/CSPARSE/cs_droptol.c \
   $$PWD/OTHER/CSPARSE/cs_dropzeros.c \
   $$PWD/OTHER/CSPARSE/cs_dupl.c \
   $$PWD/OTHER/CSPARSE/cs_entry.c \
   $$PWD/OTHER/CSPARSE/cs_ereach.c \
   $$PWD/OTHER/CSPARSE/cs_etree.c \
   $$PWD/OTHER/CSPARSE/cs_fkeep.c \
   $$PWD/OTHER/CSPARSE/cs_gaxpy.c \
   $$PWD/OTHER/CSPARSE/cs_happly.c \
   $$PWD/OTHER/CSPARSE/cs_house.c \
   $$PWD/OTHER/CSPARSE/cs_ipvec.c \
   $$PWD/OTHER/CSPARSE/cs_leaf.c \
   $$PWD/OTHER/CSPARSE/cs_load.c \
   $$PWD/OTHER/CSPARSE/cs_lsolve.c \
   $$PWD/OTHER/CSPARSE/cs_ltsolve.c \
   $$PWD/OTHER/CSPARSE/cs_lu.c \
   $$PWD/OTHER/CSPARSE/cs_lusol.c \
   $$PWD/OTHER/CSPARSE/cs_malloc.c \
   $$PWD/OTHER/CSPARSE/cs_maxtrans.c \
   $$PWD/OTHER/CSPARSE/cs_multiply.c \
   $$PWD/OTHER/CSPARSE/cs_norm.c \
   $$PWD/OTHER/CSPARSE/cs_permute.c \
   $$PWD/OTHER/CSPARSE/cs_pinv.c \
   $$PWD/OTHER/CSPARSE/cs_post.c \
   $$PWD/OTHER/CSPARSE/cs_print.c \
   $$PWD/OTHER/CSPARSE/cs_pvec.c \
   $$PWD/OTHER/CSPARSE/cs_qr.c \
   $$PWD/OTHER/CSPARSE/cs_qrsol.c \
   $$PWD/OTHER/CSPARSE/cs_randperm.c \
   $$PWD/OTHER/CSPARSE/cs_reach.c \
   $$PWD/OTHER/CSPARSE/cs_scatter.c \
   $$PWD/OTHER/CSPARSE/cs_scc.c \
   $$PWD/OTHER/CSPARSE/cs_schol.c \
   $$PWD/OTHER/CSPARSE/cs_spsolve.c \
   $$PWD/OTHER/CSPARSE/cs_sqr.c \
   $$PWD/OTHER/CSPARSE/cs_symperm.c \
   $$PWD/OTHER/CSPARSE/cs_tdfs.c \
   $$PWD/OTHER/CSPARSE/cs_transpose.c \
   $$PWD/OTHER/CSPARSE/cs_updown.c \
   $$PWD/OTHER/CSPARSE/cs_usolve.c \
   $$PWD/OTHER/CSPARSE/cs_util.c \
   $$PWD/OTHER/CSPARSE/cs_utsolve.c \

}


#High performance message passing library
#https://www.open-mpi.org/
contains (DEFINES, _OPENMPI){

#Set the OPAL_PREFIX environment variable in Qt Creator projects for OpenMPI if the MPI installation is moved from its original location

macx: {

LIBS += -L/opt/local/lib/openmpi-gcc14/ -llibmpi.40 -llibmpi_mpifh.40 -llibopen-pal.80 -llibmpi_usempi_ignore_tkr -llibopen-pal
INCLUDEPATH += /opt/local/include/openmpi-gcc14/
DEPENDPATH +=  /opt/local/include/openmpi-gcc14/

}

}


#Tcl Interpreter -- need to change the paths below to match the version/location on your system
contains (DEFINES, _TCL85){

QMAKE_CXXFLAGS=-I/usr/local/opt/tcl-tk/include

macx: 
LIBS += -L/opt/local/lib/tcl8.6/ -llibtcl8.6
LIBS += -L/opt/local/lib/itcl4.3.2
LIBS += -L/opt/local/lib/
LIBS += -L/opt/local/lib/tdbc1.1.10/
LIBS += -L/opt/local/lib/thread2.8.11

INCLUDEPATH += /opt/local/include/
DEPENDPATH += /opt/local/include/

}

#UMFPACK is a set of routines for solving unsymmetric sparse linear systems of the form Ax=b, using the Unsymmetric MultiFrontal method (Matrix A is not required to be symmetric).
#Written in ANSI/ISO C
contains (DEFINES, _UMFPACK){

#Need to define this so we dont get a strange compilation error due to the sparse-suite cs.h include
DEFINES += NCOMPLEX

INCLUDEPATH += \
    $$PWD/SRC/system_of_eqn/linearSOE/umfGEN \

HEADERS += \
   $$PWD/SRC/system_of_eqn/linearSOE/umfGEN/UmfpackGenLinSOE.h \
   $$PWD/SRC/system_of_eqn/linearSOE/umfGEN/UmfpackGenLinSolver.h \

SOURCES += \
   $$PWD/SRC/system_of_eqn/linearSOE/umfGEN/UmfpackGenLinSOE.cpp \
   $$PWD/SRC/system_of_eqn/linearSOE/umfGEN/UmfpackGenLinSolver.cpp \


macx: {

LIBS += -L/opt/local/lib/ -llibumfpack 
INCLUDEPATH += /opt/local/include/
DEPENDPATH += /opt/local/include/

}

}


INCLUDEPATH += /opt/local/include/
DEPENDPATH += /opt/local/include/

LIBS += -L/opt/local/lib/gcc14/ -llibgfortran.5
