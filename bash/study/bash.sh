#! /bin/bash

#####################################################################
# bash study
#Bash 设置变量的时候都带"="包括一般的变量和环境变量
	#变量名=变量值
	#export 环境变量名=环境变量值
	#export 环境变量名=环境变量值1:环境变量值2 (通常定义PATH变量这么用)
#####################################################################

##--------------------------------------------------------------------------------------------------
##Bash shell for loop
for test in jin da shi xie shu yan jin zi wei #list for var
do
	echo "test --> $test"
done

for test in jin da shi xie shu yan jin zi wei ; do #list for var
	echo "test --> $test"
done

for test in ./test.sh ./jin.v; do #list for var
	cat $test
done

## define a array and for loop
arr=("a" "b" "c")  
echo "arr is (${arr[@]})"  
echo "item in array:"  

for i in ${arr[@]}  
do 
	echo "$i"  
done

## 脚本输入的所有参数 $*
echo "参数,/$*表示脚本输入的所有参数："  
for i in $*
do  
	echo $i  
done

for thing in $@
do
    echo you typed $thing.
done

# 指定批处理文件 * 去匹配
echo '处理文件 /proc/sys/net/ipv4/conf/*/accept_redirects：'  
for File in /proc/sys/net/ipv4/conf/*/accept_redirects
do
	echo $File  
done

# 直接指定循环内容
echo "直接指定循环内容"  
for i in f1 f2 f3 
do
	echo $i  
done

# 用 C语言的方法去循环
echo "C 语法for 循环:"  
#for (( i=0; i<10; ++i))
for (( i=0; i<10; i++))
do  
	echo $i  
done

for x in ../* mystuff/*
do
	echo $x is a silly file
done

for x in /var/log/*
do
    echo `basename $x` is a file living in /var/log
done

##--------------------------------------------------------------------------------------------------
## While and Until
#while [ condition ]
#do
#   command1
#   command2
#   command3
#done
x=1
while [ $x -le 5 ]
do
	echo "Welcome $x times"
	x=$(( $x + 1 )) #算术运算
done

counter=5
factorial=1
while [ $counter -gt 0 ]
do
   factorial=$(( $factorial * $counter )) #算术运算
   counter=$(( $counter - 1 )) #算术运算
done
echo $factorial

x=1
while [ $x -le 30 ]
do
  echo "Welcome $x times"
  #x=$(( ( ($x + 1) * 3 ) / 2 - 1 ))
  x=$(( ($x + 1) * 3 / 2 - 1 ))
done

##格式一
#while 条件;
#do
#    语句
#done

##格式二 死循环
#while true
#do
#    语句
#done

##格式三 死循环
#while :
#do
#    语句
#done

##格式四 死循环
#while [ 1 ]
#do
#    语句
#done

##格式五 死循环
#while [ 0 ]
#do
#    语句
#done

##--------------------------------------------------------------------------------------------------
## Case
jin=gz
#case "${x##*.}" in
case $jin in
      gz)
            echo "gz"
            ;;
      bz2)
            echo "bz2"
            ;;
      *)
            echo "Archive format not recognized."
            exit
            ;;
esac

jin=jin
case $jin in
	jin)
		echo jin++
		;;
	xie)
		echo xie
		;;
	zi)
		echo zi
		;;
	wei)
		echo wei
		;;
	*)
		echo non
		;;
esac

##--------------------------------------------------------------------------------------------------
## 循环控制命令 break, continue, exit
#break [n] 强制退出循环体
#continue [n] 退出本次循环继续下一次循环
#exit [n] 退出脚本

##--------------------------------------------------------------------------------------------------
##条件运算 if
jin=jin
xie=jinfe

if [ $jin != $xie ] ; then
	echo "!="
else
	echo "="
fi

if [ $jin != $xie ] ; then
	echo "!="
else
	echo "="
fi

jin=2
xie=2
if [ $jin -lt $xie ] ;then
	echo jin
elif [ $jin -ge $xie ] ;then
	echo NO
fi

jin=0
xie=0
if [ $jin -gt $xie ] ;then
	echo "JIN>xie"
elif [ $jin -eq $xie ] ;then
	echo "JIN=xie"
elif [ $jin -ne $xie ] ;then
	echo "jin!=xie"
else
	echo non++++
fi

##--------------------------------------------------------------------------------------------------
##sleep [n] 暂停脚本执行
sleep 1

##--------------------------------------------------------------------------------------------------
##获取随即数字
#echo $RANDOM
jin=`echo $RANDOM`
echo $jin
xie=$RANDOM
echo $xie

##--------------------------------------------------------------------------------------------------
## bash设置环境变量
#export JIN=XIE #设置环境变量

##--------------------------------------------------------------------------------------------------
##1, 变量定义
jin=xie
xie=jin
jin="xie"
xie="jin"
a="jin da shi "
jin1=xie
jin2='date'
jin3=`date`
arr=("a" "b" "c") #定义数组

##--------------------------------------------------------------------------------------------------
##2,变量比较（字符串比较，数字比较）
#字符串比较运算符 （请注意引号的使用，这是防止空格扰乱代码的好方法）
#-z string	        如果 string长度为零，则为真	        [ -z "$myvar" ]
#-n string	        如果 string长度非零，则为真	        [ -n "$myvar" ]
#string1 = string2	如果 string1与 string2相同，则为真	[ "$myvar" = "one two three" ]
#string1 != string2	如果 string1与 string2不同，则为真	[ "$myvar" != "one two three" ]

#算术比较运算符
#num1 -eq num2	等于	    [ 3 -eq $mynum ] 
#num1 -ne num2	不等于	    [ 3 -ne $mynum ] 
#num1 -lt num2	小于	    [ 3 -lt $mynum ] 
#num1 -le num2	小于或等于	[ 3 -le $mynum ] 
#num1 -gt num2	大于	    [ 3 -gt $mynum ] 
#num1 -ge num2	大于或等于	[ 3 -ge $mynum ] 

##--------------------------------------------------------------------------------------------------
##3，文件测试运算符号
#-d file file存在并且是一个目录
#-e file file存在
#-f file file存在并且是普通文件
#-r file file有读权限
#-s file file存在且不为空
#-w file file写权限
#-x file file有执行权限
#-a FILE ] 如果 FILE 存在则为真。
#[ -b FILE ] 如果 FILE 存在且是一个块特殊文件则为真。
#[ -c FILE ] 如果 FILE 存在且是一个字特殊文件则为真。
#[ -d FILE ] 如果 FILE 存在且是一个目录则为真。
#[ -e FILE ] 如果 FILE 存在则为真。
#[ -f FILE ] 如果 FILE 存在且是一个普通文件则为真。
#[ -g FILE ] 如果 FILE 存在且已经设置了SGID则为真。
#[ -h FILE ] 如果 FILE 存在且是一个符号连接则为真。
#[ -k FILE ] 如果 FILE 存在且已经设置了粘制位则为真。
#[ -p FILE ] 如果 FILE 存在且是一个名字管道(F如果O)则为真。
#[ -r FILE ] 如果 FILE 存在且是可读的则为真。
#[ -s FILE ] 如果 FILE 存在且大小不为0则为真。
#[ -t FD ] 如果文件描述符 FD 打开且指向一个终端则为真。
#[ -u FILE ] 如果 FILE 存在且设置了SUID (set user ID)则为真。
#[ -w FILE ] 如果 FILE 如果 FILE 存在且是可写的则为真。
#[ -x FILE ] 如果 FILE 存在且是可执行的则为真。
#[ -O FILE ] 如果 FILE 存在且属有效用户ID则为真。
#[ -G FILE ] 如果 FILE 存在且属有效用户组则为真。
#[ -L FILE ] 如果 FILE 存在且是一个符号连接则为真。
#[ -N FILE ] 如果 FILE 存在 and has been mod如果ied since it was last read则为真。
#[ -S FILE ] 如果 FILE 存在且是一个套接字则为真。

##--------------------------------------------------------------------------------------------------
##4.1，命令行变量
#$0 $1 $2 ...
#./jin.sh jin xie da ---> $0=./jin.sh $1=jin $2=xie $3=da ...

##4.2，命令行变量(数组)
#./jin.sh jin xie da ---> $0=./jin.sh $1=jin $2=xie $3=da ...
#$# = 3 ：命令行输入的所有变量的数量
#$* = jin xie da : 输入的所有变量(数组)
#$@ = jin xie da : 输入的所有变量(数组)

##--------------------------------------------------------------------------------------------------
##5，逻辑运算符
#&& ==> [[ && ]]
#|| ==> [[ || ]]
#-a 双方都成立（and） 逻辑表达式 –a 逻辑表达式 // [ A -a B ] 相当于 && = [[ && ]]
#-o 单方成立（or） 逻辑表达式 –o 逻辑表达式    // [ A -o B ] 相当于 || = [[ || ]]

jin=1
xie=2
wei=3
if [ $jin -gt $xie -a $jin -lt $wei ] ;then
	echo "jin"
else
	echo "+++"
fi

if [ $jin -gt $xie -o $jin -lt $wei ] ;then
	echo "jin"
else
	echo "+++"
fi

if [[ $jin -gt $xie && $jin -lt $wei ]] ;then
	echo "jin"
else
	echo "+++"
fi

if [[ $jin -gt $xie || $jin -lt $wei ]] ;then
	echo "jin"
else
	echo "+++"
fi

##--------------------------------------------------------------------------------------------------
##6，变量是否存在
jin=1
if [ $jin ] 
then
	echo "Var jin = $jin"
else
	echo "non var jin exist"
fi

##--------------------------------------------------------------------------------------------------
##shift [n]，mv location var n bit
#shift可以用来向左移动[位置参数]-->$@(数组) or $*(字符串)。./test.sh 1 2 3 4 5 6 7 8 #位置参数是指命令后的参数
#Shell脚本的名字 $0 
#第一个参数      $1 | ${1}  数组$@的第1个分量
#第二个参数      $2 | ${2}  数组$@的第2个分量 
#第n个参数       $n | ${n}  数组$@的第n个分量 
#所有参数 $@ 或 $*
#参数个数 $# #位置参数的个数
#shift默认是shift 1

#以下边为例：
until [ -z "$*" ]  # Until all parameters used up
do
  echo "$@"
  echo "$*"
  echo "$0"
  shift 1
  echo $#
done

##--------------------------------------------------------------------------------------------------
##Bash 处理文本文件 line by line A,B,C
#A file read
FILE=$2
# read $FILE using the file descriptors
exec 3<&0  #把标准输入重定向到3
exec 0<$FILE #把FILE重定向到0，也就是把FILE重定向到3
while read line
do
	# use $line variable to process line
	echo $line
done
exec 0<&3 #把3重定向到0，也可以写成exec 3>&0

#有空格时不能使用
for i in `cat jin.v`
do
echo $i
done

#B file read
cat jin.v | while read oneline #oneline is a var name
do
    echo $oneline
done

#C file read
while read line  #line is a var name
do
   str='drop-->'$line
   #echo $str>>xie.v
   echo $str
done<jin.v

#有空格时不能使用
				#读取文件内容到变量中
				filecontent=`cat xie.v`
				echo $filecontent
				#取得文件内容的每一行
				for fileline in "$filecontent"
				  do
				    echo $fileline
				  done
				#写内容到文件中
				#echo $filecontent >> test.txt


##--------------------------------------------------------------------------------------------------
##Alias for bashrc and cshrc
alias qgit='/c/Program\ Files/QGit/qgit.exe'
#alias qgit "/c/Program\ Files/QGit/qgit.exe" #Cshrc

##Define a var for bashrc and cshrc
alias qgit='/c/Program\ Files/QGit/qgit.exe'
export LESSCHARSET=utf-8

##--------------------------------------------------------------------------------------------------
##从标准输入中读入输入
#read [option] A B C D #A,B,C,D为变量名称，输入以空格分开一次存入变量中
#A Way
read NAME1 NAME2 NAME3  #从标准输入中读入输入,此方式是以空格分开存入变量中
echo $NAME1
echo $NAME2
echo $NAME3

#B Way
read 
echo $REPLY #read 后不跟参数则为默认存入$REPLY变量中

#C Way #array
read -a NAME  #-a (a--->array) 把输入以空格分开，按顺序依次存入数组NAME中，
echo ${NAME[0]}
echo ${NAME[1]}
echo ${NAME[2]}

##--------------------------------------------------------------------------------------------------
##Bash 定义子函数 ,函数必须先定义后调用
#function_name () or function function_name #如果不加function关键字则要加() (他们两个必须有一个出现)
#{
#command
#}

#test_name () {
function test_name {
echo "JIN test for function name"
}

test_name  #调用定义的子函数

#往Bash sub function中传递参数
JIN_test () {
	echo $1
	echo $2 
	JIN=$(echo $2  | sed  's/XIE/XIE___XXX/')
	#var=$(echo $var | sed 's/./\\&/g')
	echo "$JIN Google"
}

exit
