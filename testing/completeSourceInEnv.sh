# setup an external venv
python3 -m venv dune-env
. dune-env/bin/activate
pip install matplotlib mpi4py

# ../repos contains the core dune and dune-fem repositories
# both checkedout and packaged.
# Here we are using the source versions so we build the dune-grid
# toolchain first:
cd ../repos
dune-common/bin/dunecontrol --module=dune.grid all
cd -

# and test if dune-grid is working...
python -m dune.grid
cd grid_tutorial
python example.py
cd ..

# now add dune-fem and dune-fem-dg to the toolchain
cd ../repos
dune-common/bin/dunecontrol --module=dune.fem all
dune-common/bin/dunecontrol --module=dune.fem.dg all
cd -

# and run a test to see if the additional modules are correctly
# handled in dune-py:
python -m dune.fem
cd fem_tutorial
#python chemical.py      # <-- gives a segfault
python mcf-algorithm.py
cd ..
