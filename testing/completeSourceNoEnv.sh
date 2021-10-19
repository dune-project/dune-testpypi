cd ../repos
dune-common/bin/dunecontrol all
runDune="$PWD/dune-common/build-cmake/run-in-dune-env"
cd -
$runDune python -m dune.fem
cd fem_tutorial
python concepts.py
