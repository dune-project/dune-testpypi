cd ../repos
dune-common/bin/dunecontrol --module=dune.grid all
runDune="$PWD/dune-common/build-cmake/run-in-dune-env"
cd -

$runDune pip3 install matplotlib

$runDune python3 -m dune.grid
cd grid_tutorial
$runDune python3 example.py
cd ..

cd ../repos
dune-common/bin/dunecontrol --module=dune.fem all
cd -

$runDune python3 -m dune.fem
cd fem_tutorial
$runDune python3 solvers.py
$runDune python3 discontinuousgalerkin.py
cd ..

