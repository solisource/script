#!/usr/bin/bash

## Mentor ixl_cal_2013.3_39.24 config
alias lmlim1='/ecad/mentor/ixl_cal_2013.3_39.24/bin/lmgrd -c /ecad/mentor/ixl_cal_2013.3_39.24/lic/license.dat'
alias lmlim2='/ecad/mentor/ixl_cal_2013.3_39.24/bin/lmstat -c /ecad/mentor/ixl_cal_2013.3_39.24/lic/license.dat'
export MGC_HOME=/ecad/mentor/ixl_cal_2013.3_39.24
export CALIBRE_HOME=$MGC_HOME
export MGLS_LICENSE_FILE=$MGC_HOME/lic/license.dat
export PATH=$CALIBRE_HOME/bin:$PATH

