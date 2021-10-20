python -m venv dune-env
. dune-env/bin/activate
pip install --pre --find-links file://$PWD/../dist dune.alugrid dune.istl dune.localfunctions

# add dune-fem and test
cp -r ../repos/dune-fem .
dunecontrol --only=dune-fem all
python -m dune.fem
cd fem_tutorial
pip list
python concepts.py
cd ..
rm -rf fem_tutorial

## do this with some other packages e.g. dune-mmsh
# install dune-alugrid and test again
# pip install --pre --find-links file://$PWD/../dist dune.alugrid
# dunecontrol --only=dune-fem all
# python -m dune.fem
# cd fem_tutorial
# pip list
# python laplace-adaptive.py
# cd ..

# add dune-alugrid from source and test again
cp -r ../repos/dune-alugrid .
dunecontrol --only=dune-alugrid all
dunecontrol --only=dune-fem all
python -m dune.fem
cd fem_tutorial
pip list
python laplace-adaptive.py
cd ..
