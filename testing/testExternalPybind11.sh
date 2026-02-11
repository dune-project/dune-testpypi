base="https://gitlab.dune-project.org"
coreurl="$base/core"
femurl="$base/dune-fem"
exturl="$base/extensions"

export TMPDIR=/tmp
python3 -m venv dune-env
. dune-env/bin/activate
pip install scikit-build requests mpi4py

export DUNE_ENABLE_PYTHONMODULE_PRECOMPILE=ON
export CMAKE_FLAGS="-DDUNE_USE_SYSTEM_PYBIND11=1"

pip install --pre --find-links file://$PWD/../dist dune.common dune.geometry dune.grid dune.istl dune.localfunctions dune.istl dune.alugrid
pip list
find . -name "pybind11.h"

# let's make sure we can construct a field vector
# since we are precompiling the field vector this should take almost no time
testScript="\
import dune.common
x = dune.common.FieldVector([1,2,3])
print(\"===============================\") ;\
print(\"a dune-common fieldvector:\",x) ;\
print(\"===============================\") ;\
"
/usr/bin/time python -c "$testScript"

# add dune-fem and test
cp -r ../repos/dune-fem .
dunecontrol --only=dune-fem all
python -m dune.fem
cd fem_tutorial
pip list
/usr/bin/time python concepts.py &
/usr/bin/time python dune-corepy.py
cd ..
