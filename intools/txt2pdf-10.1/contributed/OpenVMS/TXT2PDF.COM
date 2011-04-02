$ INSTALL_DIR   = F$PARSE(F$ENVIRONMENT("PROCEDURE"),,,,"NO_CONCEAL")-"]["
$ INSTALL_DIR   = F$EXTRACT(0,F$LOCATE("]",INSTALL_DIR)+1,INSTALL_DIR)-".000000"
$ perl 'INSTALL_DIR'TXT2PDF.; 'p1' 'p2' 'p3' 'p4' 'p5' 'p6' 'p7' 'p8' !


# the perl code starts here


__END__
# end ends there
