# Copyright 2021 Google LLC
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
"""Integration code for FairFuzz fuzzer."""

import os

from fuzzers.afl import fuzzer as afl_fuzzer


def build():
    """Build benchmark."""
    afl_fuzzer.build()


def fuzz(input_corpus, output_corpus, target_binary):
    """Run fuzzer."""
    os.environ['AFL_DISABLE_WRS'] = '1'
    os.environ['AFL_DISABLE_RF'] = '1'
    os.environ['AFL_DISABLE_FAVS'] = '1'
    os.environ['AFL_DISABLE_RP'] = '1'
    afl_fuzzer.fuzz(input_corpus, output_corpus, target_binary)