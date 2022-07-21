# this tests dumux as external package which provides
# a Python package outside the dune namespace

# dumux Python bindings currently only work with shared libs
export DUNE_CMAKE_FLAGS=-DBUILD_SHARED_LIBS=ON
dumux_url="https://git.iws.uni-stuttgart.de/dumux-repositories/dumux.git"

# setup external venv and install the prepared packages needed
# for dumux
python3 -m venv dune-env
source dune-env/bin/activate
pip install mpi4py
pip install --pre --find-links file://$PWD/../dist dune.common dune.grid dune.geometry dune.localfunctions dune.istl

# source the clonemodule function
source ../package

# clone dumux
echo "cloning dumux master"
clonemodule dumux "$dumux_url" master master
echo "done"

# configure
dunecontrol --only=dumux all

pushd dumux/test/python
python test_1p.py
popd
