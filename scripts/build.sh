#!/bin/bash

DIR=_build
PYTHON=python3

mkdir $DIR
cd $DIR

$PYTHON -m venv build_env
source build_env/bin/activate

cd ..
$PYTHON setup.py sdist
mv dist _build/
cd $DIR
ls dist | xargs -I {} pip install dist/{}