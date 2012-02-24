#! /c/Perl/bin/perl -w
#
#use Tkx;
#Tkx::grid( Tkx::ttk__button(".b", -text => "Hello, world" ) );
#Tkx::MainLoop();
#
#print INC;
foreach (<@INC>){
	print "$_\n";
}
