cd ../repos

FLAGS="-O3 -DNDEBUG"

echo "\
DUNEPATH=`pwd`
BUILDDIR=build-cmake
CMAKE_FLAGS=\"-DCMAKE_CXX_FLAGS=\\\"$FLAGS\\\"  \\
 -DDUNE_ENABLE_PYTHONBINDINGS=ON \\
 -DALLOW_CXXFLAGS_OVERWRITE=ON \\
 -DDUNE_PYTHON_USE_VENV=OFF \\
 -DADDITIONAL_PIP_PARAMS="-upgrade" \\
 -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE \\
 -DDISABLE_DOCUMENTATION=TRUE \\
 -DCMAKE_DISABLE_FIND_PACKAGE_Vc=TRUE \\
 -DCMAKE_DISABLE_FIND_PACKAGE_LATEX=TRUE\" " > femdg-config.opts

#-DCMAKE_LD_FLAGS=\\\"$PY_LDFLAGS\\\" \\

dune-common/bin/dunecontrol --opts=femdg-config.opts --module=dune-fem-dg all

# source config opts for this to work with python
. femdg-config.opts

# set python path variable
MODULES=`dune-common/bin/dunecontrol --print`
for MOD in $MODULES; do
  MODFOUND=`echo $PYTHONPATH | grep $MOD`
  if [ "$MODFOUND" == "" ]; then
    export PYTHONPATH=$PYTHONPATH:${PWD}/${MOD}/build-cmake/python
  fi
done

cd dune-fem-dg/pydemo/euler
python testdg.py
