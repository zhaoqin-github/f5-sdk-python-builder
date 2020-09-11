#!/bin/bash -e
  
usage() {
  return 0
}

build() {
  rm -f README.rst && m2r README.md
  sed -i "s/README.md/README.rst/g" setup.py
  sed -i "s/markdown/x-rst/g" setup.py
  python setup.py bdist_rpm --release ${BUILD_NUMBER}
}

clean() {
  rm -rf \
    README.rst build dist \
    f5_sdk_python.egg-info
}

BUILD_DIR="."
BUILD_NUMBER="1"

while getopts d:n:h o ; do
  case "$o" in
    d)   BUILD_DIR="$OPTARG";;
    n)   BUILD_NUMBER="$OPTARG";;
    h)   usage
         exit 0;;
    [?]) usage
         exit 1;;
  esac
done
shift $((OPTIND-1))

cd ${BUILD_DIR}

if [[ $1 == "clean" ]] ; then
  clean
else
  build
fi
