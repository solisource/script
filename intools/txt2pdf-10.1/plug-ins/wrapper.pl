#!/usr/bin/perl
# Require Perl5
#
# wrapper - use Text::Wrapper - Simple word wrapping routine
#
# by SANFACE Software 02/25/2003
#
# wrapper version 1.0

use strict;
use warnings;
use Getopt::Long;
use File::DosGlob 'glob';
use Text::Wrapper;
 
my $version="1.0";
my $producer="wrapper";
my $companyname="SANFACE Software";
my $SANFACEmail="mailto:sanface\@sanface.com";

my ($help,$verbose,$Version);
my $columns=60; my $body=""; my $paragraph="";

&GetOptions("help"           => \$help,
            "current"        => \$Version,
            "columns:s"      => \$columns,
            "paragraph:s"    => \$paragraph,
            "body:s"         => \$body,
            "verbose"        => \$verbose) || printusage() ;

if($Version) {print "$producer $version\n";exit;}
$help and printusage();

my $wrapper = Text::Wrapper->new(columns => $columns, body_start => $body, par_start => $paragraph);

if (@ARGV) {
  my @files;
  my ($i,$input);

  if ($^O =~ /^MSWin32$/i) {
    foreach $i (@ARGV) {
      if($i=~/\*|\?/) {push @files,glob($i)}
      else {push @files,$i}
      }
    }
  else {@files = @ARGV}
  foreach $input (@files) {
    my $tmpfile=$input.$$;
    open (IN, "$input") || die "$producer: couldn't open input file $input\n";
    open (TEMP, ">$tmpfile") || die "$producer: couldn't open input file $tmpfile\n";
    while (<IN>)
      {
      print TEMP $wrapper->wrap($_);
      }
    close(TEMP);
    close(IN);
    rename $tmpfile,$input;
#    unlink($tmpfile);
    }
  }

sub printusage {
    print <<USAGEDESC;

usage:
        $producer [-options ...] list

where options include:
    -help                        print out this message
    -current                     the program version
    -columns                     number of columns to wrap
    -body                        the text that begins the second and following
                                 lines of a paragraph
    -paragraph                   the text that begins the first line of each
                                 paragraph
    -verbose                     verbose

list:
    with list you can use metacharacters and relative and absolute path name

If you want to know more about this tool, you might want
to read the docs. They came together with $producer!

USAGEDESC
    exit(1);
}
