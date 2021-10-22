python3 -m venv dune-env
. dune-env/bin/activate
pip install scikit-build requests

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
echo $PWD
package $PWD/../..
echo "PACKAGED"
mv dist/* ../../dist
cd ..
pip install --pre --find-links file://$PWD/../dist dune.polygongrid
pip list
testScript="\
from dune.polygongrid import polygonGrid ;\
from dune.grid import cartesianDomain ;\
print(\"STARTED\") ;\
view = polygonGrid( cartesianDomain([0,0],[1,1],[10,10]), dualGrid=False ) ;\
print(\"have grid\",view.size(0)) ;\
from dune.fem.space import finiteVolume ;\
print(\"SPACE\") ;\
spc = finiteVolume(view) ;\
print(\"have space\",spc.size) \
"
python -c "$testScript"

# add dune-alugrid from source and test again
cp -r ../repos/dune-alugrid .
dunecontrol --only=dune-alugrid all
# at the moment we need to remove the build dirs of the source modules
# depending on dune-alugrid because their metadata will point to the
# installed dune-alugrid and this leads to a mismatch failure
rm -rf dune-fem/build-cmake dune-fem-dg
# only need to rebuild dune-fem
dunecontrol --only=dune-fem all
cd fem_tutorial
pip list
# at the moment dune packages don't provide a __version__ attribute.
# python -c "import dune.algrid ; assert not 'dev' in dune.alugrid.__version__"
python laplace-adaptive.py
cd ..
