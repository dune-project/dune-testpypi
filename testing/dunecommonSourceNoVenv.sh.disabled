#!/bin/bash

# make commands visible
set -x

# install missing python packages in users local environment
# Note: wheel and setuptools may not be required
# dune-common dependencies
pip install -U jinja2 wheel setuptools mpi4py numpy

cd ../repos

FLAGS="-O3 -DNDEBUG"
BUILDDIR=build-cmake

echo "\
DUNEPATH=\$(pwd)
BUILDDIR=$BUILDDIR
CMAKE_FLAGS=\"-DCMAKE_CXX_FLAGS=\\\"$FLAGS\\\"  \\
 -DALLOW_CXXFLAGS_OVERWRITE=ON \\
 -DDUNE_PYTHON_USE_VENV=OFF \\
 -DDISABLE_DOCUMENTATION=TRUE \\
 -DCMAKE_DISABLE_FIND_PACKAGE_Vc=TRUE \\
 -DCMAKE_DISABLE_FIND_PACKAGE_LATEX=TRUE\" " > femdg-config.opts

#-DCMAKE_LD_FLAGS=\\\"$PY_LDFLAGS\\\" \\

dune-common/bin/dunecontrol --opts=femdg-config.opts --only=dune-common all
echo "Done with dune-controlling!"

# source config opts for this to work with python
echo "Sourcing config.opts"
source femdg-config.opts

echo "Setting PYTHONPATH"
source dune-common/$BUILDDIR/set-dune-pythonpath
echo "PYTHONPATH = $PYTHONPATH"

echo "Running euler script"
cd dune-common/dune/python/test/
python pythontests.py
