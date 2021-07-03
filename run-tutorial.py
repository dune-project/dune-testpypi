import multiprocessing
import os, glob, sys

# Creating the tuple of all the tests
all_test = glob.glob("*.py")

tests = {
    "core":[
      "backuprestore.py",
      "boundary.py",
      "concepts.py",
      "discontinuousgalerkin.py",
      "dune-corepy.py",
      "dune-fempy.py",
      "filteredgridview.py",
      "geoview.py",
      "lineplot.py",
      "levelgridview.py",
      "othergrids.py",
      "solvers.py",
      "laplace-adaptive.py",
      "laplace-dwr.py",
      "mcf.py",
      "mcf-algorithm.py",
      "uzawa-scipy.py",
    ],
    "extensions":[
      "crystal.py",
      "elasticity.py",
      "spiral.py",
      "wave.py",
      "chemical.py",
      "chimpl.py",
      "euler.py",
      "twophaseflow.py",
      "vemdemo.py",
    ]}

disabled = ["3dexample.py", "limit.py"]

# This block of code enables us to call the script from command line.
def execute(process):
    print("START:",process,"...")
    if process in disabled: return [process,'disabled']
    ret = os.system(f'python {process}')
    print("...",process,"completed")
    return [process,ret]

if __name__ == "__main__":
    examples = sys.argv[1]
    process_pool = multiprocessing.Pool(processes = 1)
    ret = process_pool.map(execute, tests[examples])

    ret.sort()
    for r in ret:
        print(r)
    # also print which scripts are not being run by comparing with all_tests

    success = all([r[1]==0 or r[1]=="disabled" for r in ret])
    sys.exit(0 if success else 1)
