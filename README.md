# dune-testpypi

# Testing scenarios action:

__Note__: this action is run every night.

this runs all bash scripts contained in the `testing` subfolder. More details are given below.

Manually running action
------------------------

1. Login into github and goto [https://github.com/dune-project/dune-testpypi](https://github.com/dune-project/dune-testpypi).
2. Open the 'Actions' tab and on the left choose 'testing scenarios'.
3. On the right click 'Run workflow' which opens a window with some fields to
fill out. Select the corresponding branches in core and fem modules.
4. Click the 'Run workflow' button to start the process.

__Note__: if you can not see a 'Run workflow' button then you need to be
added to the 'dune-project' group. Please ask somebody to do that.

__Note__: currently there is an issue with testing release versions of the modules. Providing an existing tag as workflow input like `v2.9.1` is possible and the correct packages will be generated __but__ the tests use `pip install --pre` to install dune packages and this will prefer the development versions, e.g., `2.10.dev*` over the locally generated release packages. The tests might even all pass but will have tested the packages uploaded to pypi and not the release packages. This needs fixing.

Running locally
---------------
Each test script can be run locally with a setup similar to the github setting.
To this end, use the script 'testing/locallyRunTest' which should be run from the 'testing' folder.

The script takes three arguments:
- The script file to run
- The tag/branches to use for the core modules
- The tag/branches to use for the fem modules

The test is run in a temporary folder below the 'testing' folder.
Be aware that there is no checking done at the moment and also no software / python
package is installed so everything must be available, e.g., 'scikit-buildi'.

Folder Structure
----------------
Every file ending '.sh' in the 'testing' folder will be run in the following environment:
- Every test script is executed in an empty folder (test) located above the
  main folder of this repository.
- Below this folder there are two extra folders:
  - dist: containing the python package .tar.gz files from the requested
    tag/branch of all core modules and dune-fem modules
    (see 'testing/completeInstall.sh' to see how to install from those files)
  - repos: contains all source modules unconfigured
    (see 'testing/completeSourceNoEnv.sh' or 'testing/completeSourceInEnv.sh' for usage)
- Each test script is called with two arguments: the branch/tag name of the
  core and the fem modules, respectively. These are the two arguments that
  can be set when starting the workflow.


Available tests
---------------

__Note__: We test the `example.py` script from dune.grid,
          the test script from dune.mmesh, loading dune.alugrid and dune.polygongrid,
          and a test script from dune.femdg.
          From the tutorial we test dune.femdg and dune.vem (`vemdemo.py` and `chemical.py`)
          and `concepts.py, solvers.py, mcf-algorithm.py,discontinuousgalerkin.py`.

In detail tests scripts are (possibly not a complete list)

1. __completeInstall.sh__:
  - Setup a venv, install dune.grid and run example script. Then add dune.fem and run a script from the fem tutorial.
  - Tests run are `example.py` from dune.grid and `vemdemo.py` from dune.fem.
2. __completeSourceInEnv.sh__:
  - Setup a venv, configure all dune source modules and run a script from the fem tutorial.
  - Tests run are `example.py` from dune.grid and `chemical.py, mcf_algorithm.py` from dune.fem.
3. __completeSourceNoEnv.sh__:
  - Configure all dune source modules without an active venv.
    Then run a script from the fem tutorial using the packages from the dune internal venv.
  - Tests run are `example.py` from dune.grid and `solvers.py, discontinuousgalerkin.py` from dune.fem.
4. __installPlusSource.sh__:
  - Setup a venv and install dune.grid.
    Then configure dune-fem from source and test a tutorial example.
    Add dune-fem-dg from source and test a tutorial example.
    Install dune.polygongrid and test a script to see that it works with dune.fem.
    Finally, build dune-alugrid from source, reconfigure dune-fem and run a tutorial example.
  - Tests run are `concepts.py` from dune.fem and a test script
    form both dune.alugrid and dune.polygongrid.
5. __femdgSourceNoVenv.sh__:
  - Download and execute the dune-fem-dg build script and run one test from dune-fem-dg and one test from dune-fempy.
  - Tests run are `testdg.py` from dune.femdg and `advection.py, laplace-adaptive.py` from dune.fem (in parallel).
6. __mmeshFromSource.sh__:
  - Install dune.fem and then add the dune.mmsh Python package.
  - Tests run are `test.py` from dune.mmsh
