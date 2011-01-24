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

