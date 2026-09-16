#!/bin/bash

if [ $# -ne 1 ]; then 
	echo "Error!" >&2
	exit 1
fi
if [[ -f "$1" && "$1"  == *.c ]]; then
	echo "File exists!"
else 
	echo "Error, the file does not exist!" >&2
	exit 1
fi

filename=$(basename "$1")
owner=$(ls -l "$1" | awk '{ print $3 }')
month=$(ls -l "$1" | awk '{ print $7 }')
date=$(ls -l "$1" | awk '{ print $8 }')
time=$(ls -l "$1" | awk '{ print $9 }')

tempfile="${1}.tmp"
echo "/**" > "$tempfile"
echo "* File Name: $filename" >> "$tempfile"
echo "* Owner: $owner" >> "$tempfile"
echo "* Last Modified On: $month $date $time" >> "$tempfile"
echo "*/" >> "$tempfile"

cat "$1" >> "$tempfile"

mv "$tempfile" "$1"
