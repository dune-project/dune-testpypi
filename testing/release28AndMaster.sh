python3 -m venv dune-env
. dune-env/bin/activate

pip install dune-fem==2.8.0

# install dune-mmesh
. ../package

echo "cloning dune-mmesh with branch $1"
git clone --depth 1 -b $1 https://gitlab.dune-project.org/samuel.burbulla/dune-mmesh.git
echo "done"

cd dune-mmesh
echo $PWD
package $PWD/../..
echo "PACKAGED"
cd ..
pip install --pre --find-links file://$PWD/dune-mmesh/dist dune.mmesh
pip list

# test that it can be used within dune-fem==2.8.0
cd dune-mmesh/scripts
python test.py
