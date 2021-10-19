repos/dune-common/bin/dunecontrol all
alias runDune=repos/dune-common/build-cmake/run-in-dune-env
runDune python -m dune.fem
cd fem_tutorial
python concepts.py
