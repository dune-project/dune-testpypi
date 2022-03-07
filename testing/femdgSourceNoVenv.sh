echo "Obtaining build script"

WORKDIR=`pwd`

git clone --depth 1 https://gitlab.dune-project.org/dune-fem/dune-fem-dg.git

# if existent, remove config.opts
rm -f config.opts

echo "Running git clone and build for all modules"
# execute dune-fem-dg build script
sh ./dune-fem-dg/scripts/build-dune-fem-dg.sh

# set PTYHONPATH etc
source activate.sh

echo "Testing dune-fem-dg/pydemo/euler/testdg.py"
# test fem-dg scripts
cd dune-fem-dg/pydemo/euler/

python testdg.py

cd $WORKDIR

echo "Testing dune-fempy/demos/laplace-adaptive.py"
# test fempy scripts
cd dune-fempy/demos
python laplace-adaptive.py
