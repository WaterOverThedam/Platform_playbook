#!/bin/bash

ls -l  ./sqlScripts/*.utf8|awk '{print "iconv -f utf8 -t gbk "$NF "> "gensub(".utf8","","g",$NF)}'|sh
