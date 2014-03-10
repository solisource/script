#! /bin/bash

echo "Gen a p.key and pub.key: y/n?"
read gen
if [ $gen == "y" ] ; then
	## Gen a p.key(si yao)
	openssl genrsa -out p.key  4256
	
	## view pub.key(gong yao) from p.key
	openssl rsa -in p.key -pubout -out pub.key
fi

echo "Please key jiam-fd jiem-fd jiam-d jiem-d :"
read key1
echo "Please input a file:"
read file

if [ $key1 == "jiam-fd" ] ; then
	openssl rsautl -inkey pub.key -pubin -encrypt -in $file -out $file.out
fi
if [ $key1 == "jiem-fd" ] ; then
	openssl rsautl -inkey p.key -decrypt -in $file -out $file.out
fi
if [ $key1 == "jiam-d" ] ; then
	openssl enc -aes-256-ecb -e -pass pass:p.key -in $file -out $file.out
fi
if [ $key1 == "jiem-d" ] ; then
	openssl enc -aes-256-ecb -d -pass pass:p.key -in $file -out $file.out
fi

