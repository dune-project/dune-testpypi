base="https://gitlab.dune-project.org"
coreurl="$base/core"
femurl="$base/dune-fem"
exturl="$base/extensions"

python3 -m venv dune-env
. dune-env/bin/activate
pip install scikit-build requests mpi4py
pip install --pre --find-links file://$PWD/../dist dune.fem

# install dune-mmesh
. ../package

echo "cloning dune-mmesh with branch $1"
clonemodule dune-mmesh "$base/samuel.burbulla/dune-mmesh.git" $1 $1
echo "done"

cd dune-mmesh
echo $PWD
package $PWD/../..
echo "PACKAGED"
cd ..
pip install --pre --find-links file://$PWD/dune-mmesh/dist --find-links file://$PWD/../dist dune.mmesh
pip list

# test that it can be used within dune-fem
cd dune-mmesh/scripts
python test.py
