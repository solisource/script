#! /bin/bash

echo $* > key
md5sum key
rm -rf key

