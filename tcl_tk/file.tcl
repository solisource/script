#! /bin/tclsh85.exe
#set jin xie
#puts $jin
#ref --> tcl_file_opt

set fid [open "test" r]
set a_fid [open "test_" w+]

while { [gets $fid line] != "-1" } {
	puts stdout $line
	puts $line ;# stdout is default
	puts $a_fid $line ;#Write information to test_
}

close $fid
flush $a_fid ;# write from buffer now now!!!!
close $a_fid

foreach {} {
}

for {} {
}
