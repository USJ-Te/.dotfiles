#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#3c3836/g' \
         -e 's/rgb(100%,100%,100%)/#ebdbb2/g' \
    -e 's/rgb(50%,0%,0%)/#32302f/g' \
     -e 's/rgb(0%,50%,0%)/#D8A657/g' \
 -e 's/rgb(0%,50.196078%,0%)/#D8A657/g' \
     -e 's/rgb(50%,0%,50%)/#32302f/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#32302f/g' \
     -e 's/rgb(0%,0%,50%)/#ebdbb2/g' \
	"$@"