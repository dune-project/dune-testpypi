ln -s ../testing/Dockerfile .
ln -s ../testing/gcc.minimal.opts .
docker build -t minimal --build-arg DUNE_BRANCH=master .
