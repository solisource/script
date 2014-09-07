#!/usr/bin/bash

##############################################################################
## ##
##############################################################################

## Mentor ixl_cal_2013.2_35.25 config
export MGC_HOME=/ecad/mentor/ixl_cal_2013.2_35.25
export CALIBRE_HOME=$MGC_HOME
export MGLS_LICENSE_FILE=$MGC_HOME/lic/license.dat
export PATH=$CALIBRE_HOME/bin:$PATH

alias lmlim1='$MGC_HOME/bin/lmgrd -c $MGC_HOME/lic/license.dat -l $MGC_HOME/lic/.lic.log'
alias lmlim2='$MGC_HOME/bin/lmstat -c $MGC_HOME/lic/license.dat'

