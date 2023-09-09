# this test simply uses dune-typetree/dune-functions to test if modules
# without python bindings (typetree) are correctly handled in dune-py
# no dune-functions tests are run at the moment

base="https://gitlab.dune-project.org"
coreurl="$base/core"
femurl="$base/dune-fem"
exturl="$base/extensions"
stagurl="$base/staging"

# setup external venv and install the prepared packages needed
# for dune-functions:
python3 -m venv dune-env
. dune-env/bin/activate
pip install mpi4py requests
pip install --pre --find-links file://$PWD/../dist dune.grid dune.localfunctions dune.istl

# source the clonemodule function
. ../package

# clone dune-functions and dune-typetree using the branch provided for core
echo "cloning dune-functions with branch $1"
clonemodule dune-typetree "$stagurl/dune-typetree.git" $1 $1
clonemodule dune-uggrid "$stagurl/dune-uggrid.git" $1 $1
clonemodule dune-functions "$stagurl/dune-functions.git" $1 $1
echo "done"

# configure
dunecontrol --only=dune-typetree all
dunecontrol --only=dune-functions all

# run a simple python script to test the setup of dune-py (dune-functions is not run)
testScript="\
from dune.common import FieldVector ;\
print(\"START\") ;\
x=FieldVector([1,2])
print(\"END\") ;\
"
python -c "$testScript"

