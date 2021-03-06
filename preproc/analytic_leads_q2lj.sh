#!/bin/bash

Nlat=10
Norb=1
Nspin=1

Lmats=1000
Lreal=1000

beta=20.0

# create input.in file
# --------------------
# format:
# Nlat Norb Nspin
# Lmats Lreal
# beta
#
cat > input.in << END 
${Nlat} ${Norb} ${Nspin}
${Lmats} ${Lreal}
${beta}
END

# create leads.in file
# --------------------
# format:
# Nlead
# ilead ispin D mu ikind
# ...
# ilead is the lead index [0,Nlead) 
# ispin is the spin index [0,1]; ispin>0 only needed in spin-polarized cases
# D is the half-bandwidth of the ith lead
# mu is the chemical potential of the ith lead
# ikind denotes the shape of the lead DOS: 0: flad DOS (analytic)
#                                          1: flat DOS (k-sum)
#                                          2: broad-band limit
#                                          3: semicircular
#                                          4: read-in DOS (not implemented)
#
cat > leads.in << END
8
0 0 2.0 0.0 1
1 0 2.0 0.0 1
2 0 2.0 0.0 1
3 0 2.0 0.0 1
4 0 2.0 0.0 1
5 0 2.0 0.0 1
6 0 2.0 0.0 1
7 0 2.0 0.0 1
END

# create vij.in file
# ------------------
# format:
# ilat iorb jlat jorb ilead V
# ...
# each lines defines an hybridization between 
# orbital iorb in site ilat and orbital jorb in site jlat through lead ilead
# if ilat=jlat means that just local hybridization processes exist
# a site can be connected to any number of leads 
#
cat > vij.in << END
1 0 1 0 0 0.0
2 0 2 0 1 0.0
3 0 3 0 2 0.0
4 0 4 0 3 0.0
6 0 6 0 4 0.0
7 0 7 0 5 0.0
8 0 8 0 6 0.0
9 0 9 0 7 0.0
END


# execute program
./analytic_leads.o

# remove input files
rm -f input.in lead.in vij.in



