#!/bin/bash

PARAMS=$@

function pull_until_success(){
    echo "-> git pull $PARAMS"
    (git pull $PARAMS) || (echo "->pull failed, wait 1 sec..."; sleep 1; pull_until_success)
}

pull_until_success
