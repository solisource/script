#! /bin/tclsh85.exe

#perl, tcl, shell, grep, sed, python, vim ������ʽ

#�������壺
set a 24
set b 25
set a 24 ; set b 25
set c JIN

#����һ������
lindex {red greed blue purple} 2

#�൱��echo $a
puts $a
puts $a*5
puts [expr $a*5]

#�ѱ�����a��ֵ�ϼ�200-->24+200=224
incr a 200
puts $a

#׷���ַ���ԭ���ַ�֮��û�пո�
append  c DA SHI
puts $c
#׷���ַ���ԭ���ַ�֮���пո����
lappend  c DA SHI
puts $c

unset b
#puts $b

array exists JIN


#set jin xie
#puts $jin
#ref --> tcl_file_opt

#if { [catch {open $someFile w} fid] } {
#  puts stderr "Could not open $someFile for writing\n$fid"
#  exit 1
#}

#�ļ���ز���
catch {open "test" r} fid  ;#�Ƽ���������������ʹ��Ϊû����׽���ļ��������˳�

#set fid [open "test" r]
set a_fid [open "test_" w+]

while { [gets $fid line] != "-1" } {
	puts stdout $line
	puts $line ;# stdout is default
	puts $a_fid $line ;#Write information to test_
}

close $fid
flush $a_fid ;# write from buffer now now!!!!
close $a_fid

#foreach {} {
#}
#
#for {} {
#}

#Simple command:
#        exec /bin/sort -u /tmp/data.in -o /tmp/data.out
#2 process pipeline
#        exec /bin/sort -u /tmp/data.in | /bin/wc -l
#Command with arguments in variables
#        exec /bin/sort -T [file dirname $sorted_name] -o $sorted_name $name
#Command with file globbing
#        eval [list exec ls -l] [glob *.tcl]
#or (preferred from 8.5 onwards)
#        exec ls -l {*}[glob *.tcl]
#Interactive terminal program session (windows, from 8.5 onwards)
#        exec {*}[auto_execok start] your_program <args> 

#eval������һ�����������ִ��TCL�ű���������﷨Ϊ��
#eval
exec cat test
source file.tcl

set jin 5
puts $jin
incr jin 5
puts $jin
incr jin 5
puts $jin
incr jin 5
puts $jin

set jin [array exists JIN]
puts $jin

#array set test ./
#array size test
#array name test

set test_arrays(jin) 0
set test_arrays(xie) 1
puts $test_arrays(xie)
puts $test_arrays(jin)

#���������ʹ������
set test_arrays(jin) jindashi
set test_arrays(jin) {jin da shi}
set test_arrays(xie) xieshuyan
puts $test_arrays(xie)
puts $test_arrays(jin)

puts [array exists test_arrays]
puts [array get test_arrays]
puts [array names test_arrays]
puts [array size test_arrays]

puts $argv0
puts $argv

llength $argv
lindex $argv 2

#����һ���б� [list ...]
#append ,lappend
#llength $jin ��#�����б�ĸ���
#lindex $jin 0��#�����б�ĵ�1��Ԫ��

set jin [list jin da shi xie shu yan]
puts [lindex $jin 2]
puts [lindex $jin 5]

puts [llength [list jin da shi xie shu yan]]

set jin [llength {}]
puts $jin

puts [lindex $argv 0]
puts [lindex $argv 1]
puts [lindex $argv 2]


##################################################################�б���ز���##################################
#�����б�
#List��
#list����������ı�Ԫ������һ���б�����б��ÿ��Ԫ�ض���һ����Ԫ��
#���ĳ����Ԫ�����������ַ���list��������������ȷ�����Ǳ�����Ϊ����б��еĵ�һԪ�ء������Զ����÷ǳ����á�

puts [set x {1 2}]
#=> 1 2
puts [set y foo]
#=> foo
puts [set l1 [list $x "a b" $y]]
#=> {1 2} {a b} foo
puts [set l2 "{$x} {a b} $y"]
#=> {1 2} {a b} foo

#Lappend:
#lappend����������Ԫ����ӵ��б��ĩβ��
#lappend�ĵ�һ����ԪΪTCL�������������µı�Ԫ����Ϊ�µ��б�Ԫ����ӵ�����ֵ�С�
#��list��ͬ��lappend�ᱣ�����Ԫ�ṹ���������������ԶԱ�Ԫֵ���з���Ļ����ţ�
#��ʹ������׷�ӵ��б���ַ��������ʽ֮��ʱ��Ȼ��������Ϊ�б�Ԫ�ص���ݡ�

puts [lappend new 1 2]
#=>1 2
puts [lappend new 3 "4 5"]
#=>1 2 3 {4 5}
puts [set new]
#=>1 2 3 {4 5}

#��ȡ�б�Ԫ��
#llength ������б���Ԫ�صĸ�����
puts [llength {a b {c d} "e f g" h}]
#=>5
puts [llength {}]
#=>0
#
#lindex������б��е�һ���ض�Ԫ�ء�������һ���������б��������0��ʼ������
puts [set x {1 2 3}]
puts [lindex $x 1]
#=> 2

#lrange�����һ�����ε��б�Ԫ�ء�����һ���б���������Ϊ��Ԫ����Ҳ����ʹ��end��end-N��Ϊ������
puts [lrange {1 2 3 {4 5}} 2 end]
puts [lrange {1 2 3 {4 5}} 2 3]
#=>3 {4 5}

#�޸��б�
#linsert�������б�ֵ��ָ��������λ�ò���һ��Ԫ�ء�
#�������Ϊ0���С����ôԪ�ؾͻᱻ��ӵ��б�ֵ��ǰ�档
#����������ڻ�����б�ĳ��ȣ�Ԫ����׷�ӵ�β������������£����Ԫ�ر����뵽λ��ָ������λ�õ�Ԫ�ص�ǰ�档
puts [linsert {1 2} 0 new stuff]
#=> new stuff 1 2

#lreplace���һ�����ε��б�Ԫ���滻Ϊ�µ�Ԫ�ء������û��ָ���κ��µ�Ԫ�أ���ô���ͻ���б���ɾ����ЩԪ�ء�
#ע�⣺linsert��lreplace�����������б�����޸ģ����Ƿ���һ���µ��б�ֵ��
puts [set x [list a {b c} e d]]
#=>a {b c} e d
puts [lreplace $x 1 2 B C]
puts [lindex $x 1]
#=>a B C d
puts [lreplace $x 0 0]
#=>{b c} e d

#�����б�
#lsearch�����б���һ��ֵ�����������ֵ�����ھͷ���-1.lsearch��������֧��ģʽƥ�䣬
#Ĭ��Ϊͨ�����ģʽƥ�䣬����ʹ��-exact��־�����ֹ��
proc ldelete { list value} {
     set ix [lsearch -exact $list $value]
     if {$ix >=0} {
               return [lreplace $list $ix $ix]
     } else {
               return $list
     }
}

#���б��������
#�����ʹ��lsort�Զ��ַ�ʽ���б��������lsort�����Ƕ�ԭ���������
#���Ƿ���һ���µ��б�����ͨ��-ascii,-dictionary,-integer��-realѡ��ָ���������������ͣ�
#����ͨ��ѡ��-increasing��-decreasingָ������ʽ��
#Ĭ��ѡ������Ϊ-ascii -increasing��ASCII����ʹ���ַ����룬��dictionary�������ϴ�Сд�������ֵ�������������
puts [lsort $x]

#split
#split�������һ���ַ�����������ָ�����ַ�����ָ�ת����һ���б�
#ͬʱ����֤��������ǡ�����б��﷨��split�����ṩ��һ�ֽ�׳�Ľ�������ת����ǡ����TCL�б�ķ�����
puts [set line {welch:*:28405:100:Brent   Welch:/usr/welch:/bin/csh}]
puts [split $line :]
#=>welch * 28405 100 {Brent Welch} /usr/welch /bin/csh
puts [lindex [split $line :] 4]
#=>Brent Welch

#Join
#join�����������split�෴��
#������һ���б�ֵ��ʹ��ָ���ķָ��б�Ԫ�ص��ַ��������½��и�ʽ����
#�ڴ�������У�����ɾ���б���ַ��������������֯����Ԫ�ص����л����ţ����磺
puts [join {1 {2 3} {4 5 6}}   :]
#=>1:2 3:4 5 6

#�ϲ������б�
puts [set jin [list jin da shi]]
puts [set xie [list xie shu yan]]
puts [concat $jin $xie]
#################################################################################################################

#������̬������ν��ͣ�
set jin {puts "jin xie"}
puts $jin
puts [lappend jin "jin xie"]
puts "jin xie"
puts $jin
#eval $jin

#puts [expr tcl::mathfunc::abc(-2)]
#

regsub -all -- {(a+)(ba*)} aabaabxab {z\2} x
puts $x

puts [lindex [split xbaybz ab] 1]
puts [split xbaybzabset  "ba"]
puts [split xbaybzabset  ""]
puts [split xbaybzabset  {}]
puts [split xbaybzabset  (ab)]



