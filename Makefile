SHELL=/bin/bash -e

test_deps:
	pip install coverage flake8 mypy sphinx wheel

lint: test_deps
	flake8 src

typecheck: test_deps
	mypy --strict --no-warn-unused-ignores src

test: lint typecheck
	coverage run --branch --include 'src/*' -m unittest discover -s test -v

init_docs: test_deps
	cd docs; sphinx-quickstart

docs: test_deps
	sphinx-build docs docs/html

build:
	pip install build
	python -m build

install: clean build
	pip install --upgrade dist/*.whl

clean:
	-rm -rf build dist
	-rm -rf *.egg-info

.PHONY: lint test test_deps docs build install clean

include common.mk
