#! /bin/tclsh85.exe

proc tgrep {pattern filename} { 
	set f [open $filename r] 
	while { [gets $f line ] } { 
		if {[regexp $pattern $line]} { 
		puts stdout $line 
		} 
	} 
	close $f 
}

tgrep "REF" "file_name"


