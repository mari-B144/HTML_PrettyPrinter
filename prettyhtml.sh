#!/bin/bash

filename=$1

if [ ! -f "$filename" ]; then
        echo "$filename does not exist."
        exit
fi

indent=0

#s/</\n</g
#s/>([^<[:space:]][^<]*)</>\n\1\n</g
#s/([^[:space:]])(<[^>]+>)/\1\n\2\n/g
##s/(>)([^<]+)/\1\n\2\n/g
#s/([^>])(<)/\1\n\2/g 
sed -E '
s/(<[^>]+>)/\n\1\n/g
' "$filename" | while read line; do

        if [[ "$line" == "</"* ]]; then
                indent=$((indent - 1))
        fi

	for ((i=0; i<indent; i++)); do
    		echo -n "    "
	done
	echo "$line"

        if [[ "$line" == "<"* ]] && [[ "$line" != "</"* ]] && [[ "$line" != "<!"* ]] && [[ "$line" != *"/>" ]]; then
                indent=$((indent + 1))
        fi
done
