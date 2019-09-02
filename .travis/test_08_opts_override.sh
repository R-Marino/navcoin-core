#!/usr/bin/env bash
#
# Copyright (c) 2018 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

# SAVE_LOG_TO_DIR=
SAVE_INSUCESS_DIR="/tmp/TEST_Insucess"

if [ "$RUN_FUNC_SINGLE_TESTS" != false ]; then
  RUN_FUNC_SINGLE_TESTS=false
fi
if [ "$RUN_FUNC_MINI_TESTS" != false ]; then
  RUN_FUNC_MINI_TESTS="getstakereport.py coldstaking_fee.py coldstaking_fee coldstaking_fee getstakereport.py getstakereport.py getstakereport.py"
fi
if [ "$RUN_FUNCTIONAL_TESTS" != false ]; then
   # RUN_FUNCTIONAL_TESTS="extraparameter"
   echo " "
fi

