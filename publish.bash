#!/bin/bash --login
ROOT=$(git rev-parse --show-toplevel)
ORIG=${PWD}
cd ${ROOT}
rm ${ROOT}/*.gem
VERSION=$(grep -i "version" concord-ruby.gemspec | awk '{print $3}' | sed s/\'//g)
echo "Building version ${VERSION}"
gem2.0 build concord-ruby.gemspec
gem2.0 push concord-ruby-${VERSION}.gem
cd ${ORIG}
