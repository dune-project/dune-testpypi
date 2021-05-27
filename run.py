import multiprocessing
import os
import glob

# Creating the tuple of all the processes
all_processes = glob.glob("*.py")

# This block of code enables us to call the script from command line.
def execute(process):
    os.system(f'python {process}')

process_pool = multiprocessing.Pool(processes = 8)
process_pool.map(execute, all_processes)
