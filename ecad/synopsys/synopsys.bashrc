#!/usr/bin/bash

##############################################################################
## PASS rehl4.8/Linux serL1 2.6.9-89.EL 2009 x86_64 x86_64 x86_64 GNU/Linux ##
##############################################################################

## Set Tool Source Path
export SYNOPSYS=/ecad/synopsys

## About Licence
export SNPSLMD_LICENSE_FILE=28000@localhost.localdomain
export LM_LICENSE_FILE=$SYNOPSYS/lic/synopsys.dat
export SCL=$SYNOPSYS/scl_v10.9.3/linux/bin
alias snps1='$SCL/lmgrd -c $LM_LICENSE_FILE -l $SYNOPSYS/lic/.lic.log'
alias snps2='$SCL/lmstat -c $LM_LICENSE_FILE'

## Set tools path for ICC
export PATH=$SYNOPSYS/icc_vC-2009.06-SP3/amd64/syn/bin:$PATH
export PATH=$SYNOPSYS/icc_vD-2010.03-SP5-2/amd64/syn/bin:$PATH
#export PATH=$SYNOPSYS/icc_vE-2010.12/amd64/syn/bin:$PATH ## don`t pass
export PATH=$SYNOPSYS/icc_vF-2011.09/amd64/syn/bin:$PATH
export PATH=$SYNOPSYS/icc_vG-2012.06-SP2/amd64/syn/bin:$PATH ## >= 5, rhel4.8 no-gui
export PATH=$SYNOPSYS/icc_vH-2013.03/amd64/syn/bin:$PATH ## >= 5, rhel4.8 no-gui

## Set tools path for DC
export PATH=$SYNOPSYS/syn_vC-2009.06-SP5/amd64/syn/bin:$PATH
export PATH=$SYNOPSYS/syn_vD-2010.03-SP5-3/amd64/syn/bin:$PATH
export PATH=$SYNOPSYS/syn_vF-2011.09-SP5/amd64/syn/bin:$PATH
export PATH=$SYNOPSYS/syn_vG-2012.06-SP2/amd64/syn/bin:$PATH
export PATH=$SYNOPSYS/syn_vH-2013.03/amd64/syn/bin:$PATH

## Set tools path for PT
export PATH=$SYNOPSYS/pts_vD-2009.12-SP1/amd64/syn/bin:$PATH
export PATH=$SYNOPSYS/pts_vD-2010.06-SP3-5/amd64/syn/bin:$PATH
#export PATH=$SYNOPSYS/pts_vF-2011.06/amd64/syn/bin:$PATH ## don`t pass at 4.8
#export PATH=$SYNOPSYS/pts_vH-2012.12/amd64/syn/bin:$PATH ## don`t pass at 4.8
export PATH=$SYNOPSYS/pts_vH-2013.06/amd64/syn/bin:$PATH

