Makefile template for setting up and managing projects with conda, and optionally Python, on Mac or Linux. 

By default, uses Miniconda3 to install Python 3 in a local conda installation. 

# Install

Install conda with Miniconda3 (Python 3):

```
make conda
```

Install conda with Miniconda2 (Python 2):

```
make conda2
```

After this, use the `PY` argument to specify if you are using Python 3 (conda) or Python 2 (conda2) for all subsequent commands. 

Example package installation:

```
make conda-install
```

for Python 2:

```
make conda-install PY=2
```

Check that it works:

```
$ make test-conda
which conda
/Users/kellys04/projects/test/conda/bin/conda
which python
/Users/kellys04/projects/test/conda/bin/python
python -c 'import sys; print(sys.version);'
3.6.5 |Anaconda, Inc.| (default, Apr 26 2018, 08:42:37)
[GCC 4.2.1 Compatible Clang 4.0.1 (tags/RELEASE_401/final)]

$ make test-conda PY=2
which conda
/Users/kellys04/projects/test/conda2/bin/conda
which python
/Users/kellys04/projects/test/conda2/bin/python
python -c 'import sys; print(sys.version);'
2.7.15 |Anaconda, Inc.| (default, May  1 2018, 18:37:05)
[GCC 4.2.1 Compatible Clang 4.0.1 (tags/RELEASE_401/final)]
```

# Usage

Run an arbitrary command using the conda installation:

```
make run CMD='echo foo'
```

Run a Python command using the conda installation:

```
make py CMD='myscript.py'
```

