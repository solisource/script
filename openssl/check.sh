#! /bin/bash

echo "please input a key"
read key
echo $key > key
md5sum key
rm -rf key

