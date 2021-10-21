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
git clone --depth 1 -b $1 https://gitlab.dune-project.org/extensions/dune-polygongrid.git
cd dune-polygongrid
package ../../repos
cd ..
pip install --pre --find-links file://$PWD/dune-polygongrid/dist dune.polygongrid
# this should not be needed: dunecontrol --only=dune-fem all
pip list
testScript="\
from dune.polygongrid import polygonGrid ;\
view = polygonGrid( domain, dualGrid=False ) \
from dune.fem.space import lagrange
spc = lagrange(view)
print(spc.size)
"
python -c $testScript
cd ..

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
