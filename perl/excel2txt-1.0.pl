#!perl
############################################################
## excel2txt-1.0
## Written By: Rohit Mishra ( rohit[at]rohitmishra.com)
############################################################

use strict;
use warnings;
use Getopt::Long;
use Spreadsheet::ParseExcel;

my $VERSION = "1.0";
my $xls_file;
my $recordsep;
my $help;
my $fieldsep;
my $txtfile;
my $number = 1;

GetOptions( "xls=s" => \$xls_file,
	    "recordsep=s" => \$recordsep,
	    "fieldsep=s" => \$fieldsep,
	    "txtfile=s" => \$txtfile,
	    "help" => \$help
	  );

if( $help ){
	&Usage;
	exit(0);
}

if( ! $xls_file ){
	&Usage;
	print "Null file name argument. Exiting ..\n";
	exit(1);
} elsif( ! -e $xls_file ){
	print "$xls_file: $!\n";
	exit(2);
}


my $excel_obj = Spreadsheet::ParseExcel->new();
my $workbook = $excel_obj->Parse( $xls_file );

die "Workbook did not return worksheets!\n"
unless ref $workbook->{Worksheet} eq 'ARRAY';

$fieldsep = $fieldsep || " ";
$recordsep = $recordsep || "\n";

open( FILE, ">$txtfile" ) || die( "Could not open file: $txtfile\n" );
for my $worksheet ( @{$workbook->{Worksheet}} ) {
	print "Writing sheet: $number\n";

	my $last_col = $worksheet->{MaxCol};
	my $last_row = $worksheet->{MaxRow};
	
	for my $row ( 0 .. $last_row ) {
		for my $col ( 0 .. $last_col ) {
			my $cell = $worksheet->{Cells}[$row][$col];
			printf FILE ref $cell ? $cell->Value : '';
			printf FILE $fieldsep unless $col == $last_col;
		}
		print FILE $recordsep; 
	}
	print FILE "-" x 72,"\n"; 
	$number++;
}

sub Usage {
	print <<EOF;

This script generates the text file from the Excel file provided to this script.

Usage: $0 
	  -x[ls_file] <Excel file> ( Required )
		  
	          Argument to this option should be an existing, Excel file. 

          -t[xtfile] <O/P txt file> ( Required )

		  The output text file generated from the Excel input file.

		  If the Excel file contains more than one worksheet, the 
		  script will not generate separate text file for each sheet.
		  Instead it will dump all the text output in a single file,
		  separating the sheet outputs with a line "----"

		  
          -r[ecordsep] <record separator> ( Default: "\\n" )

                  Argument to this option, will be the record separator used, while
                  writing the text file.

          -f[ieldsep] <field separator> ( Default: "\\s" )

                  Argument to this option, will be the field separator used, while
                  writing the text file.
	
 	  -h[elp] 
		
		 Print this help information.

EOF

	
}

=head1 NAME

excel2txt-1.0.pl

=head1 DESCRIPTION

This script generates the text file from the Microsoft Excel file provided to this script.
If the Excel file contains more than one worksheets, the text file will contain all the 
worksheet contents arranged top to bottom.

Usage: excel2txt-1.0.pl -x[ls_file] <Excel file> ( Required )
		  
	          Argument to this option should be an existing, Excel file. 

          -t[xtfile] <O/P txt file> ( Required )

		  The output text file generated from the Excel input file.

		  If the Excel file contains more than one worksheet, the 
		  script will not generate separate text file for each sheet.
		  Instead it will dump all the text output in a single file,
		  separating the sheet outputs with a line "----"

		  
          -r[ecordsep] <record separator> ( Default: "\\n" )

                  Argument to this option, will be the record separator used, while
                  writing the text file.

          -f[ieldsep] <field separator> ( Default: "\\s" )

                  Argument to this option, will be the field separator used, while
                  writing the text file.
	
 	  -h[elp] 
		
		 Print this help information.


=head1 README

This script generates the text file from the Microsoft Excel file provided to this script.
If the Excel file contains more than one worksheets, the text file will contain all the 
worksheet contents arranged top to bottom.

=head1 PREREQUISITES

This script requires the C<strict> module.  It also requires
C<Spreadsheet::ParseExcel> and C<Getopt::Long>.

=head1 COREQUISITES

Spreadsheet

=pod OSNAMES

Unix, Solaris, Linux

=head1 AUTHOR

Rohit Mishra E<lt>F<rohit@rohitmishra.com>E<gt>

=head1 COPYRIGHT

Copyright (c) 2006 Rohit Mishra <rohit@rohitmishra.com>. All rights reserved
This program is a free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=pod SCRIPT CATEGORIES

Educational/ComputerScience
Educational

=cut


