#! /bin/awk -f

#awk -f awk.sh  emp.dat  #Script from a file

#awk 'pattern {active1}' file
#awk 'pattern {active1;active2;active3}' file #active1,2,3 使用同一个pattern
#awk 'pattern {active1} {active2} {active3}' file 

#$ awk '{print $1,$2,$3}' emp.dat
#$ awk '{print $2,$3*$4}' emp.dat
#$ awk '{print $0,$3*$4}' emp.dat

{print $0}
{print $1,$2,$3}
{print $2,$3*$4}
{print $0,$3*$4}


