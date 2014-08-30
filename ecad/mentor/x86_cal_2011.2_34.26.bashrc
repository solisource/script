#!/bin/bash

## Mentor x86_cal_2011.2_34.26 config
alias lmlim1='/ecad/mentor/x86_cal_2011.2_34.26/bin/lmgrd -c /ecad/mentor/x86_cal_2011.2_34.26/lic/license.dat'
alias lmlim2='/ecad/mentor/x86_cal_2011.2_34.26/bin/lmstat -c /ecad/mentor/x86_cal_2011.2_34.26/lic/license.dat'
export MGC_HOME=/ecad/mentor/x86_cal_2011.2_34.26
export CALIBRE_HOME=$MGC_HOME
export MGLS_LICENSE_FILE=$MGC_HOME/lic/license.dat
export PATH=$CALIBRE_HOME/bin:$PATH

