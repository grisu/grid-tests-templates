#!/bin/bash
#
# because grisu-test.properties command parameter cannot do it?

/usr/bin/tail -n +8 $2 | diff - $1
