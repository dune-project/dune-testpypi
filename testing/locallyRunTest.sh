# call with three arguement:
# - the test script to run
# - the branch/tag to use for the core modules
# - the branch/tag to use for the fem modules
# The python package scikit-build needs to be available
# TODO: add tests that the above is correctly done!

testScript=$1
coreBranch=$2
femBranch=$3

testBase=$PWD/..

# run test in tmp folder and make it look similar to workflow setup
TMPNAME=`mktemp -d ./tmptest.XXXXXX`
cd $TMPNAME
ln -s .. testing
ln -s ../../clone-modules .
ln -s ../../testpypi.py .

# start to clone dune modules and make distribution
./clone-modules $coreBranch $femBranch

# now run test
export DUNEPY_DISABLE_PLOTTING=1
export DUNE_LOG_LEVEL=$LOGLEVEL
mkdir test
cd test
bash ../testing/$1
