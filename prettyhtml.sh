#!/bin/bash

filename=$1

if [ ! -f "$filename" ]; then
	 echo "$filename does not exist."
else
	text=$(cat "$filename")
	echo "$text"
fi

