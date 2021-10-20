python3 -m venv dune-env
. dune-env/bin/activate
pip install --find-links file://$PWD/../dist dune.fem

# add dune-mmesh and test
cd ../repos
dunecontrol --only=dune-mmesh --opts=dune-mmesh/cmake/config.opts all
cd dune-mmesh/scripts
python test.py
