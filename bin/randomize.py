#!/usr/bin/env python
# encoding: utf-8

import numpy as np
import os, sys

inf  = "0.xyz"
outf = "ncoors.xyz"
if len(sys.argv) > 1:
    inf  = sys.argv[1]
    outf = sys.argv[2]

if not os.path.isfile(inf):
    print("Input file not found.")
    sys.exit(0)

coor = np.genfromtxt(inf, usecols=(1,2,3), skip_header=2)
elem = np.genfromtxt(inf, usecols=0, skip_header=2, dtype='|U3')
nat = len(coor)

# displacements = np.random.normal(0.00, 0.15, (nat,3))
displacements = (np.random.sample((nat,3))-0.5)*0.16
print("Average displacement: %.3f Å"%np.average(np.linalg.norm(displacements, axis=1)))

coor = coor + displacements

with open(outf, 'w') as f:
    f.write('%d\n\n'%nat)
    for l in zip(elem, coor):
        f.write('%-2s %10.6f %10.6f %10.6f\n'% (l[0], l[1][0], l[1][1], l[1][2]))
