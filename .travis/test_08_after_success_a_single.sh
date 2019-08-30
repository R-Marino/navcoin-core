#!/usr/bin/env bash
#
# Copyright (c) 2018 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C.UTF-8

cd build || (echo "could not enter build directory"; exit 1)

if [ "$RUN_FUNC_SINGLE_TESTS" != false ]; then
  BEGIN_FOLD functional-tests-singlejobs
  # echo "Shell limit and tmp disk free"
  # DOCKER_EXEC ulimit -a
  # DOCKER_EXEC df /tmp
  # DOCKER_EXEC export

  echo "Test one by one: Started at " $SECONDS
  DOCKER_EXEC ./qa/pull-tester/rpc-tests.py -parallel=1 $RUN_FUNC_SINGLE_TESTS

  END_FOLD
fi
cd ..
