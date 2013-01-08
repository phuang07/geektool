#!/bin/sh

URL="http://www.rememberthemilk.com/atom/leoman730/8549216/"

if [ $# -eq 1 ] ; then
  headarg=$(( $1 * 2 ))
else
  headarg="-8"
fi

curl --silent "$URL" | grep -E '(title>|description>)' | \
  sed -n '4,$p' | \
  sed -e 's/<title>//' -e 's/<\/title>//' -e 's/<description>/   /' \
      -e 's/<\/description>//' | \
  sed -e 's/<!\[CDATA\[//g' |            
  sed -e 's/\]\]>//g' |         
  sed -e 's/<[^>]*>//g' |      
  head $headarg | sed G | fmt
