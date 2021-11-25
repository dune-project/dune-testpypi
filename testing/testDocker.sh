ln -s ../Dockerfile .
ln -s ../gcc.minimal.opts .
docker build -t minimal --build-arg DUNE_BRANCH=master .
