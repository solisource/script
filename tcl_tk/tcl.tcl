#! /bin/tclsh85.exe

#perl, tcl, shell, grep, sed, python, vim 正则表达式

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

#定义数组和使用数组
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

#定义一个列表 [list ...]
#append ,lappend
#llength $jin ；#返回列表的个数
#lindex $jin 0；#返回列表的第1个元素

set jin [list jin da shi xie shu yan]
puts [lindex $jin 2]
puts [lindex $jin 5]

puts [llength [list jin da shi xie shu yan]]

set jin [llength {}]
puts $jin

puts [lindex $argv 0]
puts [lindex $argv 1]
puts [lindex $argv 2]


##################################################################列表相关操作##################################
#构建列表
#List：
#list命令根据它的变元来构建一个列表，因此列表的每个元素都是一个变元。
#如果某个变元包含有特殊字符，list命令将会添加引用以确保它们被解析为结果列表中的单一元素。这种自动引用非常有用。

puts [set x {1 2}]
#=> 1 2
puts [set y foo]
#=> foo
puts [set l1 [list $x "a b" $y]]
#=> {1 2} {a b} foo
puts [set l2 "{$x} {a b} $y"]
#=> {1 2} {a b} foo

#Lappend:
#lappend命令用来将元素添加到列表的末尾。
#lappend的第一个变元为TCL变量名，而余下的变元将作为新的列表元素添加到变量值中。
#与list相同，lappend会保留其变元结构。它还会增加用以对变元值进行分组的花括号，
#以使它们在追加到列表的字符串表达形式之后时仍然保持着作为列表元素的身份。

puts [lappend new 1 2]
#=>1 2
puts [lappend new 3 "4 5"]
#=>1 2 3 {4 5}
puts [set new]
#=>1 2 3 {4 5}

#获取列表元素
#llength 命令返回列表中元素的个数。
puts [llength {a b {c d} "e f g" h}]
#=>5
puts [llength {}]
#=>0
#
#lindex命令返回列表中的一个特定元素。它接收一个索引；列表的索引从0开始计数。
puts [set x {1 2 3}]
puts [lindex $x 1]
#=> 2

#lrange命令返回一个区段的列表元素。它以一个列表及两个索引为变元，它也可以使用end或end-N作为索引：
puts [lrange {1 2 3 {4 5}} 2 end]
puts [lrange {1 2 3 {4 5}} 2 3]
#=>3 {4 5}

#修改列表
#linsert命令在列表值中指定的索引位置插入一个元素。
#如果索引为0或更小，那么元素就会被添加到列表值得前面。
#如果索引等于或大于列表的长度，元素则被追加到尾部。其他情况下，这个元素被插入到位于指定索引位置的元素的前面。
puts [linsert {1 2} 0 new stuff]
#=> new stuff 1 2

#lreplace命令将一个区段的列表元素替换为新的元素。如果你没有指定任何新的元素，那么它就会从列表中删除这些元素。
#注意：linsert和lreplace并不对现有列表进行修改，而是返回一个新的列表值。
puts [set x [list a {b c} e d]]
#=>a {b c} e d
puts [lreplace $x 1 2 B C]
puts [lindex $x 1]
#=>a B C d
puts [lreplace $x 0 0]
#=>{b c} e d

#搜索列表
#lsearch返回列表中一个值得索引，如果值不存在就返回-1.lsearch在搜索中支持模式匹配，
#默认为通配风格的模式匹配，可以使用-exact标志将其禁止。
proc ldelete { list value} {
     set ix [lsearch -exact $list $value]
     if {$ix >=0} {
               return [lreplace $list $ix $ix]
     } else {
               return $list
     }
}

#对列表进行排序
#你可以使用lsort以多种方式对列表进行排序。lsort并不是对原表进行排序，
#而是返回一个新的列表，可以通过-ascii,-dictionary,-integer或-real选项指定基本的排序类型，
#可以通过选项-increasing或-decreasing指定排序方式，
#默认选项设置为-ascii -increasing。ASCII排序使用字符编码，而dictionary排序整合大小写并将数字当作数量来处理。
puts [lsort $x]

#split
#split命令接收一个字符串，并根据指定的字符将其分割转换成一个列表，
#同时它保证其结果具有恰当的列表语法。split命令提供了一种健壮的将输入行转换成恰当的TCL列表的方法：
puts [set line {welch:*:28405:100:Brent   Welch:/usr/welch:/bin/csh}]
puts [split $line :]
#=>welch * 28405 100 {Brent Welch} /usr/welch /bin/csh
puts [lindex [split $line :] 4]
#=>Brent Welch

#Join
#join命令的作用与split相反。
#它接收一个列表值并使用指定的分隔列表元素的字符对其重新进行格式化。
#在处理过程中，它将删除列表的字符串表达中用来组织顶层元素的所有花括号，例如：
puts [join {1 {2 3} {4 5 6}}   :]
#=>1:2 3:4 5 6

#合并两个列表
puts [set jin [list jin da shi]]
puts [set xie [list xie shu yan]]
puts [concat $jin $xie]
#################################################################################################################

#构建动态命令（二次解释）
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



