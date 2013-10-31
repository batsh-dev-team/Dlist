#!/bin/bash -ex

# OPAM version to install
export OPAM_VERSION=1.0.0
# OPAM packages needed to build tests
export OPAM_PACKAGES='ocamlfind core core_bench ounit'
# OCaml version
export OCAML_VERSION=4.01.0

# install ocaml from apt
sudo apt-get update -qq
sudo apt-get install -qq ocaml

# install opam
curl -L https://github.com/OCamlPro/opam/archive/${OPAM_VERSION}.tar.gz | tar xz -C /tmp
pushd /tmp/opam-${OPAM_VERSION}
./configure
make
sudo make install
opam init -y
opam switch ${OCAML_VERSION}
eval `opam config env`
popd

# install packages from opam
opam install -q -y ${OPAM_PACKAGES}

# compile & run tests (an OASIS DevFiles project might use ./configure --enable-tests && make test)
./configure --enable-tests
make test
