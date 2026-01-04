#!/bin/bash

filename=$1

if [ ! -f "$filename" ]; then
	echo "$filename does not exist."
	exit
fi

indent=0 
while read line; do
	if [[ "$line" == "<"* ]] && [[ "$line" != "</"* ]] && [[ "$line" != "<!"* ]] && [[ "$line" != *"/>" ]]; then
		indent=$((indent + 1))
		echo "$indent"
	fi
	if [[ "$line" == "</"* ]]; then
		indent=$((indent - 1))
		echo "$indent"
	fi
done < "$filename"


