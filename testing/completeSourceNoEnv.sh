cd ../repos
dune-common/bin/dunecontrol all
alias runDune=$PWD/dune-common/build-cmake/run-in-dune-env
cd -
runDune python -m dune.fem
cd fem_tutorial
python concepts.py
