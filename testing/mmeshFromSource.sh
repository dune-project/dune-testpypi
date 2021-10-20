python -m venv dune-env
. dune-env/bin/activate
pip install --find-links file://$PWD/../dist dune.fem

# add dune-mmesh and test
cd ../repos
dune-common/bin/dunecontrol --only=dune-mmesh all
cd dune-mmesh/scripts
python test.py
