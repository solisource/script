#!/usr/bin/bash

##############################################################################
## PASS rehl4.8/Linux serL1 2.6.9-89.EL 2009 x86_64 x86_64 x86_64 GNU/Linux ##
##############################################################################

## Mentor ixl_cal_2011.2_34.26 config
export MGC_HOME=/ecad/mentor/ixl_cal_2011.2_34.26
export CALIBRE_HOME=$MGC_HOME
export MGLS_LICENSE_FILE=$MGC_HOME/lic/license.dat
export PATH=$CALIBRE_HOME/bin:$PATH

alias lmlim1='$MGC_HOME/bin/lmgrd -c $MGC_HOME/lic/license.dat -l $MGC_HOME/lic/.lic.log'
alias lmlim2='$MGC_HOME/bin/lmstat -c $MGC_HOME/lic/license.dat'

