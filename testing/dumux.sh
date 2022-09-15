# this tests dumux as external package which provides
# a Python package outside the dune namespace

dumux_url="https://git.iws.uni-stuttgart.de/dumux-repositories/dumux.git"

# source the clonemodule function and make the core module visible
. ../package
python3 -m venv dune-env
. dune-env/bin/activate
pip install mpi4py requests
pip install --pre --find-links file://$PWD/../dist dune.common dune.grid dune.geometry dune.localfunctions dune.istl

# clone dumux
echo "cloning dumux master"
clonemodule dumux "$dumux_url" master master
echo "done"

# configure
DUMUX_CMAKE_FLAGS="-DBUILD_SHARED_LIBS=1" dunecontrol --opts=dumux/cmake.opts --only=dumux all

pushd dumux/test/python
python test_gridgeometry.py
python test_1p.py
popd
