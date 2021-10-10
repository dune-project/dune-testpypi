import requests, sys
pypi_url = "https://pypi.org"
name = sys.argv[1] # "dune-grid"
version = sys.argv[2] # "2.8.1"
request = requests.get(f"{pypi_url}/pypi/{name}/json")
sys.exit(0 if version in request.json()["releases"].keys() else 1)
