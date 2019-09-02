#!/usr/bin/env bash
#
# Copyright (c) 2018 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C.UTF-8

cd build || (echo "could not enter build directory"; exit 1)

ExitStatus=0

source ../.travis/test_08_opts_override.sh

if [ "$RUN_FUNC_MINI_TESTS" != false ]; then
  BEGIN_FOLD functional-tests-minigroup
  # echo "Shell limit and tmp disk free"
  # DOCKER_EXEC ulimit -a
  # DOCKER_EXEC df /tmp
  # DOCKER_EXEC export

  if [ $SAVE_LOG_TO_DIR ]; then
    ExtraCmd=--savelogsto="$SAVE_LOG_TO_DIR"
  fi
  if [ $SAVE_INSUCESS_DIR ]; then
    ExtraCmd="$ExtraCmd --saveinsucess="$SAVE_INSUCESS_DIR""
  fi


  echo "Test mini group: Started at " $SECONDS
  DOCKER_EXEC LOCAL_NTP=1 ./qa/pull-tester/rpc-tests.py -parallel=2 $ExtraCmd $RUN_FUNC_MINI_TESTS
  ExitStatus=$?
  END_FOLD

  echo "Test Result: " $TRAVIS_TEST_RESULT  "ExitStatus: " $?

  CURWORK=$TRAVIS_BUILD_ID-$TRAVIS_COMMIT-$TRAVIS_JOB_NUMBER-mni

  DOCKER_EXEC ../.travis/test_08_after_success_c_send.sh "$CURWORK-log" "$SAVE_LOG_TO_DIR"
  DOCKER_EXEC ../.travis/test_08_after_success_c_send.sh "$CURWORK-dmp" "$SAVE_INSUCESS_DIR"

  if [ ! 0 -eq $ExitStatus ]; then
    TRAVIS_TEST_RESULT=1
    cd ..
    exit 1
  fi
fi

cd ..
