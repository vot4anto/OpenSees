# Created by Stevan Gavrilovic
# University of California Berkeley
# 01.27.2021

message("Building OpenSees with Python")

TEMPLATE = lib

TARGET = opensees

DESTDIR = ./Bin

include(./qmake.conf)

#use plugin so that only one library file gets built and turn off Qt
#CONFIG += staticlib
CONFIG += plugin
CONFIG -= app_bundle
CONFIG -= qt

DEFINES += _DLL

include(./OpenSees.pri)

include(./OpenSeesLibs.pri)

include(./OpenSeesPy.pri)


#Need to add the python libraries at the very end

#Do not use automatic config as on OS X it includes the python2 library as default
#PYTHON_INC=$$system(python-config --includes)
#PYTHON_LIBS=$$system(python-config --ldflags)
#PYTHON_CFLAGS=$$system(python-config --cflags)

#message( $$PYTHON_LIBS)
#message( $$PYTHON_INC)
#message( $$PYTHON_CFLAGS)

#Change these variables to match the location of your Python installation
macx: {

INCLUDEPATH += /Library/Frameworks/Python.framework/Versions/3.10/include/python3.10 \
	       /Library/Frameworks/Python.framework/Versions/3.10/include/python3.10/internal

}

# MPI Settings
contains (DEFINES, _WITHMPI){

QMAKE_CXX = /opt/local/bin/mpicxx-openmpi-gcc14
QMAKE_CXX_RELEASE = $$QMAKE_CXX
QMAKE_CXX_DEBUG = $$QMAKE_CXX
QMAKE_LINK = $$QMAKE_CXX
QMAKE_CC = /opt/local/bin/mpicc-openmpi-gcc14

QMAKE_CFLAGS += $$system(/opt/local/bin/mpicc-openmpi-gcc14 --showme:compile)
QMAKE_LFLAGS += $$system(/opt/local/bin/mpicxx-openmpi-gcc14 --showme:link)
QMAKE_CXXFLAGS += $$system(/opt/local/bin/mpicxx-openmpi-gcc14 --showme:compile) -DMPICH_IGNORE_CXX_SEEK
QMAKE_CXXFLAGS_RELEASE += $$system(/opt/local/bin/mpicxx-openmpi-gcc14 --showme:compile) -DMPICH_IGNORE_CXX_SEEK

}


QMAKE_LFLAGS_RELEASE -= -O1
QMAKE_CXXFLAGS_RELEASE -= -O2
QMAKE_CXXFLAGS_RELEASE += -O3

CONFIG(release, debug|release) {
 CONFIG += optimize_full
}

QMAKE_CFLAGS += -fPIC
QMAKE_CXXFLAGS += -fPIC #-Xpreprocessor -fopenmp -undefined dynamic_lookup

QMAKE_LFLAGS += -Wl,-undefined,dynamic_lookup
