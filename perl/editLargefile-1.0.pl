#!/home/gnu/bin/perl
############################################################
## editLargefile
## Written By: Rohit Mishra ( rohit[at]rohitmishra.com)
############################################################
## Keywords: BEGIN, INC, tempfile, FileHandle, stat, tempdir,
##           select, TextUndo, bind, configure, sysread,
##           syswrite, update, numberChanges, messageBox
############################################################


BEGIN {
	unshift( @INC,"." );
}

### Use following modules
###
use strict;
use Tk 800;
use Tk;
use File::stat;
use FileHandle;
use File::Path;
use File::Spec;
use File::Temp qw/ tempfile tempdir /;
require TextUndo;
require Tk::DialogBox;
require Tk::Dialog;
require Tk::Table;
require FileSelect;
require Tk::Balloon;


### Global Defines
###
my $NO = 0;
my $YES = 1;
my $CANCEL = -1;
my $ver = '1.0';
my $bg_color = "wheat1";
my $dir = "./";
my $template = ".largefile.XXXX";
my @tmpfile_array = ();
my $current_file;
my $no_page = $YES;
my $open_status = 0;
my $FILENAME = undef;
my %toolbar;
my $toolbardir = "./toolbar";

### To save the split file
###
my $split_dir = "./split_dir";
my $split_file = "file";
my $extn = 0;

### Temporary Directory functions
###
my $tempdir = tempdir ( $template, DIR => $dir , CLEANUP => 1 );


### Number of pages
###
my $HOME = $ENV{HOME};
my $number_of_pages = 1;
my $tmpfile_size;
my $xsize=600;
my $ysize=900;
my $font="-adobe-courier-medium-r-normal--14-100-100-100-m-90-iso8859-1";
if( ! -e "$HOME/.largefile.rc" ){
	open( RC,">$HOME/.largefile.rc" ) || die("$!");
	print RC "VERSION=1.5\n";
	print RC "PAGES=1\n";
	print RC "XSIZE=600\n";
	print RC "YSIZE=900\n";
	print RC "FONT=-adobe-courier-medium-r-normal--14-100-100-100-m-90-iso8859-1\n";	
	print RC "BACKGROUND=wheat1\n";
	print RC "FOREGROUND=black\n";
	print RC "TOOLBARDIR=./toolbar\n";
	close(RC);
} else {
	open( RC,"$HOME/.largefile.rc" ) || die("$!");
	my @setup = <RC>;
	close(RC);
	foreach my $line ( @setup ){
		if( $line =~ /VERSION\s*=\s*(\S+)/ ){
			$ver = $1; 
		} 
		if( $line =~ /PAGES\s*=\s*(\S+)/ ){
			$number_of_pages = $1; 
		} 
		if( $line =~ /XSIZE\s*=\s*(\S+)/ ){
			$xsize = $1;
		}
		if( $line =~ /YSIZE\s*=\s*(\S+)/ ){
			$ysize = $1;
		}
		if( $line =~ /BACKGROUND\s*=\s*(\S+)/ ){
			$bg_color = $1;
		}
		if( $line =~ /FONT\s*=\s*(\S+)/ ){
			$font = $1;
		}
		if( $line =~ /TOOLBARDIR\s*=\s*(\S+)/ ){
			$toolbardir = $1;
		}
	}
}


### Main Code Begins
###
my $mw = MainWindow->new( -title => "Largefile Editor $ver" );
$mw->minsize( $ysize,$xsize );

my $menubar1 = $mw->Frame(-relief => 'raised', -borderwidth => 2);
my $menubar2 = $mw->Frame(-relief => 'raised', -borderwidth => 2);


### Read toolbar images
###
foreach (qw/open save undo redo exit/){
  	$toolbar{$_} = $mw->Photo( -file => "$toolbardir/$_.gif" )
    	unless defined $toolbar{$_};
}


## File Menu
##
$menubar1->Menubutton(qw/-text File -underline 0 -tearoff 0 -menuitems/ =>
  [
	  [Button => 'Open ..', -command => 
				sub{ 
					if( $open_status == 0 ){
						$open_status = 1;
						$FILENAME = &Open_LargeFile;
						$open_status = 0;
					} 
				}],
	  [Button => 'Save this buffer ..', -command =>
                                sub{
					&On_Save( $FILENAME );
                                }],
	  [Button => 'Save Largefile ..', -command =>
                                sub{
                                        &Save_LargeFile( $FILENAME );
                                }],
	  [Button => 'Save Largefile As ..', -command =>
                                sub{
					if( defined $FILENAME ){
						if( $open_status == 0 ){
							$open_status = 1;
							&On_SaveAs;
							$open_status = 0;
						}
					} else {
						my $dialog = $mw->Dialog(-title => 'Warning', -text => 'No File opened!!');
                                                $dialog->Show('-global');
					}
                                }],
	  [Separator => ''],
	  [Button => 'Close ..', -command =>
                                sub{
                                        &On_Close;
                                }],
	  [Separator => ''],
	  [Button => 'Quit', -command => 
				sub{ 
					&On_Exit( $FILENAME );
				}],
  ])->pack(-side=>'left');

## Edit Menu
##
$menubar1->Menubutton(qw/-text Edit -underline 0 -tearoff 0 -menuitems/ =>
  [
          [Button => 'Undo', -command =>
                                sub{
					&On_Undo;
                                }],
          [Button => 'Redo', -command =>
                                sub{
					&On_Redo;
                                }],
          [Separator => ''],
          [Button => 'Select All', -command =>
                                sub{
					&On_SelectAll;
                                }],
	  [Button => 'Unselect All', -command =>
                                sub{
                                        &On_UnselectAll;
                                }],
  ])->pack(-side=>'left');

## View Menu
##
$menubar1->Menubutton(qw/-text View -underline 0 -tearoff 0 -menuitems/ =>
  [
          [Button => 'Previous Page', -command =>
                                sub{
                                        &Traverse_To_Prev;
                                }],
          [Button => 'Next Page', -command =>
                                sub{
                                        &Traverse_To_Next
                                }],
          [Separator => ''],
          [Button => 'Go To Page', -command =>
                                sub{
                                        &Open_Page;
                                }],
  ])->pack(-side=>'left');

### Toolbar shortcuts
###
my $balloon = $mw->Balloon(-background=>'lightyellow',-initwait=>550);

$balloon->attach( $menubar2->Button( -image => $toolbar{'open'} , -command=> 
				sub{
                                   	if( $open_status == 0 ){
                                   		$open_status = 1;
                                   		$FILENAME = &Open_LargeFile;
                                   		$open_status = 0;
                                   	}
                                } )->
pack( -side => 'left'), -balloonmsg => 'Open File');

$balloon->attach( $menubar2->Button( -image => $toolbar{'save'} , -command=>
                                sub{
                                       	&On_Save( $FILENAME );
                                } )->
pack( -side => 'left'), -balloonmsg => 'Save this chunk');

$balloon->attach( $menubar2->Button( -image => $toolbar{'undo'} , -command=>
                                sub{
					&On_Undo;
				} )->
pack( -side => 'left'), -balloonmsg => 'Undo Change');

$balloon->attach( $menubar2->Button( -image => $toolbar{'redo'} , -command=>
                                sub{
					&On_Redo;
				} )->
pack( -side => 'left'), -balloonmsg => 'Redo Change');

$balloon->attach( $menubar2->Button( -image => $toolbar{'exit'} , -command=>
                                sub{
                                        &On_Exit( $FILENAME );
                                } )->
pack( -side => 'right'), -balloonmsg => 'Exit');




my $InputText = $mw->Scrolled('TextUndo', -height => '1', -width => '1', -scrollbars => 'osoe', -background=>$bg_color,-font => $font,) ;

my $Basemenu = $mw->Frame(-relief => 'raised', -borderwidth => 2);
my $b_next = $Basemenu->Button( -text => "Next Page >>", -state => 'disabled', 
		 -disabledforeground => 'blue', -command => 
					sub{ 
						&Traverse_To_Next 
					});
my $b_prev = $Basemenu->Button( -text => "<< Prev Page", -state => 'disabled',
		 -disabledforeground => 'blue', -command => 
					sub{ 
						&Traverse_To_Prev 
					});
my $b_pages = $Basemenu->Button( -text => "Go To Page", -state => 'disabled',
		 -disabledforeground => 'blue', -command => 
		sub{ 
				&Open_Page;
		});
my $Lbl_Page_No = $Basemenu->Label( -text => 'No Page Open' );

### Pack everything
###
$menubar1->form( -top=> '%0', -left => '%0', -right => '%100' );
$menubar2->form( -top=> $menubar1, -left => '%0', -right => '%100' );
$InputText->form( -top=> $menubar2, -left => '%0', -right => '%100', -bottom => $Basemenu );
$Basemenu->form( -left=> '%0', -right => '%100', -bottom => '%100' );
$b_prev->pack( -side => 'left' );
$b_next->pack( -side => 'left' );
$b_pages->pack( -side => 'left' );
$Lbl_Page_No->pack( -side => 'right' );

&MainLoop;


### User Defined Subroutines
###

### File menu callbacks

sub Open_File(){
	my $main = shift;
	my $CWD = $ENV{PWD};
	my $filename;
 	my $types = [
		     	['All Files',        '*',             ],
     			['Text Files',       ['.txt', '.text']],
		     	['TCL Scripts',      '.tcl'           ],
		     	['C Source Files',   '.c',      'TEXT'],
		     	['GIF Files',        '.gif',          ],
		     	['GIF Files',        '',        'GIFF'],
 		    ];

	$filename = $main->FileSelect( -directory => $CWD, -title=>'Select File', -verify => ['-f','-r'] )->Show; 
	return ( $filename );
}

sub Open_LargeFile(){
   my $filename = &Open_File( $mw );

   my $sb;
   my $size;
   if( ( !defined $filename ) && ( ! -f $filename ) ){
	return;
   } else {
       	$sb = stat( $filename );
 	$size = $sb->size;
        my $line;
	my $i = 0;
	my $var = 33;
	my $pages;
	my $time_left;
	my $total_time;
	my $dis_time_left;
	my $time_for_one_page = 1.0; # seconds
	my $title = "Opening File: $filename";
	if( $number_of_pages != 0 ){
		$tmpfile_size = $size/$number_of_pages;
	} else {
		print "Number of pages cannot be less than 1\n";
		exit(0);
	}


        if( $size <= $tmpfile_size ){
                $InputText->Load( $filename );
		$no_page = $YES;
		$current_file = 0;
		$Lbl_Page_No->configure( -text => "Page No: $current_file" );
		&Disable;
		$mw->configure( -title => "LargeFile Editor $ver: $filename" );
        } else {
		$pages = $size/$tmpfile_size;	
		$total_time =  sprintf("%.2f",( $pages * $time_for_one_page ) );

		my $top = $mw->Toplevel( -title => "Please Wait...",-popover => $mw);
		$top->resizable('no','no');

		$top->Label(-textvariable => \$title )->pack;
   		$top->Label(-textvariable => \$dis_time_left )->pack;

   		my $m = $top->Frame(-height => 10, -border => 2, -relief => 'sunken')->pack(-fill => 'x');
   		my $s = $m->Frame(-background => 'blue', -relief => 'raised', -border => 2);

		&Busy;

		open( FILE, "< $filename" ) || die( "Could not open file $filename" );
		$var = sysread( FILE, $line, $tmpfile_size );
		while( $var != $NO ){
			( undef, $tmpfile_array[$i] ) = tempfile( $template, DIR => $tempdir, OPEN => 0 );
			open( TMP,">$tmpfile_array[$i]" ) || die( "Could not open file $tmpfile_array[$i]" );
			if( $ARGV[0] =~ m|^\-s| ){
				open( SPLIT,">$split_dir/$split_file$extn" ) || 
				die( "Could not open file $split_dir/$split_file$extn" );
			}
			syswrite( TMP, $line );	
			if( $ARGV[0] =~ m|^\-s| ){
				syswrite( SPLIT, $line );	
				close( SPLIT );
				$extn++;
			}
			close( TMP );
			$i++;

			$time_left = sprintf("%.2f",( $total_time  - ( $i * $time_for_one_page )) );
			$dis_time_left = sprintf("Time Left: %.0f mins %.0f seconds",$time_left/60,$time_left%60 );

			$s->place('-x' => 0, '-y' => 0, -relheight => 1, 
			-relwidth => ($total_time - $time_left)/$total_time );
			$top->update;
			$var = sysread( FILE, $line, $tmpfile_size ); 
		}
		$top->destroy;
		close( FILE );

		$current_file = 0;

		$InputText->Load( $tmpfile_array[0] );
		$mw->configure( -title => "LargeFile Editor $ver: $filename" );
		$Lbl_Page_No->configure( -text => "Page No: $current_file" );
		&Unbusy;

		&Enable();
		$no_page = $NO;
        }
	return ( $filename );
   }
}


sub Traverse_To_Next(){
	my $var = scalar ( @tmpfile_array ) - 1;
	if( $current_file < $var ){
		&main::Tk::TextUndo::ConfirmDiscard( $InputText );
		$current_file++;
		$InputText->Load( $tmpfile_array[$current_file] );
		$Lbl_Page_No->configure( -text => "Page No: $current_file" );
	} else {
		$current_file = $current_file;
	} 
}

sub Traverse_To_Prev(){
	if( $current_file != 0 ){
		&main::Tk::TextUndo::ConfirmDiscard( $InputText );
		$current_file--;
		$InputText->Load( $tmpfile_array[$current_file] );
		$Lbl_Page_No->configure( -text => "Page No: $current_file" );
	} else {
		$current_file = $current_file;
	}
}

sub Open_Button_Page(){
	my $top = $mw->Toplevel( -title => "Select Page" );
	$top->minsize( qw/300 100/);
	$top->maxsize( qw/300 300/);
	my $page_container = $top->Table( -rows => '20', -columns => '20',-scrollbars => 'se' );
	my $manubar = $top->Frame( -relief => 'sunken' );
	my $cancel = $manubar->Button( -text => "Cancel", -command => 
			sub{
				$top->destroy; 
			});
	$page_container->form( -left => '%0', -top => '%0', -right => '%100', -bottom => $manubar );
	$manubar->form( -left => '%0', -right => '%100', -bottom => '%100', );
	$cancel->pack( -side => 'left', -fill => 'x', -expand => '1' );

	my $no_of_pages = scalar( @tmpfile_array ) - 1 ;	
	my @buttons = ();

	for( my $i = 0; $i <= $no_of_pages; $i++ ){
		$buttons[$i] = $page_container->Button( -text => "$i" ); 	
		$page_container->put( $i%10, $i/10, $buttons[$i] );
	}
	return $top, @buttons;
}

sub Open_Page (){
	my $page_no;
	my ($w, @buttons) = &Open_Button_Page();
	foreach my $button ( @buttons ){
		$button->bind( '<Button-1>' => sub{ 
			&main::Tk::TextUndo::ConfirmDiscard( $InputText );
			$page_no = $button->cget(-text); 
			$Lbl_Page_No->configure( -text => "Page no: $page_no" );
			$w->destroy;
			$InputText->Load( $tmpfile_array[$page_no] ); 
			$current_file = $page_no;
		}); 
	}
}

sub On_SaveAs(){
 	my $name = $InputText->CreateFileSelect('getSaveFile',-title => 'File Save As');
 	return &Save_LargeFile( $name ) if defined($name) and length($name);
 	#return &On_Save( $name ) if defined($name) and length($name);
 	return 0;
}

sub On_Undo(){
	$InputText->undo;	
}

sub On_Redo(){
	$InputText->redo;	
}

sub On_SelectAll(){
 	$InputText->tagAdd('sel','1.0','end');
}

sub On_UnselectAll(){
	$InputText->tagRemove('sel','1.0','end');
}

sub On_Save(){
	my $filename = shift;

	if( defined $filename ){
		$InputText->Save;
	} else {
		my $dialog = $mw->Dialog(-title => 'Warning', -text => 'No File opened!!');
                $dialog->Show('-global');
	}
}

sub Save_LargeFile(){
	my $filename = shift;
	my $line;

	if( defined $filename ){
		open( FILE,">$filename" ) || $mw->Dialog(-title => 'Warning', -text => 'File not writable.')->Show('-global');
		foreach my $tmpfile ( @tmpfile_array ){
			open( TMP,"$tmpfile" ) || die( "Could not open swap file $tmpfile\n" );
			if( sysread( TMP, $line, $tmpfile_size ) != $NO ){
				chomp( $line );
				syswrite( FILE, $line );
			}
			close( TMP );
		}
		close( FILE );
	} else {
		my $dialog = $mw->Dialog(-title => 'Warning', -text => 'No File opened!!');
                $dialog->Show('-global');
	}
}

sub On_Close(){
	if( $InputText->ConfirmDiscard ){
		$FILENAME = undef;
		$InputText->EmptyDocument;
		@tmpfile_array = ();
                $mw->configure( -title => "LargeFile Editor $ver" );
                $Lbl_Page_No->configure( -text => "No Page Open" );
		&Disable();
                $no_page = $YES;
	} else {
		return;
	}	
}

sub On_Exit (){
	my $filename = shift;

	if( defined $filename ){
		if( -w $filename ){
			### Check Sticky bit here
 			if ( $InputText->numberChanges ){
   				my $ans = $mw->messageBox(-icon => 'warning', -type => 'YesNoCancel', -default => 'Yes', -message => 
				"The text has been modified without being saved.  Save edits?");
   				if( $ans eq 'Cancel' or $ans eq 'No' ){
					exit(0);
				} elsif( $ans eq 'Yes' ){
					$InputText->Save( $tmpfile_array[$current_file] );
					&Save_LargeFile( $filename );
					exit(0);
				}
  			} else {
				exit(0);
			}
		} else {
			if ( $InputText->numberChanges ){
				my $ans = $mw->messageBox(-icon => 'warning', -type => 'YesNoCancel', -default => 'Yes', -message => 
				"File not writable. Quit?");
				if( $ans eq 'Cancel' or $ans eq 'No' ){
       	                		 return;
       		         	} elsif( $ans eq 'Yes' ){
       	                		 exit(0);
       		         	}
			} else {
				exit(0);
			}
		}
	} else {
		exit(0);
	}
	
}

sub Busy (){
	$mw->Busy;
        $InputText->Busy;
}

sub Disable (){
	$b_prev->configure( -state => 'disabled' );
        $b_next->configure( -state => 'disabled' );
        $b_pages->configure( -state => 'disabled' );
}

sub Unbusy (){
        $mw->Unbusy;
        $InputText->Unbusy;

}

sub Enable(){
        $b_prev->configure( -state => 'normal' );
        $b_next->configure( -state => 'normal' );
        $b_pages->configure( -state => 'normal' );
}

__END__

=head1 NAME

editLargefile.pl - Edit files of size greater than 2.8 GB

=head1 SYNOPSIS

editLargefile.pl

=head1 STATUS

editLargefile.pl is in its beta version. Report all bugs to the author.

=head1 DESCRIPTION

B<editLargefile.pl> is a window based editor with all the editing 
capabilities a TextUndo text widget has. This editor is 
recomended for editing a file of size more than 2.8 GB. Such largefile(1) 
cannot be handled by editors which come with the UNIX(1) 
standard installation.
Ideal for editing files which are generated by some EDA tools. e.g DSPF or 
SPEF file which contains the parasitic information of a hardware design.

=head1 FEATURES

B<editLargefile.pl> uses sysread and syswrite system calls which makes 
it very efficient.
At startup, it creates a .largefile.rc file which contains information about
the default settings which a user wishes to use. The opened file is split into
smaller chunks of data, which are displayed on a TextUndo widget. When the 
editing is complete, the user only has to save the chunk which has been modified
and not the whole file, which drastically reduces the file saving time.
The user can browse through the pages(chunks) serially or can jump directly 
to the page to be edited.
Additionally, all the editing can be un-done or re-done at any point. 

=head1 BUGS

When the editor crashes, it leaves temporary directories with the split 
files in them.

=head1 PREREQUISITES

Tk
File::stat
FileHandle
File::Path
File::Spec
File::Temp
TextUndo
Tk::DialogBox
Tk::Dialog
Tk::Table
FileSelect
Tk::Balloon

=head1 OSNAMES
Unix, Linux, Solaris

=head1 AUTHOR

Rohit Mishra E<lt>F<rohit@rohitmishra.com>E<gt>

=head1 COPYRIGHT

Copyright (c) 2005 Rohit Mishra <rohit@rohitmishra.com>. All rights reserved
This program is a free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SCRIPT CATEGORIES
Unix/System_administration
Educational

=cut


