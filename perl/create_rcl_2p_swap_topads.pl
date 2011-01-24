#! /usr/bin/perl 
if (($ARGV[0] eq "-in") && ($ARGV[2] eq "-out") && ($ARGV[4] eq "-package") && ($ARGV[6] eq "-cae") && ($ARGV[8] eq "-ref") )
{
$infile=$ARGV[1];
$outfile=$ARGV[3];

$package=$ARGV[5];
$cae=$ARGV[7];
$ref=$ARGV[9];

open (F_infile,"<$infile") or die;
@in=<F_infile>;
close F_infile;

open (F_outfile,"+>$outfile");
		print F_outfile "                               \n";
		print F_outfile "*PADS-LIBRARY-PART-TYPES-V2007*\n";
foreach my $part (@in)
		{
		chomp $part;
		#print "$part\n";
		print F_outfile "                               \n";
		print F_outfile "$part $package I $ref 2 1 0 0 0\n";
		print F_outfile "TIMESTAMP 2011.01.06.14.30.03\n";
		if ($cae=~m/R/)
			{print F_outfile "\"Vendor\" yageo,tyohm,caiyuan/caizhi,fenghua\n"; 
			 print F_outfile "\"Tolerance\" D=0.5%,F=1%,G=2%,J=5%/I,K=10%/II,M=20%/III\n"; }
		elsif ($cae=~m/C/)
			{print F_outfile "\"Vendor\" yageo\n"; 
			 print F_outfile "\"Tolerance\" B=0.1,C=0.25p,D=0.5p,F=1%,G=2%,J=5%/I,K=10%/II,M=20%/III\n"; }
		elsif ($cae=~m/L/)
			{print F_outfile "\"Vendor\" yageo\n"; 
			 print F_outfile "\"Tolerance\" D=0.5%,F=1%,G=2%,J=5%/I,K=10%/II,M=20%/III\n"; }
		print F_outfile "GATE 1 2 1\n";
		print F_outfile "$cae\n";
		print F_outfile "1 1 B\n";
		print F_outfile "2 1 B\n";
		print F_outfile "     \n";
		}
		print F_outfile "*END*\n";
		print F_outfile "                               \n";
close F_outfile;
}
else
{
	print "*******************************************************************\n";	
	print "*set.pl -in infile -out outfile -package package -cae cae -ref ref*\n";	
	print "*Note:only for R C L device                                       *\n";	
	print "*******************************************************************";	
	exit;
}	
