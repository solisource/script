#! /bin/tclsh85.exe

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
incr a 5
puts $jin

