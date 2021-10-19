python -m venv dune-env
. dune-env/activate
pip install --find-links file://$PWD/../dist
python -m dune.fem
cd fem_tutorial
python concepts.py
