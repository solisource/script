#!/bin/bash

##############################################################################
## PASS rehl4.8/Linux serL1 2.6.9-89.EL 2009 x86_64 x86_64 x86_64 GNU/Linux ##
##############################################################################

## LD Number
export LD_ASSUME_KERNEL=2.4.1

## Cadence IC5141_lnx86 Config
export CDS_ROOT=/ecad/cadence/IC5141_lnx86
export CDS_LIC_FILE=5280@localhost
export LM_LICENSE_FILE=$CDS_ROOT/share/license/license.dat
export CDS_Netlisting_Mode=Analog
export PATH=$CDS_ROOT/tools/spectre/bin:$CDS_ROOT/tools/bin:$CDS_ROOT/tools/dfII/bin:$PATH
export LD_LIBRARY_PATH=$CDS_ROOT/tools/lib:$CDS_ROOT/tools/dfII/lib:$LD_LIBRARY_PATH

