# dune-testpypi

Contains two _actions_

1. "testing scenairos": this runs all bash scripts contained in the
   `testing` subfolder. More details are given below.
   This action is run every night.
2. 'upload packages': this action can be run manually to upload packages to
   a package index (currently pypi, testpypi). This action uses the
   `dune-fem` tutorial to test the packages before upload. The 'tag' to use
   (can be different for core and dune-fem modules) can be set as
   parameters. Instead of a 'tag' it is also possible to provide a branch
   name but then uploading is disabled.

# Testing scenarios action:

Manually running action
------------------------

1. Login into github and goto [https://github.com/adedner/dune-testpypi](https://github.com/adedner/dune-testpypi).
2. Open the 'Actions' tab and on the left choose 'testing scenarios'.
3. On the right click 'Run workflow' which opens a window with some fields to
fill out. Select the corresponding branches in core and fem modules.
4. Click the 'Run workflow' button to start the process.

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
package is installed so everything must be available, i.e., scikit-build.

Folder Structure
----------------
Every file ending '.sh' in the 'testing' folder will be run in the following environment:
- Every test script is executed in an empty folder (test) located above the
  main folder of this repository.
- Below this folder there are two extra folders:
  - dist: containing the python package .tar.gz files from the requested
    tag/branch of all core modules and dune-fem modules
    (see completeInstall.sh to see how to install from those files)
  - repos: contains all source modules unconfigured
    (see completeSourceNoEnv.sh / completeSourceInEnv.sh for usage)
- Each test script is called with two arguments: the branch/tag name of the
  core and the fem modules, respectively. These are the two arguments that
  can be set when starting the workflow.


Available tests
---------------

1. __completeInstall.sh__:
Setup a venv, install dune.grid and run example script.
Then add dune.fem and run a script from the fem tutorial.
1. __completeSourceInEnv.sh__:
Setup a venv, configure all dune source modules and run a script from the fem tutorial.
1. __completeSourceNoEnv.sh__:
Configure all dune source modules without an active venv.
Then run a script from the fem tutorial using the packages from the dune internal venv.
1. __installPlusSource.sh__:
Setup a venv and install dune.grid.
Then configure dune-fem from source and test a tutorial example.
Add dune-fem-dg from source and test a tutorial example.
Install dune.polygongrid and test a script to see that it works with dune.fem.
Finally, build dune-alugrid from source, reconfigure dune-fem and run a tutorial example.
