#!/bin/sh  
  
# TODO: ע�����datetime.sh��ʵ��λ�ø��� #һ�����ַ�ʽ����Bash�ű�
#. ./time.sh  
source ./time.sh
  
date
echo "��ǰʱ�䣨date����$(date)"  
#echo "��ǰʱ�䣨date����date"  
echo "���죨yesterday����$(yesterday)"  
echo "���죨today����$(today)"  
echo "���ڣ�now����$(now)"  
echo "���ڣ�curtime����$(curtime)"  
echo "���£�last_month����$(last_month)"  
echo "���£�last_month_packed����$(last_month_packed)"  
echo "���µ�һ�죨first_date_of_last_month����$(first_date_of_last_month)"  
echo "�������һ�죨last_date_of_last_month����$(last_date_of_last_month)"  
echo "�������ڼ���day_of_week����$(day_of_week)"  
echo "�ϸ�Сʱ��last_hour����$(last_hour)"  
echo "��ǰ��Сʱ��the_hour����$(the_hour)"  
echo "��ǰ�ķ��ӣ�the_minute����$(the_minute)"  
echo "��ǰ�����ӣ�the_second����$(the_second)"  
echo "��ǰ����ݣ�the_year����$(the_year)"  
echo "��ǰ���·ݣ�the_month����$(the_month)"  
echo "��ǰ�����ڣ�the_date����$(the_date)"  
echo "ǰ�죨days_ago 2����$(days_ago 2)"  
echo "���죨days_ago -1����$(days_ago -1)"  
echo "���죨days_ago -2����$(days_ago -2)"  
echo "ʮ��ǰ�����ڣ�days_ago 10����$(days_ago 10)"  
echo "���ĵ��������ڣ�chinese_date_and_week����$(chinese_date_and_week)"  
echo "������֣�rand_digit����$(rand_digit)"  
echo "������֣�rand_digit����$(rand_digit)"  
echo "��1970������������seconds_of_date����$(seconds_of_date)"  
echo "��1970������������seconds_of_date 2010-02-27����$(seconds_of_date 2010-02-27)"  
echo "��1970������������seconds_of_date 2010-02-27 15:53:21����$(seconds_of_date 2010-02-27 15:53:21)"  
echo "��1970������������Ӧ�����ڣ�date_of_seconds 1267200000����$(date_of_seconds 1267200000)"  
echo "��1970������������Ӧ������ʱ�䣨datetime_of_seconds 1267257201����$(datetime_of_seconds 1267257201)"  
  
if leap_year 2010; then  
    echo "2010��������";  
fi  
if leap_year 2008; then  
    echo "2008��������";  
fi  
if validity_of_date 2007 02 03; then  
    echo "2007 02 03 ���ںϷ�"  
fi  
if validity_of_date 2007 02 28; then  
    echo "2007 02 28 ���ںϷ�"  
fi  
if validity_of_date 2007 02 29; then  
    echo "2007 02 29 ���ںϷ�"  
fi  
if validity_of_date 2007 03 00; then  
    echo "2007 03 00 ���ںϷ�"  
fi  
  
echo "2010��2�µ�������days_of_month 2 2010����$(days_of_month 2 2010)"  
echo "2008��2�µ�������days_of_month 2 2008����$(days_of_month 2 2008)"  
