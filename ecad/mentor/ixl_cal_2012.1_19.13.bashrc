#!/usr/bin/bash

## Mentor ixl_cal_2012.1_19.13 config
alias lmlim1='/ecad/mentor/ixl_cal_2012.1_19.13/bin/lmgrd -c /ecad/mentor/ixl_cal_2012.1_19.13/lic/license.dat'
alias lmlim2='/ecad/mentor/ixl_cal_2012.1_19.13/bin/lmstat -c /ecad/mentor/ixl_cal_2012.1_19.13/lic/license.dat'
export MGC_HOME=/ecad/mentor/ixl_cal_2012.1_19.13
export CALIBRE_HOME=$MGC_HOME
export MGLS_LICENSE_FILE=$MGC_HOME/lic/license.dat
export PATH=$CALIBRE_HOME/bin:$PATH

