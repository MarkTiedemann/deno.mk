#!/bin/sh
set -ex
rm -rf third_party tmp
mkdir tmp
NO_COLOR=true make >tmp/first_make.txt 2>&1
NO_COLOR=true make >tmp/second_make.txt 2>&1
make update_readme
