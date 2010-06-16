#!/usr/bin/python

import sys
import fileinput
import os

output = sys.argv[1]

outputSize = os.path.getsize(output)
        
if outputSize <= 0:
    print 'output is empty'
    sys.exit(1)



    










