export DUNEPY_DISABLE_PLOTTING=1
python -m dune.fem tutorial
cd fem_tutorial/
find . -name "*.py" -maxdepth 0 -exec python {} \;
