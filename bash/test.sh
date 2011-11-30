#! /bin/bash

#####################################################################
#source a bash script
#source ./time.sh or ../time.sh

#echo "JIN" >>jin.v
#jin='date'
#echo $jin>>jin.v

#Bash shell for loop
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

#Define a var for csh set a=b or a="b"
#Define a var for bash
a="jin da shi "
jin1=xie
jin2='date'
jin3=`date`
echo 
echo $jin1
echo $jin2
echo $jin3

jin=1
xie=2

#整数比较运算符
#let or ((expr)) 不需要空格，并且支持算术表达式
#expr=>  > >= < <= == !=

#[ expr ] 需要空格，且不支持算术表达式
#expr=>  -gt -ge -le -le -eq -ne

#例子的用法如下：

if (($jin > $xie)) ;then
	echo "jin>xie"
else
	echo "jin<xie"
fi

if let "$jin > $xie" ;then
	echo "jin>xie"
else
	echo "jin<xie"
fi

if [ $jin -gt $xie ] ;then
	echo "jin>xie"
else
	echo "jin<xie"
fi

if (($jin==$xie)) ;then
	echo "jin==xie"
else
	echo "jin!=xie"
fi

if let "$jin==$xie" ;then
	echo "jin==xie"
else
	echo "jin!=xie"
fi

if (($jin!=$xie)) ;then
	echo "jin!=xie"
else
	echo "jin==xie"
fi

if let "$jin!=$xie" ;then
	echo "jin!=xie"
else
	echo "jin==xie"
fi

#字符串测试运算符
#[ -z str] 判断是否为零
#[ -n str] 判断是否为非零
#[ str = str ]
#[ str != str ]

jin=jin
xie=jinfe
if [ -z $jin ] ; then
	echo "is zero"
else
	echo "non zero"
fi

if [ -n $jin ] ; then
	echo "non zero"
else
	echo "is zero"
fi

if [ $jin = $xie ] ; then
	echo "="
else
	echo "!="
fi

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

#逻辑运算符
#[ A -a B ] 相当于&& = [[ && ]]
#[ A -o B ] 相当于|| = [[ || ]]
# ! str           =  ! 
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

if ! [ $jin -gt $xie ] ;then
	echo JIN
else
	echo XIE
fi

#case 
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

#if
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

###################################################################################
#while
#while 
#do
#	echo
#done

###################################################################################
#unitil
#until
#do
#	echo
#done

###################################################################################
#break [n] 强制退出循环体
#continue [n] 退出本次循环继续下一次循环
#exit [n] 退出脚本

###################################################################################
#sleep [n] 暂停脚本执行
sleep 1 

###################################################################################
#shift [n] 
#shift可以用来向左移动[位置参数]-->$@(数组) or $*(字符串)。./test.sh 1 2 3 4 5 6 7 8 #位置参数是指命令后的参数
#Shell脚本的名字 $0 
#第一个参数      $1 | ${1}  数组$@的第1个分量
#第二个参数      $2 | ${2}  数组$@的第2个分量 
#第n个参数       $n | ${n}  数组$@的第n个分量 
#所有参数 $@ 或 $*
#参数个数 $# #位置参数的个数
#shift默认是shift 1
#以下边为例：
	#until [ -z "$3" ]  # Until all parameters used up
	#do
	#  echo "$@"
	#  echo "$*"
	#  echo "$0"
	#  echo ${11} #2位数字的变量名要用{}
	#  echo "------------------------------->$#"
	#  shift 2
	#  echo $#
	#done

###################################################################################
#获取随即数字
#echo $RANDOM
jin=`echo $RANDOM`
echo $jin
xie=$RANDOM
echo $xie

###################################################################################
#sh -x script_name
#export JIN=XIE #设置环境变量

###################################################################################
#While define
#while [ condition ]
#do
#   command1
#   command2
#   command3
#done
x=1
while [ $x -le 30 ]
do
  echo "Welcome $x times"
  #x=$(( ( ($x + 1) * 3 ) / 2 - 1 ))
  x=$(( ($x + 1) * 3 / 2 - 1 ))
done

counter=$1
factorial=2
echo $counter
while [ $counter -gt 0 ]
do
   factorial=$(( $factorial * $counter ))
   counter=$(( $counter - 1 ))
done

echo $factorial
###################################################################################
#Bash 处理文本文件 line by line A,B,C
#A file read
FILE=$2
# read $FILE using the file descriptors
exec 3<&0
exec 0<$FILE
while read line
do
	# use $line variable to process line
	echo $line
done
exec 0<&3

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

###################################################################################
#Alias for bashrc and cshrc
alias qgit='/c/Program\ Files/QGit/qgit.exe'
#alias qgit "/c/Program\ Files/QGit/qgit.exe" #Cshrc

###################################################################################
#Define a var for bashrc and cshrc
alias qgit='/c/Program\ Files/QGit/qgit.exe'
export LESSCHARSET=utf-8
JIN="xie"
JIN=xie
#set jin = xie #Cshrc

###################################################################################
#从标准输入中读入输入
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

###################################################################################
#Bash 定义子函数 ,函数必须先定义后调用
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

JIN_test JIN XIE_SET #JIN-->$1 XIE-->$2 #调用定义的函数
###################################################################################
until [ -z "$1" ]  # Until all parameters used up
do
  echo "$@"
  echo "$*"
  echo "$0"
  echo ${11} #2位数字的变量名要用{}
  echo "------------------------------->$#"
  shift 2
  echo $#
done

	echo $? #返回值0代表成功

###################################################################################
#运算符	描述	示例
#文件比较运算符
# -e filename	如果 filename存在，则为真	[ -e /var/log/syslog ]
# -d filename	如果 filename为目录，则为真	[ -d /tmp/mydir ]
# -f filename	如果 filename为常规文件，则为真	[ -f /usr/bin/grep ]
# -L filename	如果 filename为符号链接，则为真	[ -L /usr/bin/grep ]
# -r filename	如果 filename可读，则为真	[ -r /var/log/syslog ]
# -w filename	如果 filename可写，则为真	[ -w /var/mytmp.txt ]
# -x filename	如果 filename可执行，则为真	[ -L /usr/bin/grep ]
# filename1 -nt filename2	如果 filename1比 filename2新，则为真	[ /tmp/install/etc/services -nt /etc/services ]
# filename1 -ot filename2	如果 filename1比 filename2旧，则为真	[ /boot/bzImage -ot arch/i386/boot/bzImage ]

#字符串比较运算符 （请注意引号的使用，这是防止空格扰乱代码的好方法）
# -z string	如果 string长度为零，则为真	[ -z "$myvar" ]
# -n string	如果 string长度非零，则为真	[ -n "$myvar" ]
# string1 = string2	如果 string1与 string2相同，则为真	[ "$myvar" = "one two three" ]
# string1 != string2	如果 string1与 string2不同，则为真	[ "$myvar" != "one two three" ]

#算术比较运算符
#num1 -eq num2	等于	    [ 3 -eq $mynum ]
#num1 -ne num2	不等于	    [ 3 -ne $mynum ]
#num1 -lt num2	小于	    [ 3 -lt $mynum ]
#num1 -le num2	小于或等于	[ 3 -le $mynum ]
#num1 -gt num2	大于	    [ 3 -gt $mynum ]
#num1 -ge num2	大于或等于	[ 3 -ge $mynum ]

###################################################################################
#正则表达式


exit
