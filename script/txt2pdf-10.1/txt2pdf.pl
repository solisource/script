#!/usr/bin/perl
#
# Require Perl5
#
# txt2pdf -- Text to PDF
#
# by SANFACE Software <sanface@sanface.com> 10th November 2009
#
# txt2pdf 10.x is shareware.
# $49 for the Personal Edition
# This means that you use the software for Personal purpose (home user, not
# inside a company)
# 
# This is the price for the Enterprise Edition:
# $140 (US) for 1 core computer 
# + $5 for every phisical core
# e.g. 6 phisical core server fee is: $140 + 5 x $5 = $165
#
# You can upgrade txt2pdf 7.x, 8.x, 9.x to the new version with the discount of
# the amount you previously paid + a fix fee: 
# $30 for 9.x 
# $40 for 8.x 
# $55 for 7.x 
#
# Try it for 30 days.
# If you decide to continue using it, register NOW via a SECURE SERVER
# your PE (Personal Edition, only for a personal use) at
# http://www.regsoft.net/purchase.php3?productid=49173
# your EE (Enterprise Edition, for a use inside a company) at
# http://www.regsoft.net/purchase.php3?productid=49174
# or contact SANFACE Software sanface@sanface.com
#
# This is version 10.1
#
# use strict;
use Getopt::Long;
use File::Basename;
use File::Find;
use File::DosGlob 'glob';

my $fpos=0;
my $version="10.1";
my $producer="txt2pdf";
my $producer1="txt2pdf";
my $PRODUCERCFG="TXT2PDFCFG";
my $SECURESERVER="http://www.regsoft.net/purchase.php3?productid=49173";
my $txt2pdfHome="http://www.sanface.com/$producer.html";
my $pageNO;
my $lineNO;
# Default paper is Letter size
my $pageHeight=792;
my $pageWidth=612;
my @location;
my @pageObj;
my $fontn=1;
my $lines=0; my $bflines=0;
my $buf="";  my $buf1="";
my $input=""; my $output=""; my $saveinput;
my $elem="";
my $configure=$producer.".cfg";
my $help=0; my $default=0; my $verbose=0; my $test=0; my $Version;
my $border=0; my $paper="";
my $landscape=0; my $list=0;
my $npage=0; my $stdin=0;
my $transition=""; my $motion=""; my $direction=0; my $dimension=""; my $rotate=0;
my $bgdesign=""; my $fgdesign=""; my $epdi=0; my $epdn=0; my @epd;
my $nfonts=0; my $nttfonts=0; my $ttfile="";
my (@nodeffont,@nodeffontdescriptor,@unicodedescriptor,@fontname);
my (@color,@fontmark,@inputmod,@outputmod);
my $colori=0; my $fontmarki=0;
my $obj=0;
my $Tpages=0; my $resources=0; my $root=0; my $info=0;
my $BF; my $EF;
my @annots;
my $title="";
my $counter;
my $recursive=""; my $match="";
my $line; my $page; my $everyfont; my $linkuse=0;
my $companyname="SANFACE Software";
my $pdfdir=""; my $txtdir=""; my $newoutput; my $newinput;
my $Demo="This is a demo version of $producer1 v.$version\nDeveloped by $companyname http://www.sanface.com/\nAvailable at $txt2pdfHome\n\n";
my $SANFACEmail="mailto:sanface\@sanface.com";
my $font; my $times = 0; my $timef = 0; my $loop=1;
my $Priority = "3 (Normal)"; my $MSPriority="Normal";

$configure = $ENV{$PRODUCERCFG} if (! -e "$configure");

&GetOptions("configure=s"  => \$configure,
            "help"         => \$help,
            "default"      => \$default,
            "landscape"    => \$landscape,
	    "list=s"       => \$list,
            "paper=s"      => \$paper,
            "npage"        => \$npage,
            "recursive=s"  => \$recursive,
            "match=s"      => \$match,
            "border"       => \$border,
            "pdfdir=s"     => \$pdfdir,
            "txtdir=s"     => \$txtdir,
            ""             => \$stdin,
            "current"      => \$Version,
            "verbose"      => \$verbose,
            "test"         => \$test) || printusage() ;
my @elem=("tmpdir","author","creator","keywords","subject","title","landscape",
          "paper","font","lines","tab","pointSize","vertSpace","transition",
          "npage","colour","fontmark","beginfile","endfile","border","bgdesign","fgdesign",
          "pagemode","pagelayout","rotate","typeencoding","withextension",
          "sleep","pdfdir","txtdir","viewerpreferences","fit","list","zoom",
	  "inputmod","outputmod","pdfversion","annotationtext","fontfile",
	  "linkuse","noid",
	  "japanese","tradchinese","simplchinese","korean","pagemark",
          "underline","prepdf");
my %option=(tmpdir             => './',
            author             => '',
            creator            => '',
            keywords           => '',
            subject            => '',
            title              => '',
	    pdfversion         => '1.2',
            landscape          => '0',
            paper              => 'letter',
            font               => 'Courier',
            npage              => '0',
            lines              => '',
            pointSize          => '10',
            vertSpace          => '12',
            transition         => '',
            tab                => '8',
            colour             => '',
            fontmark           => '',
            beginfile          => '',
            endfile            => '',
            border             => '0',
            annotationtext     => '',
            linkuse            => '0',
            noid               => '0',
	    fontfile           => '',
            inputmod           => '',
            outputmod          => '',
            bgdesign           => '',
            fgdesign           => '',
            pagemode           => '',
            pagelayout         => '',
            typeencoding       => 'default',
            rotate             => '0',
            withextension      => '0',
            sleep              => '0',
            pdfdir             => '',
            txtdir             => '',
	    viewerpreferences  => '',
            fit                => '0',
            list               => '',
            zoom	       => '0',
	    japanese	       => '',
	    tradchinese	       => '',
	    simplchinese       => '',
	    korean	       => '',
	    pagemark	       => '',
            underline          => '',
            prepdf             => '');

if($Version) {print "$producer1 $version\n";exit;}
$help and printusage();
$test and $verbose=1;
$default and defaultparams();
my $sec=0; my $min=0; my $hour=0; my $mday=0; my $mon=0; my $year=0;
my $wday=0; my $yday=0; my $isdst=0; my $date="";
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
++$mon;                              # $mon is 0..11
$year += 1900;
my $tmpelem; my $var;
if (-e $configure) {
  $verbose and print "Processing $configure configuration file\n";
  open (CNF, "$configure");
  while (<CNF>) {
    s/\t/ /g;        #replace tabs by space
    next if /^ *\#/; #ignore comment lines
    next if /^ *$/;  #ignore empty lines
    foreach $elem (@elem) {
      if (/ *$elem *: *(.*)/i) {
        $tmpelem=$1;
        if ($tmpelem=~/#!ENV#(.*)#!\/ENV#/) {
          $var=$ENV{$1};
          $tmpelem=~s/#!ENV#(.*)#!\/ENV#/$var/;
          }
        $option{$elem}=$tmpelem;
	$verbose and print "$elem is set\t\t$tmpelem\n";
        }
      }
    }
  close(CNF);
  } else {
  &Warning("to set your $producer1 configuration file you can use:\n$producer.cfg or -configure your_$producer.cfg or $PRODUCERCFG\nElse the program will use the default parameters\n-default to see the default parameters\n")
  }
$list and $option{'list'}=$list;
if ($option{'list'}) {
  open (LIST, "$option{'list'}") ||
     die "txt2pdf: couldn't open list file $option{'list'}\n";
  while (<LIST>) {
    s/\t/ /g;        #replace tabs by space
    next if /^ *\#/; #ignore comment lines
    next if /^ *$/;  #ignore empty lines
    push @ARGV,$_;
    }
  close(LIST);
  }
if ($option{'inputmod'}) {
  open (INPUTMOD, "$option{'inputmod'}") ||
     die "txt2pdf: couldn't open list file $option{'inputmod'}\n";
  while (<INPUTMOD>) {
    s/\t/ /g;        #replace tabs by space
    next if /^ *\#/; #ignore comment lines
    next if /^ *$/;  #ignore empty lines
    push @inputmod,$_;
    }
  close(INPUTMOD);
  }
if ($option{'outputmod'}) {
  open (OUTPUTMOD, "$option{'outputmod'}") ||
     die "txt2pdf: couldn't open list file $option{'outputmod'}\n";
  while (<OUTPUTMOD>) {
    s/\t/ /g;        #replace tabs by space
    next if /^ *\#/; #ignore comment lines
    next if /^ *$/;  #ignore empty lines
    push @outputmod,$_;
    }
  close(OUTPUTMOD);
  }
$paper and $option{'paper'}=$paper;
$landscape and $option{'landscape'}=$landscape;
$npage and $option{'npage'}=$npage;
$border and $option{'border'}=$border;
$pdfdir and $option{'pdfdir'}=$pdfdir;
$txtdir and $option{'txtdir'}=$txtdir;
print <<FEE;

This is an UNREGISTERED version of $producer1.
Registration fee is \$39 for the Personal Edition.
From \$130 for the Enterprise Edition.
Register NOW via a SECURE SERVER at
$SECURESERVER
or contact $companyname $SANFACEmail


FEE


if ($option{'fontfile'}) {
  open (FONTFILE,$option{'fontfile'}) ||
    die qq!txt2pdf: couldn't open input file $option{'fontfile'}\n!;
  while(<FONTFILE>) {
    if (/^#!font#$/../^#!\/font#$/) {
      /^#!font#$/ and next;
      if(/^#!\/font#$/) {
        if($nodeffontdescriptor[$nfonts]!~/#!ttfile#(.*)#!\/ttfile#/) {
	  $nttfonts++;
	  }
	$nfonts++;
	next;
	}
      if(/\/Name (\/F\d+)/) {$fontname[$nfonts]=$1}
      if (/^#!fontunicode#$/../^#!\/fontunicode#$/) {
        /^#!fontunicode#$/ and next;
        /^#!\/fontunicode#$/ and next;
        $unicodedescriptor[$nfonts].=$_;
        next;
        }
      if (/^#!fontdescriptor#$/../^#!\/fontdescriptor#$/) {
        /^#!fontdescriptor#$/ and next;
        /^#!\/fontdescriptor#$/ and next;
        $nodeffontdescriptor[$nfonts].=$_;
        next;
        }
      else {$nodeffont[$nfonts].=$_}
      next;
      }
    }
  close(FONTFILE);
  }

if ($stdin) {push @ARGV,"-";}
if (uc($option{'paper'}) =~ /A3/)           {$pageWidth=842;  $pageHeight=1190;}
elsif (uc($option{'paper'}) =~ /A4/)        {$pageWidth=595;  $pageHeight=842; }
elsif (uc($option{'paper'}) =~ /A5/)        {$pageWidth=421;  $pageHeight=595; }
elsif (uc($option{'paper'}) =~ /TABLOID/)   {$pageWidth=792;  $pageHeight=1224;}
elsif (uc($option{'paper'}) =~ /LEDGER/)    {$pageWidth=1224; $pageHeight=792; }
elsif (uc($option{'paper'}) =~ /LEGAL/)     {$pageWidth=612;  $pageHeight=1008;}
elsif (uc($option{'paper'}) =~ /STATEMENT/) {$pageWidth=396;  $pageHeight=612; }
elsif (uc($option{'paper'}) =~ /EXECUTIVE/) {$pageWidth=540;  $pageHeight=720; }
elsif (uc($option{'paper'}) =~ /JISB4/)     {$pageWidth=729;  $pageHeight=1032;}
elsif (uc($option{'paper'}) =~ /JISB5/)     {$pageWidth=516;  $pageHeight=729; }
elsif ($option{'paper'}=~/(\d+)x(\d+)/) {
   if ($1<72) {$pageWidth=72}  else {$pageWidth=$1}
   if ($2<72) {$pageHeight=72} else {$pageHeight=$2}
   }
else {
  if (($option{'paper'}) && (uc($option{'paper'}) !~ /LETTER/))
    {&Warning("the set paper $option{'paper'} isn't supported\n$producer1 will use the default paper (letter)")}
  }

if ($option{'landscape'}) {
  my $tmp=$pageHeight;
  $pageHeight=$pageWidth;
  $pageWidth=$tmp;
  }
my $originalpageWidth=$pageWidth; my $originalpageHeight=$pageHeight;
my $npagex=$pageWidth/2;
my $npagey=20;
my $LLx=48;
my $URy=$pageHeight - 42;
my $typeencoding=$option{'typeencoding'};
if (($typeencoding !~ /MacRomanEncoding/) && ($typeencoding !~ /MacExpertEncoding/) && ($typeencoding !~ /WinAnsiEncoding/) && ($typeencoding !~ /default/))
  {&Warning("the set encoding $typeencoding isn't MacRomanEncoding or MacExpertEncoding or WinAnsiEncoding or default\n$producer1 will use the default encoding (ISOLatin1Encoding)")}
if ($option{'transition'} =~ /replace/) {$transition=""}
elsif ($option{'transition'} =~ /dissolve/) {$transition="Dissolve"}
elsif ($option{'transition'}=~/box!(.*)!/)
  {
  $transition="Box";
  if ($1 eq "I" || $1 eq "O") {$motion=$1}
  else     {
    &Warning("the set motion $1 with $transition transition isn't supported\n$producer1 will use the $transition I (Input) motion");
    $motion="I";
    }
  }
elsif ($option{'transition'}=~/glitter!(.*)!/)
  {
  $transition="Glitter";
  if ($1 == 0 || $1 == 270 || $1 == 315) {$direction=$1}
  else
    {&Warning("the set direction $1 with $transition transition isn't supported\n$producer1 will use the $transition 0 direction")}
  }
elsif ($option{'transition'}=~/wipe!(.*)!/)
  {
  $transition="Wipe";
  if ($1 == 0 || $1 == 90 || $1 == 180 || $1 == 270) {$direction=$1}
  else
    {&Warning("the set direction $1 with $transition transition isn't supported\n$producer1 will use the $transition 0 direction")}
  }
elsif ($option{'transition'}=~/blinds!(.*)!/)
  {
  $transition="Blinds";
  if ($1 eq "H" || $1 eq "V") {$dimension=$1}
  else     {
    &Warning("the set dimension $1 with $transition transition isn't supported\n$producer1 will use the $transition H dimension");
    $dimension="H";
    }
  }
elsif ($option{'transition'}=~/split!(.*)!(.*)!/)
  {
  $transition="Split";
  if ($1 eq "H" || $1 eq "V") {$dimension=$1}
  else     {
    &Warning("the set dimension $1 with $transition transition isn't supported\n$producer1 will use the $transition H dimension");
    $dimension="H";
    }
  if ($2 eq "I" || $2 eq "O") {$motion=$2}
  else     {
    &Warning("the set motion $1 with $transition transition isn't supported\n$producer1 will use the $transition I (Input) motion");
    $motion="I";
    }
  }
else { 
  if ($option{'transition'})
    {
    &Warning("the set transition $option{'transition'} isn't supported\n$producer1 will use the default transition (replace)");
    $option{'transition'}="";
    }
  }

  if (($option{'pagemode'} !~ /FullScreen/) && ($option{'pagemode'} ne "")){
    &Warning("the set page mode $option{'pagemode'} isn't supported\n$producer1 will use the default page mode (UseNone)");
    $option{'pagemode'}="";
    }

  if (($option{'pagelayout'} !~ /OneColumn/) && ($option{'pagelayout'} !~ /TwoColumnRight/) && ($option{'pagelayout'} !~ /TwoColumnLeft/) && ($option{'pagelayout'} !~ /TwoPageLeft/) && ($option{'pagelayout'} !~ /TwoPageRight/) && ($option{'pagelayout'} ne "")) {
    &Warning("the set page layout $option{'pagelayout'} isn't supported\n$producer1 will use the default page layout (SinglePage)");
    $option{'pagelayout'}="";
    }
 if (($option{'pagelayout'} =~ /TwoPageLeft/) || ($option{'pagelayout'} =~ /TwoPageRight/)) {$option{'pdfversion'}="1.5"}

if ($option{'lines'}) {$lines = $option{'lines'}}
else {$lines = ($pageHeight - 72) / $option{'vertSpace'}}
$lines = int $lines;
if    ($option{'font'} =~ "Courier")   {$fontn=1}
elsif ($option{'font'} =~ "Helvetica") {$fontn=5}
elsif ($option{'font'} =~ "Times")     {$fontn=9}
elsif ($option{'font'} =~ /F(\d+)/)    {
  $fontn=$1;
  }
else  {
  &Warning("the set font $option{'font'} isn't Courier or Helvetica or Times\n$producer1 will use the default font (Courier)");
  $fontn=1;
  }
if (($option{'rotate'} == 0) || ($option{'rotate'} == 90) || ($option{'rotate'} == 180) || ($option{'rotate'} == 270))
  {$rotate=$option{'rotate'}}
else {
   &Warning("the set rotate $option{'rotate'} isn't supported\n$producer1 will use the default rotate (0)");
   $rotate=0;
   }
if ($option{'colour'})
  {
  open (COLOUR, "$option{'colour'}") ||
     die "txt2pdf: couldn't open colour file $option{'colour'}\n";
  while (<COLOUR>) {
    if (/^(.*);(.*)$/) {
      $color[$colori*4]=$1;
      ($color[$colori*4+1],$color[$colori*4+2],$color[$colori*4+3])=split(/:/,$2);
      $colori++;
      }
    }
  close(COLOUR);
  }
if ($option{'fontmark'})
  {
  open (FONTMARK, "$option{'fontmark'}") ||
     die "txt2pdf: couldn't open fontmark file $option{'fontmark'}\n";
  while (<FONTMARK>) {
    if (/^(.*);(.*)$/) {
      $fontmark[$fontmarki*2]=$1;
      $fontmark[$fontmarki*2+1]=$2;
      $fontmarki++;
      }
    }
  close(FONTMARK);
  }
if ($option{'bgdesign'})
  {
  open (BGDESIGN, "$option{'bgdesign'}") ||
     die "$producer1: couldn't open background design file $option{'bgdesign'}\n";
  while (<BGDESIGN>) {
    s/\015$//;
    if (/^#!epd#(.*);(.*);(.*);(.*);(.*);(.*);(.*)#!\/epd#$/) {
      $epd[$epdi*9]=$1;
      $epd[$epdi*9+2]=0;
      $epd[$epdi*9+3]=$2;
      $epd[$epdi*9+4]=$3;
      $epd[$epdi*9+5]=$4;
      $epd[$epdi*9+6]=$5;
      $epd[$epdi*9+7]=$6;
      $epd[$epdi*9+8]=$7;
      $epdi++;
      next;
      }
    $bgdesign.=$_;
    }
  close(BGDESIGN);
  }
if ($option{'fgdesign'})
  {
  open (FGDESIGN, "$option{'fgdesign'}") ||
     die "$producer1: couldn't open foreground design file $option{'fgdesign'}\n";
  while (<FGDESIGN>) {
    s/\015$//;
    $fgdesign.=$_;
    }
  close(FGDESIGN);
  }

sub wanted {
  if ($File::Find::name=~/$match/) {
    push @ARGV,$File::Find::name;
    }
  }

if ($match && !$recursive) {
   print "You can use -match option only with -recursive option\n";
   exit;
   }

SLEEP:
if ($recursive) {
  if($loop == 1) {
    $match=~s/\./\\./g;
    $match=~s/\*/.*/g;
    $match=~s/\?/./g;
    $match=~s/$/\$/;
    }
  @ARGV=();
  find (\&wanted,"$recursive");
  }

my $tmpfile = $option{'tmpdir'} . "txt2pdf$$";

  if ($option{'beginfile'}) {
    open (BEGINFILE,$option{'beginfile'}) ||
      die qq!$producer1: couldn't open input file $option{'beginfile'}\n!;
    binmode BEGINFILE;
    while(<BEGINFILE>) {
      s/\r?\n$/\n/;
      s/\r/\n/g;
      $bflines++;
      $_=&TAB($_);
      $BF.=$_;
      }
    close(BEGINFILE);
    }
  if ($option{'endfile'}) {
    open (ENDFILE,$option{'endfile'}) ||
      die qq!$producer1: couldn't open input file $option{'endfile'}\n!;
    binmode ENDFILE;
    while(<ENDFILE>) {
      s/\r?\n$/\n/;
      s/\r/\n/g;
      $_=&TAB($_);
      $EF.=$_;
      }
    close(ENDFILE);
    }

if (@ARGV) {
  my @files;
  my $i;

  if ($^O =~ /^MSWin32$/i && !$recursive) {
    foreach $i (@ARGV) {
      if($i=~/\*|\?/) {push @files,glob($i)}
      else {push @files,$i}
      }
    }
  else {@files = @ARGV}
  foreach $input (@files) {
    $obj=0;
    $pageNO=0;
    $fpos=0;
    @pageObj='';
    @annots = ();
    if ($option{'inputmod'}) {
      my $inputmod;
      foreach $inputmod (@inputmod)
        {my $inmod = $inputmod; $inmod=~s/#!input#/$input/; system $inmod;}
      }
    $verbose and $times = time;
    if(!$option{'title'}) {$title=basename($input,"")}
    else {$title=$option{'title'}}
    $verbose and print "Processing $input file\n";
    if(!$test) {
      if ($stdin) {open (OUT, ">-") || die "$producer1: couldn't open standard output\n"}
      else {
        $output=$input;
        $saveinput=$input;
        my $out=basename($output,"");
        if ($out=~/(.*)\..*/ and !$option{'withextension'}) {$out=~s/(.*)\..*/$1\.pdf/;}
        else {$out.=".pdf";}
        $output=dirname($output,"");
  
        if ($^O =~ /VMS/ ) {
# On OpenVMS: Also don't add '/' if dir ends in ']' or ':'
#    e.g. VMS filepecs look like
          $output.="/" if ($output !~ /(\/|\\|]|:)$/ );
        } elsif ($^O eq 'MacOS') {
          $output.=":" if ($output !~ /:$/ ); # macs are a bit different...
        } else {
# concat '/' only if dir doesn't already end in a '/' or '\\'
          $output.="/" if ($output !~ /(\/|\\)$/ );
        }
        $output.=$out;
        open (OUT, ">$output") || die "$producer1: couldn't open output file $output\n";
      }
      binmode OUT;
      &ReorganizeFile($input);
      # Start PDF
      if ($option{'prepdf'}) {$option{'prepdf'}=~s/\\n/\n/g;&pos("$option{'prepdf'}\n");}
      &pos("%PDF-$option{'pdfversion'}\n");
    # It is recommended that the second line of a PDF file be a comment that
    # contains at least four characters with codes 128 or greater
      &pos("%âãÏÓ\n");
      if ($option{'linkuse'}) {&WriteLink($tmpfile)}
      &WriteHeader();
      &WritePages($tmpfile);
      &WriteRest();
      close(OUT);
      }
    if ($option{'outputmod'}) {
      my $outputmod;
      foreach $outputmod (@outputmod)
        {my $outmod=$outputmod; $outmod=~s/#!output#/$output/; system $outmod;}
      }

    # a simple user-interface enhancement
    # make a MacOS double-clickable file
    if ($^O eq 'MacOS') {MacPerl::SetFileInfo('CARO','PDF ', $output)}
    $verbose and print "Writing $output file\n";
    if($option{'txtdir'} ne "") {
      if (!$test) {
        $newinput=$option{'txtdir'}.basename($saveinput);
        rename $saveinput,$newinput;
        $verbose and print "Moving $saveinput file in the $option{'txtdir'} directory\n";
        } else {
        print "TEST: Moving $saveinput file in the $option{'txtdir'} directory\n";
        }
      }
    if($option{'pdfdir'} ne "") {
      if(!$test) {
        $newoutput=$option{'pdfdir'}.basename($output);
        rename $output,$newoutput;
        $verbose and print "Moving $output file in the $option{'pdfdir'} directory\n";
        }  else {
        print "TEST: Moving $output file in the $option{'pdfdir'} directory\n";
        }
      }
    }
    if ($^O =~ /VMS/ ) {
# On OpenVMS, need While to delete all versions of tmpfile
      while ( unlink($tmpfile) ) {};
    } else {
      unlink($tmpfile);
    }
  if ($verbose) {$timef = time; printf ("PDF generation time = %4.2f sec\n", $timef - $times );}
  if($option{'sleep'}) {
    sleep $option{'sleep'};
    $loop++;
    $verbose and print "\nLoop number $loop\n";
    goto SLEEP;
    }
  } else {
  print "$producer -help to read the online help\n";
  if($option{'sleep'}) {
    sleep $option{'sleep'};
    $loop++;
    $verbose and print "\nLoop number $loop\n";
    goto SLEEP;
    }
  }

sub ReorganizeFile {
  my $file=shift(@_);

  my $i;
  my $foo;
  my $temporary;
  open (IN, "$file") || die "$producer1: couldn't open input file $file\n";
  open (TEMP, ">$tmpfile") || die "$producer1: couldn't open temporary file $tmpfile\n";
  binmode TEMP;
  if($BF) {print TEMP "$BF"}
  binmode IN;
  while (<IN>) {
    s/\r?\n$/\n/;
    s/\r/\n/g;
    $_ = &TAB($_);
    print TEMP "$_";
    }
  if($EF) {print TEMP "$EF"}
  print TEMP "\n";
  print TEMP $Demo;
  close(IN);
  close(TEMP);
  }


sub WriteLink {
  my $file=shift(@_);

  $line=0;
  $page=1;
  open (IN, "$file") || die "$producer1: couldn't open input file $file\n";
  my $linktemp;
  binmode IN;
  while (<IN>) {
    $line++;
    $linktemp=$_;
    while ($linktemp=~/(.*)((http|ftp|mailto|https|file|ldap|news):[^ \n)]+)( +|$|\))/i) {
      $linktemp=$1;
      &Link(length $1,length $2,$2,"url");
      }
    ##  14May99 - Modified to handle the mime: marker.  It's just a
    ##            tweak of the original link test
    while ($linktemp=~/(.*)(mime:[^ \n)]+)( +|$|\))/i) {
      $linktemp=$1;
      &Link(length $1,length $2,$2,"file");
      }
    if ($line == $lines) {
        $line=0;
        $page++;
      }
    }
  close (IN);
  }

sub WriteHeader {
  my $gm = (gmtime(time))[2];
  my $local = (localtime(time))[2];
  my $diff = $local - $gm;
  if ($diff <= -12) { $diff += 24 }
  elsif ($diff > 12) { $diff -= 24 }
  my $zone = $diff;
  if ($zone =~ /-/) {$zone = sprintf "%.2d'00'", $zone}
  else  {$zone = sprintf "+%.2d'00'", $zone}
  $date=sprintf "D:$year%.2ld%.2ld%.2ld%.2ld%.2ld$zone",$mon,$mday,$hour,$min,$sec;
  $location[++$obj]=$fpos;
  $info=$obj;
    &pos("$obj 0 obj");
    &pos("<<");
    $option{'author'} and &pos("/Author($option{'author'})");
    &pos("/CreationDate($date)");
    $option{'creator'} and &pos("/Creator($option{'creator'})");
    &pos("/Producer($producer1 v$version \\251 $companyname 2005)");
    &pos("/Title($title)");
    $option{'subject'} and &pos("/Subject($option{'subject'})");
    $option{'keywords'} and &pos("/Keywords($option{'keywords'})");
    &pos(">>");
  &pos("endobj\n");
# ISOLatin1Encoding
  $location[++$obj]=$fpos;
  my $encoding=$obj;
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Encoding");
    if ($typeencoding eq "WinAnsiEncoding") {&pos("/BaseEncoding/WinAnsiEncoding")}
    elsif ($typeencoding eq "MacRomanEncoding") {&pos("/BaseEncoding/MacRomanEncoding")}
    elsif ($typeencoding eq "MacExpertEncoding") {&pos("/BaseEncoding/MacExpertEncoding")}
    else {
      &pos("/Differences[0 /.notdef/.notdef/.notdef/.notdef");
      &pos("/.notdef/.notdef/.notdef/.notdef/.notdef/.notdef");
      &pos("/.notdef/.notdef/.notdef/.notdef/.notdef/.notdef");
      &pos("/.notdef/.notdef/.notdef/.notdef/.notdef/.notdef");
      &pos("/.notdef/.notdef/.notdef/.notdef/.notdef/.notdef");
      &pos("/.notdef/.notdef/.notdef/.notdef/space/exclam");
      &pos("/quotedbl/numbersign/dollar/percent/ampersand");
      &pos("/quoteright/parenleft/parenright/asterisk/plus/comma");
      &pos("/hyphen/period/slash/zero/one/two/three/four/five");
      &pos("/six/seven/eight/nine/colon/semicolon/less/equal");
      &pos("/greater/question/at/A/B/C/D/E/F/G/H/I/J/K/L");
      &pos("/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z/bracketleft");
      &pos("/backslash/bracketright/asciicircum/underscore");
      &pos("/quoteleft/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p");
      &pos("/q/r/s/t/u/v/w/x/y/z/braceleft/bar/braceright");
      &pos("/asciitilde/.notdef/.notdef/.notdef/.notdef/.notdef");
      &pos("/.notdef/.notdef/.notdef/.notdef/.notdef/.notdef");
      &pos("/.notdef/.notdef/.notdef/.notdef/.notdef/.notdef");
      &pos("/dotlessi/grave/acute/circumflex/tilde/macron/breve");
      &pos("/dotaccent/dieresis/.notdef/ring/cedilla/.notdef");
      &pos("/hungarumlaut/ogonek/caron/space/exclamdown/cent");
      &pos("/sterling/currency/yen/brokenbar/section/dieresis");
      &pos("/copyright/ordfeminine/guillemotleft/logicalnot/hyphen");
      &pos("/registered/macron/degree/plusminus/twosuperior");
      &pos("/threesuperior/acute/mu/paragraph/periodcentered");
      &pos("/cedilla/onesuperior/ordmasculine/guillemotright");
      &pos("/onequarter/onehalf/threequarters/questiondown/Agrave");
      &pos("/Aacute/Acircumflex/Atilde/Adieresis/Aring/AE");
      &pos("/Ccedilla/Egrave/Eacute/Ecircumflex/Edieresis/Igrave");
      &pos("/Iacute/Icircumflex/Idieresis/Eth/Ntilde/Ograve");
      &pos("/Oacute/Ocircumflex/Otilde/Odieresis/multiply/Oslash");
      &pos("/Ugrave/Uacute/Ucircumflex/Udieresis/Yacute/Thorn");
      &pos("/germandbls/agrave/aacute/acircumflex/atilde/adieresis");
      &pos("/aring/ae/ccedilla/egrave/eacute/ecircumflex");
      &pos("/edieresis/igrave/iacute/icircumflex/idieresis/eth");
      &pos("/ntilde/ograve/oacute/ocircumflex/otilde/odieresis");
      &pos("/divide/oslash/ugrave/uacute/ucircumflex/udieresis");
      &pos("/yacute/thorn/ydieresis]");
      }
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont="/F1 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F1");
    &pos("/Encoding $encoding 0 R");
    &pos("/BaseFont/Courier");
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont.="/F2 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F2");
    &pos("/Encoding $encoding 0 R");
    &pos("/BaseFont/Courier-Oblique");
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont.="/F3 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F3");
    &pos("/Encoding $encoding 0 R");
    &pos("/BaseFont/Courier-Bold");
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont.="/F4 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F4");
    &pos("/Encoding $encoding 0 R");
    &pos("/BaseFont/Courier-BoldOblique");
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont.="/F5 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F5");
    &pos("/Encoding $encoding 0 R");
    &pos("/BaseFont/Helvetica");
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont.="/F6 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F6");
    &pos("/Encoding $encoding 0 R");
    &pos("/BaseFont/Helvetica-Oblique");
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont.="/F7 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F7");
    &pos("/Encoding $encoding 0 R");
    &pos("/BaseFont/Helvetica-Bold");
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont.="/F8 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F8");
    &pos("/Encoding $encoding 0 R");
    &pos("/BaseFont/Helvetica-BoldOblique");
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont.="/F9 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F9");
    &pos("/Encoding $encoding 0 R");
    &pos("/BaseFont/Times-Roman");
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont.="/F10 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F10");
    &pos("/Encoding $encoding 0 R");
    &pos("/BaseFont/Times-Italic");
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont.="/F11 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F11");
    &pos("/Encoding $encoding 0 R");
    &pos("/BaseFont/Times-Bold");
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont.="/F12 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F12");
    &pos("/Encoding $encoding 0 R");
    &pos("/BaseFont/Times-BoldItalic");
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont.="/F13 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F13");
    &pos("/BaseFont/Symbol");
    &pos(">>");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
    $everyfont.="/F14 $obj 0 R";
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Font");
    &pos("/Subtype/Type1");
    &pos("/Name/F14");
    &pos("/BaseFont/ZapfDingbats");
    &pos(">>");
  &pos("endobj\n");
  if($option{'japanese'}) {
    $location[++$obj]=$fpos;
      $everyfont.="/F20 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F20");
      &pos("/BaseFont/HeiseiMin-W3-90ms-RKSJ-H");
      &pos("/Encoding/90ms-RKSJ-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType0");
      &pos("/BaseFont/HeiseiMin-W3");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(Japan1)");
      &pos("/Supplement 2");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[50 500 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/Ascent 723");
      &pos("/CapHeight 709");
      &pos("/Descent -241");
      &pos("/Flags 6");
      &pos("/FontBBox[-123 -257 1001 910]");
      &pos("/FontName/HeiseiMin-W3");
      &pos("/ItalicAngle 0");
      &pos("/StemV 69");
      &pos("/XHeight 450");
      &pos("/Style<</Panose<010502020400000000000000>>>>>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F21 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F21");
      &pos("/BaseFont/HeiseiMin-W3-90ms-RKSJ-H,Italic");
      &pos("/Encoding/90ms-RKSJ-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType0");
      &pos("/BaseFont/HeiseiMin-W3,Italic");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(Japan1)");
      &pos("/Supplement 2");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[50 500 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/Ascent 723");
      &pos("/CapHeight 709");
      &pos("/Descent -241");
      &pos("/Flags 6");
      &pos("/FontBBox[-123 -257 1001 910]");
      &pos("/FontName/HeiseiMin-W3,Italic");
      &pos("/ItalicAngle 0");
      &pos("/StemV 69");
      &pos("/XHeight 450");
      &pos("/Style<</Panose<010502020400000000000000>>>>>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F22 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F22");
      &pos("/BaseFont/HeiseiMin-W3-90ms-RKSJ-H,Bold");
      &pos("/Encoding/90ms-RKSJ-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType0");
      &pos("/BaseFont/HeiseiMin-W3,Bold");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(Japan1)");
      &pos("/Supplement 2");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[50 500 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/Ascent 723");
      &pos("/CapHeight 709");
      &pos("/Descent -241");
      &pos("/Flags 6");
      &pos("/FontBBox[-123 -257 1001 910]");
      &pos("/FontName/HeiseiMin-W3,Bold");
      &pos("/ItalicAngle 0");
      &pos("/StemV 69");
      &pos("/XHeight 450");
      &pos("/Style<</Panose<010502020400000000000000>>>>>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F23 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F23");
      &pos("/BaseFont/HeiseiMin-W3-90ms-RKSJ-H,BoldItalic");
      &pos("/Encoding/90ms-RKSJ-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType0");
      &pos("/BaseFont/HeiseiMin-W3,BoldItalic");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(Japan1)");
      &pos("/Supplement 2");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[50 500 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/Ascent 723");
      &pos("/CapHeight 709");
      &pos("/Descent -241");
      &pos("/Flags 6");
      &pos("/FontBBox[-123 -257 1001 910]");
      &pos("/FontName/HeiseiMin-W3,BoldItalic");
      &pos("/ItalicAngle 0");
      &pos("/StemV 69");
      &pos("/XHeight 450");
      &pos("/Style<</Panose<010502020400000000000000>>>>>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F24 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F24");
      &pos("/BaseFont/HeiseiKakuGo-W5-90ms-RKSJ-H");
      &pos("/Encoding/90ms-RKSJ-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType0");
      &pos("/BaseFont/HeiseiKakuGo-W5");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(Japan1)");
      &pos("/Supplement 2");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[50 500 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/Ascent 752");
      &pos("/CapHeight 737");
      &pos("/Descent -221");
      &pos("/Flags 4");
      &pos("/FontBBox[-92 -250 1010 922]");
      &pos("/FontName/HeiseiKakuGo-W5");
      &pos("/ItalicAngle 0");
      &pos("/StemV 114");
      &pos("/XHeight 553");
      &pos("/Style<</Panose<0801020b0600000000000000>>>");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F25 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F25");
      &pos("/BaseFont/HeiseiKakuGo-W5-90ms-RKSJ-H,Italic");
      &pos("/Encoding/90ms-RKSJ-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType0");
      &pos("/BaseFont/HeiseiKakuGo-W5,Italic");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(Japan1)");
      &pos("/Supplement 2");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[50 500 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/Ascent 752");
      &pos("/CapHeight 737");
      &pos("/Descent -221");
      &pos("/Flags 4");
      &pos("/FontBBox[-92 -250 1010 922]");
      &pos("/FontName/HeiseiKakuGo-W5,Italic");
      &pos("/ItalicAngle 0");
      &pos("/StemV 114");
      &pos("/XHeight 553");
      &pos("/Style<</Panose<0801020b0600000000000000>>>");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F26 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F26");
      &pos("/BaseFont/HeiseiKakuGo-W5-90ms-RKSJ-H,Bold");
      &pos("/Encoding/90ms-RKSJ-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType0");
      &pos("/BaseFont/HeiseiKakuGo-W5,Bold");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(Japan1)");
      &pos("/Supplement 2");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[50 500 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/Ascent 752");
      &pos("/CapHeight 737");
      &pos("/Descent -221");
      &pos("/Flags 4");
      &pos("/FontBBox[-92 -250 1010 922]");
      &pos("/FontName/HeiseiKakuGo-W5,Bold");
      &pos("/ItalicAngle 0");
      &pos("/StemV 114");
      &pos("/XHeight 553");
      &pos("/Style<</Panose<0801020b0600000000000000>>>");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F27 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F27");
      &pos("/BaseFont/HeiseiKakuGo-W5-90ms-RKSJ-H,BoldItalic");
      &pos("/Encoding/90ms-RKSJ-H");
      $buf=sprintf "/DescendantFonts [%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType0");
      &pos("/BaseFont/HeiseiKakuGo-W5,BoldItalic");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(Japan1)");
      &pos("/Supplement 2");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[50 500 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/Ascent 752");
      &pos("/CapHeight 737");
      &pos("/Descent -221");
      &pos("/Flags 4");
      &pos("/FontBBox[-92 -250 1010 922]");
      &pos("/FontName/HeiseiKakuGo-W5,BoldItalic");
      &pos("/ItalicAngle 0");
      &pos("/StemV 114");
      &pos("/XHeight 553");
      &pos("/Style<</Panose<0801020b0600000000000000>>>");
      &pos(">>");
    &pos("endobj\n")
    }
  if($option{'tradchinese'}) {
    $location[++$obj]=$fpos;
      $everyfont.="/F30 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F30");
      &pos("/BaseFont/MingLiU");
      &pos("/Encoding/ETen-B5-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType2");
      &pos("/BaseFont/MingLiU");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(CNS1)");
      &pos("/Supplement 0");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[13500 14000 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/FontName/MingLiU");
      &pos("/FontBBox[0 -199 1000 801]");
      &pos("/Flags 7");
      &pos("/CapHeight 0");
      &pos("/Ascent 800");
      &pos("/Descent -199");
      &pos("/StemV 0");
      &pos("/ItalicAngle 0");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F31 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F31");
      &pos("/BaseFont/MingLiU,Italic");
      &pos("/Encoding/ETen-B5-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType2");
      &pos("/BaseFont/MingLiU,Italic");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(CNS1)");
      &pos("/Supplement 0");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[13500 14000 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/FontName/MingLiU");
      &pos("/FontBBox[0 -199 1000 801]");
      &pos("/Flags 7");
      &pos("/CapHeight 0");
      &pos("/Ascent 800");
      &pos("/Descent -199");
      &pos("/StemV 0");
      &pos("/ItalicAngle 0");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F32 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F32");
      &pos("/BaseFont/MingLiU,Bold");
      &pos("/Encoding/ETen-B5-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType2");
      &pos("/BaseFont/MingLiU,Bold");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(CNS1)");
      &pos("/Supplement 0");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[13500 14000 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/FontName/MingLiU");
      &pos("/FontBBox[0 -199 1000 801]");
      &pos("/Flags 7");
      &pos("/CapHeight 0");
      &pos("/Ascent 800");
      &pos("/Descent -199");
      &pos("/StemV 0");
      &pos("/ItalicAngle 0");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F33 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F33");
      &pos("/BaseFont/MingLiU,BoldItalic");
      &pos("/Encoding/ETen-B5-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type /Font");
      &pos("/Subtype/CIDFontType2");
      &pos("/BaseFont/MingLiU,BoldItalic");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(CNS1)");
      &pos("/Supplement 0");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[13500 14000 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/FontName/MingLiU");
      &pos("/FontBBox[0 -199 1000 801]");
      &pos("/Flags 7");
      &pos("/CapHeight 0");
      &pos("/Ascent 800");
      &pos("/Descent -199");
      &pos("/StemV 0");
      &pos("/ItalicAngle 0");
      &pos(">>");
    &pos("endobj\n");
    }
  if($option{'simplchinese'}) {
    $location[++$obj]=$fpos;
      $everyfont.="/F35 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F35");
      &pos("/BaseFont/STSong");
      &pos("/Encoding/GB-EUC-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType2");
      &pos("/BaseFont/STSong");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(GB1)");
      &pos("/Supplement 0");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[500 950 500 7716 [500]]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/FontName/STSong");
      &pos("/FontBBox[0 -199 1000 801]");
      &pos("/Flags 6");
      &pos("/CapHeight 658");
      &pos("/Ascent 801");
      &pos("/Descent -199");
      &pos("/StemV 56");
      &pos("/XHeight 429");
      &pos("/ItalicAngle 0");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F36 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F36");
      &pos("/BaseFont/STSong,Italic");
      &pos("/Encoding/GB-EUC-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType2");
      &pos("/BaseFont/STSong,Italic");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(GB1)");
      &pos("/Supplement 0");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[500 950 500 7716 [500]]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/FontName/STSong,Italic");
      &pos("/FontBBox[0 -199 1000 801]");
      &pos("/Flags 6");
      &pos("/CapHeight 658");
      &pos("/Ascent 801");
      &pos("/Descent -199");
      &pos("/StemV 56");
      &pos("/XHeight 429");
      &pos("/ItalicAngle 0");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F37 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F37");
      &pos("/BaseFont/STSong,Bold");
      &pos("/Encoding/GB-EUC-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType2");
      &pos("/BaseFont/STSong,Bold");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(GB1)");
      &pos("/Supplement 0");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[500 950 500 7716 [500]]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/FontName/STSong,Bold");
      &pos("/FontBBox[0 -199 1000 801]");
      &pos("/Flags 6");
      &pos("/CapHeight 658");
      &pos("/Ascent 801");
      &pos("/Descent -199");
      &pos("/StemV 56");
      &pos("/XHeight 429");
      &pos("/ItalicAngle 0");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F38 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F38");
      &pos("/BaseFont/STSong,BoldItalic");
      &pos("/Encoding/GB-EUC-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType2");
      &pos("/BaseFont/STSong,BoldItalic");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(GB1)");
      &pos("/Supplement 0");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[500 950 500 7716 [500]]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/FontName/STSong,BoldItalic");
      &pos("/FontBBox[0 -199 1000 801]");
      &pos("/Flags 6");
      &pos("/CapHeight 658");
      &pos("/Ascent 801");
      &pos("/Descent -199");
      &pos("/StemV 56");
      &pos("/XHeight 429");
      &pos("/ItalicAngle 0");
      &pos(">>");
    &pos("endobj\n");
    }
  if($option{'korean'}) {
    $location[++$obj]=$fpos;
      $everyfont.="/F40 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F40");
      &pos("/BaseFont/#B5#B8#BF#F2#C3#BC");
      &pos("/Encoding/KSCms-UHC-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType2");
      &pos("/BaseFont/#B5#B8#BF#F2#C3#BC");
      &pos("/WinCharSet 129");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(Korea1)");
      &pos("/Supplement 1");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[0 1000 500]");
      &pos(">>\n");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/FontName/#B5#B8#BF#F2#C3#BC");
      &pos("/Flags 7");
      &pos("/FontBBox[-100 -142 102 1000]");
      &pos("/MissingWidth 500");
      &pos("/StemV 91");
      &pos("/StemH 91");
      &pos("/ItalicAngle 0");
      &pos("/CapHeight 858");
      &pos("/XHeight 429");
      &pos("/Ascent 858");
      &pos("/Descent -142");
      &pos("/Leading 148");
      &pos("/MaxWidth 2");
      &pos("/AvgWidth 500");
      &pos("/Style<</Panose<000000400000000000000000>>>");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F41 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F41");
      &pos("/BaseFont/#B5#B8#BF#F2#C3#BC,Italic");
      &pos("/Encoding/KSCms-UHC-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType2");
      &pos("/BaseFont/#B5#B8#BF#F2#C3#BC,Italic");
      &pos("/WinCharSet 129");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(Korea1)");
      &pos("/Supplement 1");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[0 1000 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/FontName/#B5#B8#BF#F2#C3#BC,Italic");
      &pos("/Flags 16391");
      &pos("/FontBBox[-100 -142 1100 1000]");
      &pos("/MissingWidth 500");
      &pos("/StemV 159");
      &pos("/StemH 159");
      &pos("/ItalicAngle 0");
      &pos("/CapHeight 858");
      &pos("/XHeight 429");
      &pos("/Ascent 858");
      &pos("/Descent -142");
      &pos("/Leading 148");
      &pos("/MaxWidth 1000");
      &pos("/AvgWidth 500");
      &pos("/Style<</Panose<000000400000000000000000>>>");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F42 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F42");
      &pos("/BaseFont/#B5#B8#BF#F2#C3#BC,Bold");
      &pos("/Encoding/KSCms-UHC-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType2");
      &pos("/BaseFont/#B5#B8#BF#F2#C3#BC,Bold");
      &pos("/WinCharSet 129");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(Korea1)");
      &pos("/Supplement 1");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[0 1000 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/FontName/#B5#B8#BF#F2#C3#BC,Bold");
      &pos("/Flags 16391");
      &pos("/FontBBox[-100 -142 1100 1000]");
      &pos("/MissingWidth 500");
      &pos("/StemV 159");
      &pos("/StemH 159");
      &pos("/ItalicAngle 0");
      &pos("/CapHeight 858");
      &pos("/XHeight 429");
      &pos("/Ascent 858");
      &pos("/Descent -142");
      &pos("/Leading 148");
      &pos("/MaxWidth 1000");
      &pos("/AvgWidth 500");
      &pos("/Style<</Panose<000000400000000000000000>>>");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      $everyfont.="/F43 $obj 0 R";
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/Type0");
      &pos("/Name/F43");
      &pos("/BaseFont/#B5#B8#BF#F2#C3#BC,BoldItalic");
      &pos("/Encoding/KSCms-UHC-H");
      $buf=sprintf "/DescendantFonts[%d 0 R]",$obj+1;
      &pos($buf);
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Font");
      &pos("/Subtype/CIDFontType2");
      &pos("/BaseFont/#B5#B8#BF#F2#C3#BC,BoldItalic");
      &pos("/WinCharSet 129");
      $buf=sprintf "/FontDescriptor %d 0 R",$obj+1;
      &pos($buf);
      &pos("/CIDSystemInfo<<");
      &pos("/Registry(Adobe)");
      &pos("/Ordering(Korea1)");
      &pos("/Supplement 1");
      &pos(">>");
      &pos("/DW 1000");
      &pos("/W[0 1000 500]");
      &pos(">>");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/FontDescriptor");
      &pos("/FontName/#B5#B8#BF#F2#C3#BC,BoldItalic");
      &pos("/Flags 16391");
      &pos("/FontBBox[-100 -142 1100 1000]");
      &pos("/MissingWidth 500");
      &pos("/StemV 159");
      &pos("/StemH 159");
      &pos("/ItalicAngle 0");
      &pos("/CapHeight 858");
      &pos("/XHeight 429");
      &pos("/Ascent 858");
      &pos("/Descent -142");
      &pos("/Leading 148");
      &pos("/MaxWidth 1000");
      &pos("/AvgWidth 500");
      &pos("/Style<</Panose<000000400000000000000000>>>");
      &pos(">>");
    &pos("endobj\n");
    }
  for (my $i=0;$i<$nfonts;$i++) {
    $location[++$obj]=$fpos;
    $everyfont.="    $fontname[$i] $obj 0 R\n";
    my $fontobj=$obj+1;
    my $fontobj2;
    if ($nodeffont[$i]=~/#!unicode#/) {
      $fontobj2=$obj+5;
      $nodeffont[$i]=~s/#!unicode#/$fontobj2/;
      }
    $nodeffont[$i]=~s/#!descriptor#/$fontobj/;
    &pos("$obj 0 obj\n");
    &pos("$nodeffont[$i]");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
    &pos("$obj 0 obj\n");
    if($nodeffontdescriptor[$i]=~/#!ttfile#(.*)#!\/ttfile#/) {
      $ttfile=$1;
      my $newobj=$obj+1;
      $nodeffontdescriptor[$i]=~s/#!ttfile#.*#!\/ttfile#/\/FontFile2 $newobj 0 R/;
      }
    &pos("$nodeffontdescriptor[$i]");
    &pos("endobj\n");
    if($nodeffontdescriptor[$i]=~/FontFile2/) {
      $location[++$obj]=$fpos;
        &pos("$obj 0 obj");
        &pos("<<");
        $buf=sprintf "/Length %d 0 R/Length1 %d 0 R>>",$obj+1,$obj+2; &pos($buf);
      &pos("stream\n");
      my $streamStart=$fpos;
      my $streamLength=0;
      open (FONTFILE,$ttfile) ||
        die qq!txt2pdf: couldn't open input file $ttfile\n!;
      binmode FONTFILE;
      while(<FONTFILE>) {$streamLength+=length $_;&pos("$_");}
      close(FONTFILE);
      my $streamEnd=$fpos;
      &pos("\nendstream\n");
      &pos("endobj\n");
      $location[++$obj]=$fpos;
      &pos("$obj 0 obj\n");
      $buf=sprintf "%d\n",$streamEnd-$streamStart; &pos($buf);
      &pos("endobj\n");
      $location[++$obj]=$fpos;
      &pos("$obj 0 obj\n");
      $buf=sprintf "%d\n",$streamLength; &pos($buf);
      &pos("endobj\n");
      }
    if ($nodeffont[$i]=~/\/ToUnicode/) {
      $location[++$obj]=$fpos;
      &pos("$obj 0 obj\n");
      &pos("<<\n");
      $buf=sprintf "/Length %d 0 R\n",$obj+1; &pos($buf);
      &pos(">>\n");
      &pos("stream\n");
      my $streamStart=$fpos;
      &pos("$unicodedescriptor[$i]");
      my $streamEnd=$fpos;
      &pos("\nendstream\n");
      &pos("endobj\n");
      $location[++$obj]=$fpos;
      &pos("$obj 0 obj\n");
      $buf=sprintf "%d\n",$streamEnd-$streamStart; &pos($buf);
      &pos("endobj\n");
      }
  }
  if ($option{'annotationtext'} ne "") {
    $location[++$obj]=$fpos;
      &pos("$obj 0 obj");
      &pos("<<");
      &pos("/Type/Annot");
      &pos("/Subtype/Text");
    my $y2pos=$pageHeight;
    my $y1pos=$pageHeight-100;
    my $x1pos=0;
    my $x2pos=200;
      &pos("/Rect[$x1pos $y1pos $x2pos $y2pos]");
      &pos("/Contents($option{'annotationtext'})");
      &pos(">>");
    &pos("endobj\n");
    $annots[1].="$obj 0 R ";
    }
  $root=++$obj;
  $Tpages=++$obj;
  $epdn=($#epd+1)/9;
  my $i=0;
  my $epdbox="";
  for (1..$epdn) {
    open (EPD, $epd[$i*9]) || die "$producer1: couldn't open image $epd[$i*9]\n";
    binmode EPD;
    while (<EPD>) {
      s/\r?\n$/\n/;
      s/\r/\n/g;
      /BBox\((.*)\)/ and $epdbox=join(' ',split(/,/,$1));
      }
    $location[++$obj]=$fpos;
    $epd[$i*9+2]=$obj;
      &pos("$obj 0 obj");
      &pos("<</Type/XObject/Subtype/Form/FormType 1/Name/Fm$i/Matrix[1 0 0 1 0 0]/BBox[$epdbox]");
      $buf=sprintf "/Length %d 0 R",$obj+1; &pos($buf);
      &pos("/Resources<</Font<<$everyfont>>>>>>\n");
    &pos("stream\n");
    my $streamStart=$fpos;
    open (EPD, $epd[$i*9]) || die "$producer1: couldn't open image $epd[$i*9]\n";
    binmode EPD;
    while (<EPD>) {
      / *%(.*)/ and next;
      &pos("$_");
      }
    close(EPD);
    my $streamEnd=$fpos;
    &pos("\nendstream\n");
    &pos("endobj\n");
    $location[++$obj]=$fpos;
    &pos("$obj 0 obj\n");
    $buf=sprintf "%d\n",$streamEnd-$streamStart; &pos($buf);
    &pos("endobj\n");
    $i++;
    }
  $location[++$obj]=$fpos;
  $resources=$obj;
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Font<<$everyfont>>");
    &pos("/ProcSet[/PDF/Text]");
    &pos("/XObject<<");
  $i=0;
  for (1..$epdn) {
      &pos("/Fm$i $epd[$i*9+2] 0 R");
    $i++;
    }
    &pos(">>");
    &pos(">>");
  &pos("endobj\n");
  }

sub WritePages {
  my $file=shift(@_);

  my $columns="";
  my $pageNO2=1;
  my $temp;
  my $i;
  my $parseword;
  my $thistest;
  my $testfont;
  my $converted=0;

  open (IN, "$file") || die "$producer1: couldn't open input file $file\n";
  my $beginstream = &StartPage();
  $lineNO=-1;
  binmode IN;
  while (<IN>) {
    $temp=$_;
    $lineNO++;
    if ($lineNO eq $lines) {
      if ($option{'npage'}) {
        &pos("/F2 $option{'pointSize'} Tf\n");
        &pos("1 0 0 1 $npagex $npagey Tm($pageNO)Tj");
        &pos("/F$fontn $option{'pointSize'} Tf\n")
        }
      &EndPage($beginstream);
      $beginstream = &StartPage();
      }
    chop($temp);
    $temp=~s/\\/\\\\/g;
    $temp=~s/\(/\\(/g;
    $temp=~s/\)/\\)/g;
        &pos("T*(");
    my $color=($#color+1)/4;
    my $il=0;
    for (1..$color) {
      $temp=~s/($color[$il*4])/) Tj\n $color[$il*4+1] $color[$il*4+2] $color[$il*4+3] rg\n ($1) Tj\n 0 0 0 rg\n (/g;
      $il++;
      }
    my $fontmark=($#fontmark+1)/2;
    $il=0;
    for (1..$fontmark) {
      $temp=~s/($fontmark[$il*2])/) Tj\n $fontmark[$il*2+1] $option{'pointSize'} Tf\n ($1) Tj\n \/F$fontn $option{'pointSize'} Tf\n (/g;
      $il++;
      }
#    if ($temp=~/((http|ftp|mailto|mime|https|file|ldap|news):[^ \n]*) /i)
#      {
#      $substring=") Tj\n 0 0 1 rg\n ($1) Tj\n 0 0 0 rg (";
#      $temp=~s/$1/$substring/g;
#      }
    if ($option{'underline'}) {
      if($temp=~/(.+)$option{'underline'}(.+)/) {&pos("$1) Tj 0 0 Td ($2")}
      else {&pos("$temp")}
      } else {&pos("$temp")}     
      &pos(")Tj\n");
    }
  close(IN);
  if ($option{'npage'}) {
      &pos("/F2 $option{'pointSize'} Tf\n");
      &pos("1 0 0 1 $npagex $npagey Tm($pageNO)Tj");
      &pos("/F$fontn $option{'pointSize'} Tf\n")
    }
  &EndPage($beginstream);
  }

# End PDF
sub WriteRest {
  my $i;
  $location[$root]=$fpos;
    &pos("$root 0 obj");
    &pos("<<");
    &pos("/Type/Catalog");
    &pos("/Pages $Tpages 0 R");
    if ($option{'pagemark'}) {
      &pos("/Dests<<");
      for ($i=1; $i < $pageNO+1; $i++)
        {&pos("/page$i [$pageObj[$i] 0 R /XYZ null null null]")}
      &pos(">>");
      }
#    &pos("/OpenAction<</S/GoTo/Dest[1 /XYZ null null 1]>>");
    if ($option{'pagemode'}) {&pos("/PageMode/$option{'pagemode'}")}
    if ($option{'pagelayout'}) {&pos("/PageLayout/$option{'pagelayout'}")}
    if ($option{'viewerpreferences'}) {&pos("/ViewerPreferences<<$option{'viewerpreferences'}>>")}
    if ($option{'fit'}) {&pos("/OpenAction<</S/GoTo/D[0 /Fit]>>\n")}
    if ($option{'zoom'}) {&pos("/OpenAction<</S/GoTo/D[0 /XYZ null null $option{'zoom'}]>>")}
    &pos(">>");
  &pos("endobj\n");
  $location[$Tpages]=$fpos;
    &pos("$Tpages 0 obj");
    &pos("<<");
    &pos("/Type/Pages");
    &pos("/Count $pageNO");
    &pos("/MediaBox[0 0 $originalpageWidth $originalpageHeight]");
    &pos("/Kids[");
    for ($i=1; $i<=$pageNO;$i++) {&pos("$pageObj[$i] 0 R ");}
    &pos("]");
    &pos(">>");
  &pos("endobj\n");
  my $xfer = $fpos;
  &pos("xref\n");
# problems with optimize here!
  $buf=sprintf "0 %d\n",$obj+1; &pos($buf);
    &pos("0000000000 65535 f \r");
    my $num="";
    for ($i=1;$i<=$obj;$i++) {
      $buf=sprintf "%.10ld 00000 n \r",$location[$i];
      &pos($buf);
      }	    
  &pos("trailer\n");
  my $time = time;
    &pos("<<");
    $buf=sprintf "/Size %d",$obj+1; &pos($buf);
    &pos("/Root $root 0 R");
    &pos("/Info $info 0 R");
  &pos(">>\n");
  &pos("startxref\n");
  &pos("$xfer\n");
  &pos("%%EOF\n");
  }

sub StartPage {

  $location[++$obj]=$fpos;
  $pageObj[++$pageNO]=$obj;
    &pos("$obj 0 obj");
    &pos("<<");
    &pos("/Type/Page");
    &pos("/Parent $Tpages 0 R");
    &pos("/Resources $resources 0 R");
    $buf=sprintf "/Contents %d 0 R",++$obj; &pos($buf);
    &pos("/Rotate $rotate");
    if ($transition eq "Dissolve") {&pos("/Trans<</Type/Trans/S/$transition>>")}
    if ($transition eq "Box") {&pos("/Trans<</Type/Trans/S/$transition/M/$motion>>")}
    if ($transition eq "Glitter") {&pos("/Trans<</Type/Trans/S/$transition/Di$direction>>")}
    if ($transition eq "Wipe") {&pos("/Trans<</Type/Trans/S/$transition/Di$direction>>")}
    if ($transition eq "Blinds") {&pos("/Trans<</Type/Trans/S/$transition/Dm/$dimension>>")}
    if ($transition eq "Split") {&pos("/Trans<</Type/Trans/S/$transition/Dm/$dimension/M/$motion>>")}
    $annots[$pageNO] and &pos("/Annots[$annots[$pageNO]]");
    &pos(">>");
  &pos("endobj\n");
  $location[$obj]=$fpos;
    &pos("$obj 0 obj");
    &pos("<<");
    $buf=sprintf "/Length %d 0 R",$obj+1; &pos($buf);
    &pos(">>");
  &pos("stream\n");
  my $strmPos=$fpos;
  my $i=0;
  if ($epdn) {
    $i=0;
    for (1..$epdn) {
      &pos("q $epd[$i*9+3] $epd[$i*9+4] $epd[$i*9+5] $epd[$i*9+6] $epd[$i*9+7] $epd[$i*9+8] cm /Fm$i Do Q\n");
      $i++;
      }
    }
  my $default=15;
  my $Width=$pageWidth - $default;
  my $Height=$pageHeight - $default;
  if ($option{'border'}) {
    &pos("2 w\n");
    &pos("1 g\n");
    &pos("$default $default m\n$Width $default l\n");
    &pos("$Width $default m\n$Width $Height l\n");
    &pos("$Width $Height m\n$default $Height l\n");
    &pos("$default $Height m\n$default $default l\n");
    &pos("0 g\nB*\n");
    }
  if ($bgdesign) {$bgdesign=&substitute($bgdesign);&pos("$bgdesign")}
  &pos("BT\n");
  &pos("/F$fontn $option{'pointSize'} Tf\n");
  $buf=sprintf "1 0 0 1 50 %d Tm\n",$pageHeight-40; &pos($buf);
  &pos("$option{'vertSpace'} TL\n");
  return ($strmPos);
  }

sub EndPage {
  my $streamStart=shift(@_);
  my $streamEnd=0;
  &pos("ET\n");
  if ($fgdesign) {&pos("$fgdesign")}
  $streamEnd=$fpos;
  &pos("endstream\n");
  &pos("endobj\n");
  $location[++$obj]=$fpos;
  &pos("$obj 0 obj\n");
  $buf=sprintf "%d\n",$streamEnd-$streamStart; &pos($buf);
  &pos("endobj\n");
  $lineNO=0;
  }

sub Link {
  my $linkbegin=shift(@_);
  my $linkend=shift(@_);
  my $link=shift(@_);
  my $type=shift(@_);

  my $tmpline=$line;
  $location[++$obj]=$fpos;
  &pos("$obj 0 obj\n");
    &pos("<<");
      &pos("/A<<");
      if ($type eq "url") {
        &pos("/S/URI");
        &pos("/URI($link)");
        } else {
        &pos("/S/Launch");
        my $slink = substr($link, 5); ## Pull the file: from the front
        &pos("/F($slink)");
        }
      &pos(">>");
    &pos("/Type/Annot");
    &pos("/Subtype/Link");
# LLx LLy URx URy
  if (($fontn eq 1) || ($fontn eq 2) || ($fontn eq 3) || ($fontn eq 4)) {
    $buf=sprintf "/Rect[%d %d %d %d]",
$LLx+$linkbegin*$option{'pointSize'}*0.6,
$URy-($tmpline)*($option{'vertSpace'}-$option{'pointSize'})-$tmpline*$option{'pointSize'},
$LLx+($linkbegin+$linkend)*$option{'pointSize'}*0.6+$option{'pointSize'}*0.3,
$URy-($tmpline)*($option{'vertSpace'}-$option{'pointSize'})-($tmpline-1)*$option{'pointSize'}
    }
# To remake Japanese, Chinese, Korean
#   elsif ($fontn eq 20) {
#     $buf=sprintf "/Rect [%d %d %d %d]\n",
# $LLx+$linkbegin*$option{'pointSize'}*1,
# $URy-($tmpline)*($option{'vertSpace'}-$option{'pointSize'})-$tmpline*$option{'pointSize'},
# $LLx+($linkbegin+$linkend)*$option{'pointSize'}*1+$option{'pointSize'}*0.5,
# $URy-($tmpline)*($option{'vertSpace'}-$option{'pointSize'})-($tmpline-1)*$option{'pointSize'};
#     }
#   elsif ($fontn eq 21) {
#     $buf=sprintf "/Rect [%d %d %d %d]\n",
# $LLx+$linkbegin*$option{'pointSize'}*0.7,
# $URy-($tmpline)*($option{'vertSpace'}-$option{'pointSize'})-$tmpline*$option{'pointSize'},
# $LLx+($linkbegin+$linkend)*$option{'pointSize'}*0.7+$option{'pointSize'}*0.35,
# $URy-($tmpline)*($option{'vertSpace'}-$option{'pointSize'})-($tmpline-1)*$option{'pointSize'};
#     }
  elsif (($fontn eq 5) || ($fontn eq 6) || ($fontn eq 7) || ($fontn eq 8)) {
    $buf=sprintf "/Rect[%d %d %d %d]",
$LLx+$linkbegin*($option{'pointSize'}/2-1),
$URy-($tmpline)*($option{'vertSpace'}-$option{'pointSize'})-$tmpline*$option{'pointSize'},
$LLx+$linkbegin*($option{'pointSize'}/2-1)+($linkend+1)*($option{'pointSize'}/2-1),
$URy-($tmpline)*($option{'vertSpace'}-$option{'pointSize'})-($tmpline-1)*$option{'pointSize'}
    }
  else {
  $buf=sprintf "/Rect[%d %d %d %d]",
$LLx+$linkbegin*($option{'pointSize'}/2-1),
$URy-($tmpline)*($option{'vertSpace'}-$option{'pointSize'})-$tmpline*$option{'pointSize'},
$LLx+$linkbegin*($option{'pointSize'}/2-1)+($linkend+1)*($option{'pointSize'}/2-1),
$URy-($tmpline)*($option{'vertSpace'}-$option{'pointSize'})-($tmpline-1)*$option{'pointSize'}
    }
  &pos($buf);
# Bordo azzurro
#  &pos("/C [0 0 1]\n");
# Rettangolo invisibile
    &pos("/Border[0 0 0]");
    &pos("/H/I");
    &pos(">>");
  &pos("endobj\n");
  $annots[$page].="$obj 0 R ";
  }


sub TAB {
  my $line=shift(@_);
  while($line=~/([^\t]*)\t/) {
    my $spaces="";
    my $spaceNO=$option{'tab'}-(length $1)%$option{'tab'};
    for(1..$spaceNO) {$spaces.=" ";}
    $line=~s/([^\t]*)\t/$1$spaces/;
    }
  return($line);
  }

sub substitute {
  my $line=shift(@_);

  $line=~s/#!year#/$year/g;
  $line=~s/#!mon#/$mon/g;
  $line=~s/#!mday#/$mday/g;
  $line=~s/#!hour#/$hour/g;
  $line=~s/#!min#/$min/g;
  $line=~s/#!sec#/$sec/g;
  $line=~s/#!yday#/$yday/g;
  $line=~s/#!wday#/$wday/g;
  $line=~s/#!isdst#/$isdst/g;
  return($line);
  }

sub pos {
  my $string = shift(@_);
  $fpos+=length $string;
  print OUT "$string";
  }

sub Warning {
  my $string = shift(@_);
  print <<WARNING;
Warning: $string

WARNING
  }


sub printusage {
    print <<USAGEDESC;

usage:
        $producer [-options ...] list

where options include:
    -help                        print out this message
    -default                     print out the default parameters
    -configure file              default $producer.cfg
    -landscape
    -list file                   a list of textual input files
    -paper format                default letter, valid formats: A3 (or a3),
                                 A4 (or a4), A5 (or a5), widthxheight
    -npage                       add page number
    -recursive directory         scan recursively the directory
    -match     files             match different files ex. *.pdf, a?.*
                                 (require -recursive option)
    -border                      border line
    -pdfdir directory            the directory where you want to put the PDFs
    -txtdir directory            the directory where you want to put the texts
    -current                     the program version
    -verbose                     verbose
    -test                        run a test without conversions
    -                            use STDIN and STDOUT

list:
    with list you can use metacharacters and relative and absolute path name

example:
    $producer *.txt
    $producer -m "a*.txt" -r my_directory


If you want to know more about this tool, you might want
to read the docs. They came together with $producer1!

Home: $txt2pdfHome

USAGEDESC
    exit(1);
}

sub defaultparams {
    print <<DEFAULTPARAMS;

tmpdir : ./
paper : letter
landscape : 0
font : F1
npage : 0
lines : 60
tab : 8
pointSize : 10
vertSpace : 12
typeencoding : default

DEFAULTPARAMS
    exit(1);
}

exit 0;

# __END__

=head1 NAME

TXT2PDF - Version 10.1 10th November 2009

=head1 SYNOPSIS

Syntax : txt2pdf [-options] files or http urls

=head1 DESCRIPTION

TXT2PDF  is a very flexible and powerful PERL5 program.
It's a converter from text files to PDF format files.  

=head1 Features

TXT2PDF is a native converter,  you don't need to  pass through PostScript
format.  Some  feature  of TXT2PDF includes :

 o every   word  like  http://...   ftp://...   mailto:...   https://... 
   file:...  ldap:... news:...  will become an URL
 o every word like mime:... will become a link that launch the correct
   application and opens the file 
 o you can add page number in every page
 o you can add text at the beginning and at the end of every file
 o you can add a border to every page
 o you can use background and foreground layers
 o every predefined encodings (WinAnsiEncoding, MacRomanEncoding,
   MacExpertEncoding) supported inside the PDF format is
   supported + the Unix default
 o STDIN and STDOUT support
 o japanese support
 o chinese support (traditional and simplified)
 o korean support
 o email support

=head1 Options

where options include:

    -help                        print out this message
    -default                     print out the default parameters
    -configure file              default txt2pdf.cfg
    -landscape
    -list file                   a list of textual input files
    -paper format                default letter, valid formats: A3 (or a3),
                                 A4 (or a4), A5 (or a5), widthxheight
    -npage                       add page number
    -recursive directory         scan recursively the directory
    -match     files             match different files ex. *.pdf, a?.*
                                 (require -recursive option)
    -border                      border line
    -pdfdir directory            the directory where you want to put the PDFs
    -textdir directory           the directory where you want to put the texts
    -current                     the program version
    -verbose                     verbose
    -test                        run a test without conversions
    -                            use STDIN and STDOUT

list:

   with list you can use metacharacters and relative and absolute path 
   name

-configure  filename:  with this option you can configure an alternate
configuration file (the default  configuration  file  is  txt2pdf.cfg,
located  in txt2pdf directory).  This option is very useful if you use
txt2pdf in a automatic task (e.g.  cron).  e.g.
 
  txt2pdf -c c.cfg *.c
  txt2pdf -c url.cfg http://www.sanface.com/.../test.txt
  txt2pdf -m "a*.txt" -r my_directory

-match files -recursive directory: with  these option  you can convert 
all the files in the directory and in every its subdirectories
e.g
txt2pdf -m "a*.txt" -r .
to convert  every file  beginning with a and with txt extension to PDF
inside the . directory and in every its subdirectories 

Every file of the list is converted in a PDF file.  If the file has an
extension the extension is changed with .pdf extension,  if  the  file
doesn't have an extension the .pdf extension is added.

ASCII 8 chars are converted using ISO Latin1 Encoding

CreationDate (The date the document was created) in Info dictionary is
automatically set.

The   automatic   convertion   of  words  like  http://...   ftp://...
mailto:...  https://...  file:...  ldap:...  news:...  to URLs.

=cut
