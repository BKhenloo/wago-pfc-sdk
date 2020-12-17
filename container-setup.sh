#! /usr/bin/env bash

set -e

if [ "$1" = 'startup' ]; then

    if [ -z "/home/wago/ptxproj" ]; then
        git clone -v "$ptxproj" /home/wago/ptxproj &
		wait $!
		git clone -v "$ptxsrc" /home/wago/ptxproj/src &
		wait $!
	fi
		
fi

exec "$@"