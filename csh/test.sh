#! /bin/csh

#Csh 设置变量带"="(一般变量)
#但环境变量的定义setenv 则不需要使用"="进行赋值
  #set 一般变量名=变量值 
  #set 一般变量名=(变量值1 变量值2 变量值3 ...)  (通常定义path变量这么用)
  #setenv 环境变量名 环境变量值
  #unset 变量名 #取消变量的定义

#仅仅设置一个变量，但并没有给他赋值
set JIN 
#仅仅设置了变量JIN XIE但都没有给其赋值
set JIN XIE 
set JIN=xie
echo $JIN

source /bin/jin.cshrc
. /bin/jin.cshrc

umask 022 #755

alias g "gvim"

if (-f ~/.alias) then
	source ~/.alias
endif
if (-f ~/.cshrc.my) then
	source ~/.cshrc.my
endif

setenv SITE_INFO "RTK"  #相当于Bash中的export PATH=/bin/local/bin:$PATH
setenv SITE_INFO RTK    #相当于Bash中的export PATH=/bin/local/bin:$PATH
						#export SITE_INFO=RTK
setenv WORK_ENV realsil
set history=100

#Set 设置path变量
set path=(/usr/cad/utility /usr/local/bin /bin .)
set path=(~ $path /project/perl/script)

#启用rmstar变量
set rmstar #表示在执行(rm *)的时候会提醒

#使用 noclobber 防止意外覆盖文件
set noclobber

#使用 autolist 启用自动命令补齐,自动 Tab 补齐
set autolist

#如果同时设置 addsuffix shell 变量和自动 Tab 补齐，
#那么在找到匹配时 tcsh 会在文件夹后面加上一个 / 字符，
#这样就更容易区分出文件夹。它在一般文件后面加一个空格。
#在清单 5 所示的情况中，有一个名为 documents 的文件夹，
#这个文件夹中有一个名为 deliverables 的文件；
#用户输入 do[TAB]，shell 就会显示 documents/。
#如果取消 addsuffix 变量，tcsh 就只显示 documents，
#这对于判断 documents 是一般文件还是文件夹很不方便。
set addsuffix

#使用 fignore 避免在 Tab 补齐期间显示源代码文件
#set autolist
#ls
memory.h memory.cpp kernel.c memory.o kernel.o
#rm m[TAB]
memory.h memory.cpp memory.o
# set fignore=(.c .cpp .h)
# rm m[TAB]
memory.o

set #打印所有的用set定义的变量名字以及值
printenv #打印所有用setenv定义的变量名和值

unset
unalias
unsetenv

