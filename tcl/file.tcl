#! /bin/tclsh85.exe
#set jin xie
#puts $jin
#ref --> tcl_file_opt
#
#if { [catch {open $someFile w} fid] } {
#  puts stderr "Could not open $someFile for writing\n$fid"
#  exit 1
#}

catch {open "test" r} fid

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
