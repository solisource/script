#! /bin/bash

#echo "Please key jiam-d jiem-d :"
#read key1
export key1=$1

if [ $key1 == "jiam-d" ] ; then
	openssl enc -aes-256-ecb -e -pass pass:p.key -in /e/licai/p2p.xlsx -out /e/licai/p2p.xlsx.p
	openssl enc -aes-256-ecb -e -pass pass:p.key -in /e/licai/user.doc -out /e/licai/user.doc.p
	rm -rf /e/licai/p2p.xlsx /e/licai/user.doc
fi
if [ $key1 == "jiem-d" ] ; then
	openssl enc -aes-256-ecb -d -pass pass:p.key -in /e/licai/p2p.xlsx.p -out /e/licai/p2p.xlsx
	openssl enc -aes-256-ecb -d -pass pass:p.key -in /e/licai/user.doc.p -out /e/licai/user.doc
	rm -rf /e/licai/p2p.xlsx.p /e/licai/user.doc.p
fi

