DUNE_CONTROL_PATH=dune-env setup-dunepy.py --opts=config.opts
pip -m dune.fem tutorial
cd fem_tutorial/
find . -name "*.py" -exec python {} \;
