#!/bin/bash

filename=$1

if [ ! -f "$filename" ]; then
	echo "$filename does not exist."
	exit
fi

indent=0
 
sed -E '
s/></>\n</g
s/>([^<[:space:]][^<]*)</>\n\1\n</g
/^[[:space:]]*$/d
' "$filename"

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


