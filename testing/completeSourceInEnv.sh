python -m venv dune-env 
. dune-env/bin/activate
pip install matplotlib mpi4py

cd ../repos
dune-common/bin/dunecontrol --module=dune.grid all
cd -

python -m dune.grid
cd grid_tutorial
python example.py
cd ..

cd ../repos
dune-common/bin/dunecontrol --module=dune.fem all
dune-common/bin/dunecontrol --module=dune.fem.dg all
cd -

python -m dune.fem
cd fem_tutorial
python chemical.py
cd ..
