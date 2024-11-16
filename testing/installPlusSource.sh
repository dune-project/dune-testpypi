base="https://gitlab.dune-project.org"
coreurl="$base/core"
femurl="$base/dune-fem"
exturl="$base/extensions"

export TMPDIR=/tmp
# python3 -m venv --system-site-packages dune-env # this fails?
python3 -m venv dune-env
. dune-env/bin/activate
pip install scikit-build requests mpi4py

# this script is supposed to use petsc4py - let's make sure it can be
# accessed from the site-packages
testScript="\
import sys ;\
import petsc4py ;\
petsc4py.init(sys.argv) ;\
from petsc4py import PETSc ;\
print(\"===============================\") ;\
print(\"petsc4py version:\",petsc4py.__version__) ;\
print(\"===============================\") ;\
"
# we need site-packages to get this to work but we get problems with 
# File "/home/runner/work/dune-testpypi/dune-testpypi/test/dune-env/lib/python3.10/site-packages/dune/common/__init__.py", line 44, in <module>
#    from ._common import *
# ModuleNotFoundError: No module named 'dune.common._common'
# in next test script with - so deactivated again for now
# python -c "$testScript"

# enable pre-compiled modules
export DUNE_ENABLE_PYTHONMODULE_PRECOMPILE=ON

pip install --pre --find-links file://$PWD/../dist dune.common dune.geometry dune.grid dune.istl dune.localfunctions dune.istl dune.alugrid
pip list

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
/usr/bin/time python externaleSolvers.py
cd ..

# install polygongrid and test that can be used within dune-fem
. ../package

echo "cloning dune-poylygongrid with branch $1"
clonemodule dune-polygongrid "$exturl/dune-polygongrid.git" $1 $1
echo "done"

cd dune-polygongrid
echo $PWD
package $PWD/../..
echo "PACKAGED"
mv dist/* ../../dist
cd ..
pip install --pre --find-links file://$PWD/../dist dune.polygongrid
pip list
testScript="\
from dune.polygongrid import polygonGrid as leafGridView ;\
from dune.grid import cartesianDomain ;\
print(\"STARTED\") ;\
view = leafGridView( cartesianDomain([0,0],[1,1],[10,10]), dualGrid=False ) ;\
print(\"have grid\",view.size(0)) ;\
from dune.fem.space import finiteVolume as space ;\
print(\"SPACE\") ;\
spc = space(view) ;\
print(\"have space\",spc.size) \
"
python -c "$testScript"

# add dune-alugrid from source and test again
cp -r ../repos/dune-alugrid .
dunecontrol --only=dune-alugrid all
# at the moment we need to remove the build dirs of the source modules
# depending on dune-alugrid because their metadata will point to the
# installed dune-alugrid and this leads to a mismatch failure
rm -rf dune-fem/build-cmake
# only need to rebuild dune-fem
dunecontrol --only=dune-fem all
pip list
testScript="\
from dune.alugrid import aluSimplexGrid as leafGridView ;\
from dune.grid import cartesianDomain ;\
print(\"STARTED\") ;\
view = leafGridView( cartesianDomain([0,0,0],[1,1,1],[10,10,10]) ) ;\
print(\"have grid\",view.size(0)) ;\
from dune.fem.space import lagrange as space ;\
print(\"SPACE\") ;\
spc = space(view) ;\
print(\"have space\",spc.size) \
"
python -c "$testScript"


# we can rerun concepts.py which should be fast
cd fem_tutorial
pip list
/usr/bin/time python concepts.py
cd ..
