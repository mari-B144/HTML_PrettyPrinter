#!/bin/bash

file=$1

if [ ! -f "$file" ]; then
        echo "$file does not exist."
fi


read filename
text=$(cat "$filename")
echo $text

