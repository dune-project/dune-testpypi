python3 -m venv dune-env
. dune-env/bin/activate
pip install matplotlib mpi4py

pip install --pre --find-links file://$PWD/../dist dune.grid
python -m dune.grid
cd grid_tutorial
python example.py
cd ..

pip install --pre --find-links file://$PWD/../dist dune.vem
python -m dune.fem
cd fem_tutorial
python vemdemo.py
cd ..
