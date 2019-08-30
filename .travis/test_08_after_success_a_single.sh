#!/usr/bin/env bash
#
# Copyright (c) 2018 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C.UTF-8

cd build || (echo "could not enter build directory"; exit 1)

if [ "$RUN_FUNCTIONAL_TESTS" = "true" ]; then
  BEGIN_FOLD functional-tests-singlejobs
    echo "Shell limit and tmp disk free"
    DOCKER_EXEC LOCAL_NTP=1 ulimit -a
    DOCKER_EXEC LOCAL_NTP=1 df /tmp

    echo "Test one by one"
    DOCKER_EXEC LOCAL_NTP=1 ./qa/pull-tester/rpc-tests.py -parallel=1 staking_mininputvalue.py
  END_FOLD
fi
cd ..
