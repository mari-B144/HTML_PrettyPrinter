#!/bin/bash

filename=$1

if [ ! -f "$filename" ]; then
	echo "$filename does not exist."
	exit
fi

indent=0
space=3

#s/</\n</g
#s/>([^<[:space:]][^<]*)</>\n\1\n</g
#s/([^[:space:]])(<[^>]+>)/\1\n\2\n/g
##s/(>)([^<]+)/\1\n\2\n/g
#s/([^>])(<)/\1\n\2/g 
sed -E '
s/(<[^>]+>)/\n\1\n/g
#/^[[:space:]]*$/d
' "$filename" | while read line; do
	if [[ "$line" == "</"* ]]; then
		indent=$((indent - 1))
	fi

	printf "%*s%s\n" $((indent*space)) "" "$line"

	if [[ "$line" == "<"* ]] && [[ "$line" != "</"* ]] && [[ "$line" != "<!"* ]] && [[ "$line" != *"/>" ]]; then
                indent=$((indent + 1))
        fi
done
