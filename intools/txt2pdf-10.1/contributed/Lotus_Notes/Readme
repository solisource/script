I can think of a couple of ways you can incorporate txt2pdf into notes. 
The first way is by giving txt2pdf users the ability to attach the converted pdf
files to a internal document within Notes automatically. I am doing that from
perl using OLE.
The other way is a bit more involved. Lotus Notes uses a very powerful language
called LotusScript.  LotusScript programmers have the ability to import custom
classes (ie. class to convert text to pdf) using a C API or LSX package.
LotusScript already has the ability to work with the file system and
having a text2pdf LotusScript API would prevent the need to shelling out to the
operating system. Potentially this could be used with any Lotus product that
used LotusScript (ie. Lotus 123, Lotus Word Pro, Lotus Approach, etc.). From a
Lotus Notes standpoint.  LotusScript would be able to convert text to pdf on a
schedule.  It could run LotusScript like a CGI program. It could be initiated
from a GUI type environment on the Notes client. It could be initiated from 
the web.

info on LSX -
http://www.lotus.com/developers/devbase.nsf/data/document1950?opendocument
info on C API - http://www.lotus.com/developers/devbase.nsf/homedata/homecapi
Info on OLE for notes in perl::Win32 (look for the 'How do I use
Lotus Notes link')

Charles Daniel <Charles.Daniel@Ebimed.com>
