python3 -m venv dune-env
. dune-env/bin/activate
pip install --pre --find-links file://$PWD/../dist dune.fem

# add dune-mmesh and test
cp -r ../repos/dune-mmesh .
# dunecontrol --only=dune-mmesh --opts=dune-mmesh/cmake/config.opts all
dunecontrol --only=dune-mmesh all
cd dune-mmesh/scripts
python test.py
