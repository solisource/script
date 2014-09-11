#! /bin/perl -w

open (F3,">code.c");
open (F1,"<code.as");
foreach $s1 (<F1>)
{  chomp $s1;
   open (F2,"<code.v");
   foreach $s2 (<F2>)
    {
     if ($s2=~m/_0x(\S*)/)
        {$s2=$1;}
     #if ($s1=~m/^$s2/i)
        {$s1=~s/^$s2/code_$s2/ig;}
     #else
     #   {$s1=~s/^\S*//g;}
     }
   close F2;
   print F3 "$s1\n";
}
close F1;
close F3;

open (F2,">code.cc");
open (F1,"<code.c");
foreach $s1 (<F1>)
{  
   if (!($s1=~m/^code_/))
      {$s1=~s/^\S*/        /g};
   if (!($s1=~m/^\s*$/))
      {print F2 "$s1";}
}
close F1;
close F2;

