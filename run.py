import multiprocessing
import os
import glob

# Creating the tuple of all the processes
all_processes = glob.glob("*.py")

# This block of code enables us to call the script from command line.
def execute(process):
    ret = os.system(f'python {process}')
    return [process,ret]

process_pool = multiprocessing.Pool(processes = 8)
ret = process_pool.map(execute, all_processes)
for r in ret:
    print(r)
