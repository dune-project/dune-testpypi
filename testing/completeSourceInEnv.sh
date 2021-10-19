python -m venv dune-env 
. dune-env/bin/activate
cd ../repos
dune-common/bin/dunecontrol all
cd -
python -m dune.fem
cd fem_tutorial
python concepts.py
