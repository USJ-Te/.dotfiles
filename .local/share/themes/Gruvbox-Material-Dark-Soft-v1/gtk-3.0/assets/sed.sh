#!/bin/sh
sed -i \
         -e 's/#3c3836/rgb(0%,0%,0%)/g' \
         -e 's/#ebdbb2/rgb(100%,100%,100%)/g' \
    -e 's/#32302f/rgb(50%,0%,0%)/g' \
     -e 's/#D8A657/rgb(0%,50%,0%)/g' \
     -e 's/#32302f/rgb(50%,0%,50%)/g' \
     -e 's/#ebdbb2/rgb(0%,0%,50%)/g' \
	"$@"
