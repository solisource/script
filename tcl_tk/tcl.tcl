

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



