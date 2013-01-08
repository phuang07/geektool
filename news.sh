#!/bin/sh
# example: ./news.sh -4 // echo 4 articles 
URL="http://blog.webplatform.org/feed/"

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
