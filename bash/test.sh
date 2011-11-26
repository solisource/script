#! /bin/bash

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



