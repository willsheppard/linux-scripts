#!/bin/bash

# Resize images in bulk

# Requires 'convert', part of ImageMagick 6.6.2-6 2012-08-17 Q16 http://www.imagemagick.org

SIZE=$1
EXTENSION=$2
#for i in *.jpg; do convert $i -resize '10%' $(basename $i .jpg).jpg; done
for i in *.$EXTENSION; do convert $i -resize $SIZE $(basename $i .$EXTENSION).jpg; done
