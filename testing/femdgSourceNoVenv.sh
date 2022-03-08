#!/bin/bash

# install missing python packages in users local environment
pip install -U jinja2 wheel setuptools mpi4py numpy scipy fenics-ufl matplotlib

cd ../repos

FLAGS="-O3 -DNDEBUG"

echo "\
DUNEPATH=`pwd`
BUILDDIR=build-cmake
CMAKE_FLAGS=\"-DCMAKE_CXX_FLAGS=\\\"$FLAGS\\\"  \\
 -DDUNE_ENABLE_PYTHONBINDINGS=ON \\
 -DALLOW_CXXFLAGS_OVERWRITE=ON \\
 -DDUNE_PYTHON_USE_VENV=OFF \\
 -DADDITIONAL_PIP_PARAMS="-upgrade" \\
 -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE \\
 -DDISABLE_DOCUMENTATION=TRUE \\
 -DCMAKE_DISABLE_FIND_PACKAGE_Vc=TRUE \\
 -DCMAKE_DISABLE_FIND_PACKAGE_LATEX=TRUE\" " > femdg-config.opts

#-DCMAKE_LD_FLAGS=\\\"$PY_LDFLAGS\\\" \\

dune-common/bin/dunecontrol --opts=femdg-config.opts --module=dune-fem-dg all
echo "Done with dune-controlling!"

# source config opts for this to work with python
echo "Sourcing config.opts"
source femdg-config.opts

echo "Setting PYTHONPATH"
DUNE_PATH=${PWD}
# set python path variable
MODULES=$(./dune-common/bin/dunecontrol --print)
for MOD in $MODULES; do
  export PYTHONPATH=$PYTHONPATH:$DUNE_PATH/${MOD}/build-cmake/python
done
echo "PYTHONPATH = $PYTHONPATH"

echo "Running euler scripts"
cd dune-fem-dg/pydemo/euler
python testdg.py
