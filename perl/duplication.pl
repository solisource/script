#!/usr/bin/perl 
use warnings;
use strict;
 
#my @array = ("a","b","c","d","a","d","c");
#my %hash;
#$hash{$_}++ foreach (@array);
#print sort keys %hash;


##!/usr/bin/perl
#use warnings;
#use strict;
 
my @array = ("a","b","c","d","a","d","c");
my %hash;
my @out = grep (!$hash{$_}++, @array);
print @out;


#perl -e 'my @array=(1..10,5,22,57);my %hash;my @new=grep { ++$hash{$_} < 2 } @array;print join " ",@new;'
#uniq @array;
