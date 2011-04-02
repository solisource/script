#!/usr/bin/perl
# Require Perl5
#
# txt2pdf.cgi -- cgi-bin: "Create your PDF"
#
# by SANFACE Software <sanface@sanface.com> 25 January 2001
#
# This is version 3.0.
#

use CGI qw(:standard);
# with apache and mod_perl 
# use CGI::Apache qw(:standard);
use MIME::Lite;
#
# Variables you need to customize
#
my $dirpath="/usr/wwwusers/indiv/sanface";
my $dirhome="txt2pdf_cgi";
my $intext=$dirpath."/".$dirhome."/yourpdf";
my $outpdf=$dirpath."/".$dirhome."/yourpdf";
my $Counter_file=$dirpath."/".$dirhome."/count_file";
my $cfg_file=$dirpath."/".$dirhome."/txt2pdf.cfg";
my $pdfurl="http://www.sanface.com/".$dirhome."/yourpdf";
my $sendmail="localhost";

my $versioncgi="3.0";
my $producercgi="txt2pdf.cgi";
my $company="SANFACE Software";
my $quanti;

my $home="http://www.sanface.com";
my $mail="sanface\@sanface.com";
$query=new CGI;
if (!$query->param) {
  print $query->header;
  print $query->start_html(-title=>'Create your PDF',
                   -BGCOLOR=>'white'),"\n";
  print "<CENTER>\n",$query->h1('Create your PDF'),"\n";
  print $query->h2(qq!with <A HREF="$home/txt2pdf_cgi.html">$producercgi $versioncgi</A> by <A HREF="mailto:$mail">$company</A>© 2000  <A HREF="$home">$home</A>!),"\n";
  print $query->start_form,"\n",
  "<B>Title:</B> ",textfield(-name=>'title',-size=>17),"<BR>\n","<B>Your text:</B><BR>\n";
  print $query->textarea(-name=>'Text',
                         -rows=>25,
                         -columns=>80),p,"\n";
  print $query->popup_menu(-name=>'font',
                            -values=>['Courier','Helvetica','Times'],
                            -default=>'Courier'),"\n";
  print $query->popup_menu(-name=>'paper',
                            -values=>['letter','A4','A5','A3','tabloid','ledger','legal'.'statement','executive'],
                            -default=>'letter'),"\n";
  print $query->checkbox(-name=>'border',
#                         -checked=>'checked',
                         -value=>'1',
                         -label=>'border')," \n";
  print $query->checkbox(-name=>'npage',
#                         -checked=>'checked',
                         -value=>'1',
                         -label=>'page number')," \n";
  print $query->checkbox(-name=>'columns2',
#                         -checked=>'checked',
                         -value=>'1',
                         -label=>'2 columns'),
  p,
  reset," ";
  print $query->submit(-name=>'.submit',
                       -value=>'TXT-->PDF'),
  end_form,qq#\n<hr>\n<I>Create your PDF</I> is a trademark of <A HREF="$home">$company</A>© 2000. - <A HREF="mailto:$mail">$mail</A>\n</CENTER>#;
  print $query->end_html;
  }
elsif($query->param('.send')) {
  my $email=$query->param('email');
  my $emailfriend=$query->param('emailfriend');
  my $emailtitle=$query->param('emailtitle');
  my $emailbody=$query->param('emailbody');
  my $hidden=$query->param('hidden_name');
  $msg = new MIME::Lite
        From    =>"$email",
        To      =>"$emailfriend",
#       BCC ???
        Subject =>"$emailtitle",
        Type    =>'multipart/mixed';
  $msg->attach(Type     =>'TEXT',
               Data     =>"$emailbody");
  my $attach=$outpdf.$hidden.".pdf";
  $msg->attach(Type     =>'application/pdf',
               Filename =>"yourpdf.pdf",
               Encoding =>'base64',
               Path     =>"$attach");

  MIME::Lite->send('smtp', $sendmail, Timeout=>60);
  $msg->send;
  print $query->header;
  print $query->start_html(-title=>'SENT',
                 -BGCOLOR=>'white'),"\n";
  print "<H1>Sent your PDF</H1>\nYour PDF was sent to $emailfriend\n<P>";
  print qq!Return to <A HREF="/createpdf.html">Create your PDF</A>\n!;
  print $query->end_html;
  exit;
  }
else
  {
  open ( FILE,"$Counter_file");
  $quanti=<FILE>;
  if ($quanti == 9) {$quanti = 0}
  else {$quanti++}
  close(FILE);
  $intext.="$quanti.txt";
  $outpdf.="$quanti.pdf";
  $pdfurl.="$quanti.pdf";

  my $cgitext=$query->param('Text');
  open (INTEXT,">$intext");
  print INTEXT "$cgitext\n";
  close(INTEXT);
  flock(INTEXT,8);

  open (FILE,">$Counter_file");
  print FILE $quanti;
  close(FILE);
  flock(FILE,8);
  open (CFG,">$cfg_file");
  my $cgiborder=0;
  my $cginpage=0;
  my $cgicolumns2=0;
  my $cgititle=$query->param('title');
  my $cgifont=$query->param('font');
  my $cgipaper=$query->param('paper');
  $query->param('border') and $cgiborder=1;
  $query->param('npage') and $cginpage=1;
  $query->param('columns2') and $cgicolumns2=1;
  print CFG <<CONFIGURE;
tmpdir : /usr/tmp/
# author : 
# creator :
# keywords :
# subject : 
title : $cgititle
paper : $cgipaper
# landscape : 1
font : $cgifont
columns2 : $cgicolumns2
npage : $cginpage
# cols : 80
# lines :
# tab : 8
# pointSize : 10
# vertSpace : 12
border : $cgiborder
# transition : split!H!I!
# transition : split!H!O!
# transition : split!V!I!
# transition : split!V!O!
# transition : blinds!H!
# transition : blinds!V!
# transition : box!I!
# transition : box!O!
# transition : wipe!0!
# transition : wipe!90!
# transition : wipe!180!
# transition : wipe!270!
# transition : dissolve
# transition : glitter!0!
# transition : glitter!270!
# transition : glitter!315!
CONFIGURE
  close(CFG);
  flock(CFG,8);

  &txt2pdf($intext);
#  print $query->redirect(-location=>"$pdfurl",-method=>GET);
   print $query->header;
   print $query->start_html(-title=>'Your PDF',
                     -BGCOLOR=>'white'),"\n";
   print $query->h1('Your PDF'),"\n";
   print qq!This is <A HREF="$pdfurl">your PDF</A> generated by<P>\n!;
   print qq#<I>Create your PDF</I> a trademark of <A HREF="$home">$company</A>© 2000. - <A HREF="mailto:$mail">$mail</A><BR>\n<P>\nUse the new service <B>Send your PDF to your friend</B>!<BR>\n<B>NOTE: you need to compile email fields with two valid email!</B><BR>\n#;
   print $query->start_form,"\n",
     "<TABLE><TR><TD><B>Your e-mail:</B></TD><TD>\n",
     textfield(-name=>'email',
               -size=>40),"</TD></TR>\n",
     "<TR><TD><B>Your friend e-mail:</B></TD><TD>\n",
     textfield(-name=>'emailfriend',
               -size=>40),"</TD></TR>\n",
     "<TR><TD><B>The title of the message:</B></TD><TD>\n",
     textfield(-name=>'emailtitle',
            -size=>40),"</TD></TR></TABLE>\n",
     "<TABLE><TR><TD><B>The body of the message:</B></TD></TR>\n<TR><TD>";
     print $query->textarea(-name=>'emailbody',
                            -rows=>5,
                            -columns=>60),"</TD></TR></TABLE><BR>\n";
     $query->param('hidden_name',"$quanti");
     print $query->hidden('hidden_name')," ";
     print $query->reset," ";
     print $query->submit(-name=>'.send',-value=>'Send'),end_form,
     "\n<B>Please, don't use improperly this free service!</B>\n</CENTER>",end_html;
  }
  
sub txt2pdf {
my @ARGV=shift(@_);

## Put here the txt2pdf perl code
##
## Remember: you need to change the line
##
## my $configure="txt2pdf.cfg";
##
## with 
##
my $configure=$cfg_file;
##
## Obviously we authorize you to make this modify
##


}


