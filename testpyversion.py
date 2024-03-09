# https://packaging.python.org/en/latest/specifications/version-specifiers/#version-specifiers-regex
import re,sys
def is_canonical(version):
    return re.match(r'^([1-9][0-9]*!)?(0|[1-9][0-9]*)(\.(0|[1-9][0-9]*))*((a|b|rc)(0|[1-9][0-9]*))?(\.post(0|[1-9][0-9]*))?(\.dev(0|[1-9][0-9]*))?$', version) is not None
try:
    ret = not is_canonical( sys.argv[1] )
except:
    ret = 2
exit(ret)
