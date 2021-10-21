python -m venv dune-env
. dune-env/bin/activate
pip install --pre --find-links file://$PWD/../dist dune.alugrid dune.istl dune.localfunctions

# add dune-fem and test
cp -r ../repos/dune-fem .
dunecontrol --only=dune-fem all
python -m dune.fem
cd fem_tutorial
pip list
python concepts.py
cd ..

# install dune-fem-dg and test again
cp -r ../repos/dune-fem-dg .
dunecontrol --only=dune-fem-dg all
cd fem_tutorial
pip list
python chemical.py
cd ..

# install polygongrid and test that can be used within dune-fem
. ../package

echo "cloning dune-poylygongrid with branch $1"
git clone --depth 1 -b $1 https://gitlab.dune-project.org/extensions/dune-polygongrid.git
echo "done"

cd dune-polygongrid
package ../../repos
cd ..
pip install --pre --find-links file://$PWD/dune-polygongrid/dist dune.polygongrid
# this should not be needed: dunecontrol --only=dune-fem all
pip list
testScript="\
from dune.polygongrid import polygonGrid ;\
from dune.grid import cartesianDomain ;\
view = polygonGrid( cartesianDomain([0,0],[1,1],[10,10]), dualGrid=False ) ;\
from dune.fem.space import lagrange ;\
spc = lagrange(view) ;\
print(spc.size) \
"
python -c "$testScript"

# add dune-alugrid from source and test again
cp -r ../repos/dune-alugrid .
dunecontrol --only=dune-alugrid all
dunecontrol --only=dune-fem all
python -m dune.fem
cd fem_tutorial
pip list
python -c "import dune.algrid ; assert not 'dev' in dune.alugrid.__version__"
python laplace-adaptive.py
cd ..


# install mmesh and test that can be used within dune-fem
. ../package

echo "cloning dune-mmesh with branch $1"
git clone --depth 1 -b $1 https://gitlab.dune-project.org/samuel.burbulla/dune-mmesh.git
echo "done"

cd dune-mmesh
package ../../repos
cd ..
pip install --pre --find-links file://$PWD/dune-mmesh/dist dune.mmesh
pip list
cd dune-mmesh/scripts
python test.py
