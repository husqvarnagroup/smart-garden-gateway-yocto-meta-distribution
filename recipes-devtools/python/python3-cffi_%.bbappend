# Setuptools is only needed when CFFI modules are compiled, which never happens
# on the target: the extensions we use (e.g. python3-ubootenv) are built ahead
# of time and only import the compiled module and _cffi_backend at runtime.
# The setuptools import in cffi/_shimmed_dist_utils.py is lazy and confined to
# the compilation code paths (ffiplatform, api.compile(), recompiler).
# Dropping it keeps ~7 MiB of setuptools (and its dependencies) out of the image.
RDEPENDS:${PN}:remove = "python3-setuptools"
