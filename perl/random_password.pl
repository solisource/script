#!/usr/bin/perl

$maxLenth=8;
@a = (0..9,'$','%','a'..'z','A'..'Z','-','+','_');

$password = join '', map { $a[int rand @a] } 0..($maxLenth-1);
print "$password\n";
