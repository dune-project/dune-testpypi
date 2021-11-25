cp ../testing/Dockerfile .
cp ../testing/gcc.minimal.opts .
ls -ltr 
docker build -t minimal --build-arg DUNE_BRANCH=master .
