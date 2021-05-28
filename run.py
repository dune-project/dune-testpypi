import multiprocessing
import os, glob, sys

# Creating the tuple of all the processes
all_processes = glob.glob("*.py")
all_processes = ["boundary.py", "chimpl.py", "euler.py"]
disable = ["3dexample.py", "interpolation.py"]

# This block of code enables us to call the script from command line.
def execute(process):
    if process in disable: return [process,'disabled']
    ret = os.system(f'python {process}')
    return [process,ret]

process_pool = multiprocessing.Pool(processes = 8)
ret = process_pool.map(execute, all_processes)
ret.sort()
for r in ret:
    print(r)
success = [r[1]==0 for r in ret]
sys.exit(success)
