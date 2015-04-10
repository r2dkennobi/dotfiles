#!/bin/bash

# /screen for lowest
# /ebook for medium
# /printer for high
gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -sOutputFile=$2 $1
