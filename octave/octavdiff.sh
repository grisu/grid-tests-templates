#!/bin/bash
#
# because grisu-test.properties command parameter cannot do it?
# trim first few lines to ignore different CPU arch
# remove graphs for TPAC output

/usr/bin/tail -n +8 $2 | /usr/bin/head -52 - | /usr/bin/diff - $1
