#!/usr/bin/env python
import sys
write = sys.stdout.write
for i in range(2):
    for j in range(30, 38):
        for k in range(40, 48):
            write("%d;%d;%d: \33[%d;%d;%dm Hello, World! \33[m \n" %
                    (i, j, k, i, j, k,))
        write("\n")
write("\n")
