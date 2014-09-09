#!/bin/sh  
  
  
# Copyright (c) 2010 codingstandards. All rights reserved.  
# file: datetime.sh  
# description: Bash�й�������ʱ������ĳ����Զ��庯��  
# license: LGPL  
# author: codingstandards  
# email: codingstandards@gmail.com  
# version: 1.0  
# date: 2010.02.27  
  
  
# usage: yesterday  
# ����  
# ���������2010��2��27�գ���ô�������2010-02-26  
yesterday()  
{  
    date --date='1 day ago' +%Y-%m-%d  
}  
  
# usage: today  
# ����  
# ���������2010��2��27�գ���ô�������2010-02-27  
today()  
{  
    date +%Y-%m-%d  
}  
  
# usage: now  
# ���ڣ��������ں�ʱ�䡢����  
# ���磺2010-02-27 11:29:52.991774000  
now()  
{  
    date "+%Y-%m-%d %H:%M:%S.%N"  
}  
  
# usage: curtime  
# ��ǰʱ�䣬�������ں�ʱ��  
# ���磺2010-02-27 11:51:04  
curtime()  
{  
    date '+%Y-%m-%d %H:%M:%S'  
    # Ҳ��д�ɣ�date '+%F %T'  
}  
  
# usage: last_month  
# ȡ�ϸ��µ�����  
# ���磺2010-01  
last_month()  
{  
    date --date='1 month ago' '+%Y-%m'  
}  
  
# usage: last_month_packed  
# ȡ�ϸ��µ�����  
# ���磺201001  
last_month_packed()  
{  
    date --date='1 month ago' '+%Y%m'  
}  
  
# usage: first_date_of_last_month  
# ȡ�ϸ��µĵ�һ��  
# ���籾����2010��2�£���ô�������2010-01-01  
first_date_of_last_month()  
{  
    date --date='1 month ago' '+%Y-%m-01'  
}  
  
# usage: last_date_of_last_month  
# ȡ�ϸ��µ����һ��  
# ���統ǰ��2010��2�£���ô�������2010-01-31  
last_date_of_last_month()  
{  
    date --date="$(date +%e) days ago" '+%Y-%m-%d'  
}  
  
# usage: day_of_week  
# ���������  
# day of week (0..6);  0 represents Sunday  
day_of_week()  
{  
    date +%w  
}  
  
# usage: last_hour  
# �ϸ�Сʱ  
# ���磺2010-02-27-10  
# �ʺϴ���log4j���ɵ���־�ļ���  
last_hour()  
{  
    date --date='1 hour ago' +%Y-%m-%d-%H  
}  
  
# usage: the_hour  
# ��ǰ��Сʱ��Ϊ���������Ƚϣ��������0��ͷ  
# ���磺12  
the_hour()  
{  
    #date +%H   # hour (00..23)  
    date +%k    # hour ( 0..23)  
}  
  
# usage: the_minute  
# ��ǰ�ķ��ӣ�Ϊ���������Ƚϣ��������0��ͷ  
# ���磺  
the_minute()  
{  
    MM=$(date +%M)  # minute (00..59)  
    echo $[1$MM-100]  
}  
  
# usage: the_second  
# ��ǰ������  
# ���磺  
the_second()  
{  
    SS=$(date +%S)  # second (00..60); the 60 is necessary to accommodate a leap  second  
    echo $[1$SS-100]  
}  
  
# usage: the_year  
# ��ǰ����� year (1970...)  
# ���磺2010  
the_year()  
{  
    date +%Y  
}  
  
# usage: the_month  
# ��ǰ���·ݣ�Ϊ���������Ƚϣ��������0��ͷ  
# ���磺2  
the_month()  
{  
    M=$(date +%m) # month (01..12)  
    echo $[1$M-100]  
}  
  
# usage: the_date  
# ��ǰ�����ڣ�Ϊ���������Ƚϣ��������0��ͷ  
# ���磺27  
the_date()  
{  
    date +%e    # day of month, blank padded ( 1..31)  
}  
  
# usage: days_ago <n>  
# ȡn��ǰ������  
# ���磺days_ago 0���ǽ��죬days_ago 1�������죬days_ago 2����ǰ�죬days_ago -1��������  
# ��ʽ��2010-02-27  
days_ago()  
{  
    date --date="$1 days ago" +%Y-%m-%d  
}  
  
# usage: chinese_date_and_week()  
# ��ӡ���ĵ����ں�����  
# ���磺2��27�� ������  
chinese_date_and_week()  
{  
    WEEKDAYS=(������ ����һ ���ڶ� ������ ������ ������ ������)  
    WEEKDAY=$(date +%w)  
    #DT="$(date +%Y��%m��%d��) ${WEEKDAYS[$WEEKDAY]}"     
    MN=1$(date +%m)  
    MN=$[MN-100]  
    DN=1$(date +%d)  
    DN=$[DN-100]  
    DT="$MN��$DN�� ${WEEKDAYS[$WEEKDAY]}"  
    echo "$DT"  
}  
  
# usage: rand_digit  
# ������֣�0-9  
rand_digit()  
{  
    S="$(date +%N)"  
    echo "${S:5:1}"  
}  
  
# usage: seconds_of_date [<date> [<time>]]  
# ��ȡָ�����ڵ���������1970�꣩  
# ���磺seconds_of_date "2010-02-27" ���� 1267200000  
seconds_of_date()  
{  
    if [ "$1" ]; then  
        date -d "$1 $2" +%s  
    else  
        date +%s  
    fi  
}  
  
# usage: date_of_seconds <seconds>  
# ������������1970�꣩�õ�����  
# ���磺date_of_seconds 1267200000 ���� 2010-02-27  
date_of_seconds()  
{  
    date -d "1970-01-01 UTC $1 seconds" "+%Y-%m-%d"  
}  
  
# usage: datetime_of_seconds <seconds>  
# ������������1970�꣩�õ�����ʱ��  
# ���磺datetime_of_seconds 1267257201 ���� 2010-02-27 15:53:21  
datetime_of_seconds()  
{  
    date -d "1970-01-01 UTC $1 seconds" "+%Y-%m-%d %H:%M:%S"  
}  
  
# usage: leap_year <yyyy>  
# �ж��Ƿ�����  
# ���yyyy�����꣬�˳���Ϊ0�������0  
# ����ʾ�����£�  
# if leap_year 2010; then  
#   echo "2010 is leap year";  
# fi  
# if leap_year 2008; then  
#   echo "2008 is leap year";  
# fi  
# ժ�Խű���datetime_util.sh (2007.06.11)  
# ע������ű��������磬�����޸ģ�ԭ�ű��ӱ�׼�����ȡ��ݣ��ָĳ�ͨ������ָ����  
# Shell program to read any year and find whether leap year or not  
# -----------------------------------------------  
# Copyright (c) 2005 nixCraft project <http://cyberciti.biz/fb/>  
# This script is licensed under GNU GPL version 2.0 or above  
# -------------------------------------------------------------------------  
# This script is part of nixCraft shell script collection (NSSC)  
# Visit http://bash.cyberciti.biz/ for more information.  
# -------------------------------------------------------------------------  
leap_year()  
{  
    # store year  
    yy=$1  
    isleap="false"  
  
    #echo -n "Enter year (yyyy) : "  
    #read yy  
  
    # find out if it is a leap year or not  
  
    if [ $((yy % 4)) -ne 0 ] ; then  
        : #  not a leap year : means do nothing and use old value of isleap  
    elif [ $((yy % 400)) -eq 0 ] ; then  
        # yes, it's a leap year  
        isleap="true"  
    elif [ $((yy % 100)) -eq 0 ] ; then  
        : # not a leap year do nothing and use old value of isleap  
    else  
        # it is a leap year  
        isleap="true"  
    fi  
    #echo $isleap  
    if [ "$isleap" == "true" ]; then  
        #  echo "$yy is leap year"  
        return 0  
    else  
        #  echo "$yy is NOT leap year"  
        return 1  
    fi  
}  
  
# usage: validity_of_date <yyyy> <mm> <dd>  
# �ж�yyyy-mm-dd�Ƿ�Ϸ�������  
# ����ǣ��˳���Ϊ0�������0  
# ����ʾ�����£�  
# if validity_of_date 2007 02 03; then  
#   echo "2007 02 03 is valid date"  
# fi  
# if validity_of_date 2007 02 28; then  
#   echo "2007 02 28 is valid date"  
# fi  
# if validity_of_date 2007 02 29; then  
#   echo "2007 02 29 is valid date"  
# fi  
# if validity_of_date 2007 03 00; then  
#   echo "2007 03 00 is valid date"  
# fi  
# ժ�Խű���datetime_util.sh (2007.06.11)  
# ע������ű��������磬�����޸ģ�ԭ�ű��ӱ�׼�����ȡ�����գ��ָĳ�ͨ������ָ����  
# Shell program to find the validity of a given date  
# -----------------------------------------------  
# Copyright (c) 2005 nixCraft project <http://cyberciti.biz/fb/>  
# This script is licensed under GNU GPL version 2.0 or above  
# -------------------------------------------------------------------------  
# This script is part of nixCraft shell script collection (NSSC)  
# Visit http://bash.cyberciti.biz/ for more information.  
# -------------------------------------------------------------------------  
validity_of_date()  
{  
    # store day, month and year  
    yy=$1  
    mm=$2  
    dd=$3  
  
    # store number of days in a month  
    days=0  
  
    # get day, month and year  
    #echo -n "Enter day (dd) : "  
    #read dd  
  
    #echo -n "Enter month (mm) : "  
    #read mm  
  
    #echo -n "Enter year (yyyy) : "  
    #read yy  
  
    # if month is negative (<0) or greater than 12   
    # then it is invalid month  
    if [ $mm -le 0 -o $mm -gt 12 ]; then  
        #echo "$mm is invalid month."  
        return 1  
    fi  
  
    # Find out number of days in given month  
    case $mm in   
        1) days=31;;  
        01) days=31;;  
        2) days=28 ;;  
        02) days=28 ;;  
        3) days=31 ;;  
        03) days=31 ;;  
        4) days=30 ;;  
        04) days=30 ;;  
        5) days=31 ;;  
        05) days=31 ;;  
        6) days=30 ;;  
        06) days=30 ;;  
        7) days=31 ;;  
        07) days=31 ;;  
        8) days=31 ;;  
        08) days=31 ;;  
        9) days=30 ;;  
        09) days=30 ;;  
        10) days=31 ;;  
        11) days=30 ;;  
        12) days=31 ;;  
        *) days=-1;;  
    esac  
  
    # find out if it is a leap year or not  
  
    if [ $mm -eq 2 ]; then # if it is feb month then only check of leap year  
        if [ $((yy % 4)) -ne 0 ] ; then  
            : #  not a leap year : means do nothing and use old value of days  
        elif [ $((yy % 400)) -eq 0 ] ; then  
            # yes, it's a leap year  
            days=29  
        elif [ $((yy % 100)) -eq 0 ] ; then  
            : # not a leap year do nothing and use old value of days  
        else  
            # it is a leap year  
            days=29  
        fi  
    fi  
  
    #echo $days  
  
    # if day is negative (<0) and if day is more than   
    # that months days then day is invaild  
    if [ $dd -le 0 -o $dd -gt $days ]; then  
        #echo "$dd day is invalid"  
        return 3  
    fi  
  
    # if no error that means date dd/mm/yyyy is valid one  
    #echo "$dd/$mm/$yy is a vaild date"  
    #echo "$yy-$mm-$dd is a valid date"  
    #echo "valid"  
    return 0  
}  
  
# usage: days_of_month <mm> <yyyy>  
# ��ȡyyyy��mm�µ�������ע�����˳��  
# ���磺days_of_month 2 2007 �����28  
days_of_month()  
{  
    # store day, month and year  
    mm=$1  
    yy=$2  
  
    # store number of days in a month  
    days=0  
  
    # get day, month and year  
    #echo -n "Enter day (dd) : "  
    #read dd  
  
    #echo -n "Enter month (mm) : "  
    #read mm  
  
    #echo -n "Enter year (yyyy) : "  
    #read yy  
  
    # if month is negative (<0) or greater than 12   
    # then it is invalid month  
    if [ $mm -le 0 -o $mm -gt 12 ]; then  
        #echo "$mm is invalid month."  
        echo -1  
        return 1  
    fi  
  
    # Find out number of days in given month  
    case $mm in   
        1) days=31;;  
        01) days=31;;  
        2) days=28 ;;  
        02) days=28 ;;  
        3) days=31 ;;  
        03) days=31 ;;  
        4) days=30 ;;  
        04) days=30 ;;  
        5) days=31 ;;  
        05) days=31 ;;  
        6) days=30 ;;  
        06) days=30 ;;  
        7) days=31 ;;  
        07) days=31 ;;  
        8) days=31 ;;  
        08) days=31 ;;  
        9) days=30 ;;  
        09) days=30 ;;  
        10) days=31 ;;  
        11) days=30 ;;  
        12) days=31 ;;  
        *) days=-1;;  
    esac  
  
    # find out if it is a leap year or not  
  
    if [ $mm -eq 2 ]; then # if it is feb month then only check of leap year  
        if [ $((yy % 4)) -ne 0 ] ; then  
            : #  not a leap year : means do nothing and use old value of days  
        elif [ $((yy % 400)) -eq 0 ] ; then  
            # yes, it's a leap year  
            days=29  
        elif [ $((yy % 100)) -eq 0 ] ; then  
            : # not a leap year do nothing and use old value of days  
        else  
            # it is a leap year  
            days=29  
        fi  
    fi  
  
    echo $days  
}  

