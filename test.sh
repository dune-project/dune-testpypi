python3 -m venv /tmp/dune-env
source /tmp/bin/activate
pip install matplotlib scipy pygmsh petsc4py
pip install dune-fem dune-fem-dg dune-vem
setup-dunepy.py --opts=config.opts
DUNE_CONTROL_PATH=/tmp/dune-env setup-dunepy.py --opts=config.opts
pip -m dune.fem tutorial
cd fem_tutorial/
find . -name "*.py" -exec python {} \;
