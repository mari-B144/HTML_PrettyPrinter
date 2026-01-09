#!/bin/bash

filename=$1

if [ ! -f "$filename" ]; then
        echo "$filename does not exist."
        exit
fi

indent=0

sed -E '
s/(<[^>]+>)/\n\1\n/g
' "$filename" | while read line; do
	if [ -z "$line" ]; then
		continue
	fi

        if [[ "$line" == "</"* ]]; then
                indent=$((indent - 1))
        fi

	for ((i=0; i<indent; i++)); do
    		echo -n "   "
	done
	echo "$line"

        if [[ "$line" == "<"* ]] && [[ "$line" != "</"* ]] && [[ "$line" != "<!"* ]] && [[ "$line" != *"/>" ]] &&
	   [[ "$line" != "<img"* ]] && [[ "$line" != "<link"* ]] && [[ "$line" != "<meta"* ]] && [[ "$line" != "<input"* ]]; then
                indent=$((indent + 1))
        fi
done
