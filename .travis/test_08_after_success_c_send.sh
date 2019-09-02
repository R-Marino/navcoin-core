#!/usr/bin/env bash
#
# Copyright (c) 2018 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

if [[ ( -n "$2" ) && ( -d "$2" ) ]]
then
  export LC_ALL=C.UTF-8
  if [ $(ls -1 "$2" | wc -l) = "0" ];
  then echo "No file found in " $2
  else
    ls -l "$2"
    echo preparing  c -j -f /tmp/$1 -C $2 .
    tar c -j -f /tmp/$1 -C $2 .

    ls -l /tmp/$1
    remotename=$(md5sum -b /tmp/$1 | cut -c -32)
    echo "md5checksum" $remotename

    echo " "
    curl -s -S --upload-file /tmp/$1 https://transfer.sh/$remotename
    echo " "
    echo " "
  fi
fi
