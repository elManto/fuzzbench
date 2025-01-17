# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ARG parent_image
FROM $parent_image

# Install libstdc++ to use llvm_mode.
RUN apt-get update && \
    apt-get install -y wget libstdc++-5-dev libtool-bin automake flex bison \
                       libglib2.0-dev libpixman-1-dev python3-setuptools unzip \
                       apt-utils apt-transport-https ca-certificates joe

# Download and compile libafl
RUN git clone https://github.com/AFLplusplus/libafl /libafl && \
    cd /libafl && \
    git checkout 5b54f0f0680763f2cbaf9831382bc0d7acf0e2d4

RUN cd /libafl && unset CFLAGS && unset CXXFLAGS && \
    export CC=clang && export CXX=clang++ && \
    export LIBAFL_EDGES_MAP_SIZE=2621440 && \
    cd libafl && cargo build --release && \
    cd ../fuzzers/fuzzbench && cargo build --release

RUN ar r /emptylib.a
