#! /bin/tclsh85.exe

#变量定义：
set a 24
set b 25
set a 24 ; set b 25
set c JIN

#创建一个数组
lindex {red greed blue purple} 2

#相当于echo $a
puts $a
puts $a*5
puts [expr $a*5]

#把变量名a的值上加200-->24+200=224
incr a 200
puts $a

#追加字符和原有字符之间没有空格
append  c DA SHI
puts $c
#追加字符和原有字符之间有空格相隔
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

#文件相关操作
catch {open "test" r} fid  ;#推荐这种做法，不会使因为没有扑捉到文件而意外退出

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

#eval命令是一个用来构造和执行TCL脚本的命令，其语法为：
#eval
exec cat test
source file.tcl

set jin 5
puts $jin
incr a 5
puts $jin

