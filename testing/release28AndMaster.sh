python3 -m venv dune-env
. dune-env/bin/activate

echo "cloning core 2.8"
git clone --depth 1 -b releases/2.8 https://gitlab.dune-project.org/core/dune-common.git
git clone --depth 1 -b releases/2.8 https://gitlab.dune-project.org/core/dune-geometry.git
git clone --depth 1 -b releases/2.8 https://gitlab.dune-project.org/core/dune-localfunctions.git
git clone --depth 1 -b releases/2.8 https://gitlab.dune-project.org/core/dune-istl.git
git clone --depth 1 -b releases/2.8 https://gitlab.dune-project.org/core/dune-grid.git
git clone --depth 1 -b releases/2.8 https://gitlab.dune-project.org/extensions/dune-alugrid.git
git clone --depth 1 -b releases/2.8 https://gitlab.dune-project.org/dune-fem/dune-fem.git

echo "cloning dune-mmesh with branch $1"
git clone --depth 1 -b $1 https://gitlab.dune-project.org/samuel.burbulla/dune-mmesh.git

./dune-common/bin/dunecontrol --opts=dune-mmesh/cmake/config.opts all
./dune-common/bin/dunecontrol --opts=dune-mmesh/cmake/config.opts make install_python

# test that it can be used within dune-fem==2.8.0
cd dune-mmesh/scripts
python test.py
