python3 -m venv dune-env
. dune-env/bin/activate

pip install dune-grid==2.8.0
pip install --pre --find-links file://$PWD/../dist dune.fem

python -m dune.fem
cd fem_tutorial
python concepts.py
cd ..
