cd ../repos
dune-common/bin/dunecontrol --module=dune.grid all
runDune="$PWD/dune-common/build-cmake/run-in-dune-env"
cd -

$runDune pip install matplotlib

$runDune python -m dune.grid
cd grid_tutorial
$runDune python example.py
cd ..

cd ../repos
dune-common/bin/dunecontrol --module=dune.fem all
cd -

$runDune python -m dune.fem
cd fem_tutorial
$runDune python solvers.py
cd ..

