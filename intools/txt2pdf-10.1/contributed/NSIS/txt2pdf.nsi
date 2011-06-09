; txt2pdf.nsi
;
; This script is based on example1.nsi, but adds uninstall support
; and (optionally) start menu shortcuts.
;

!define VER "80"
!define VER_POINT "8.0"
!define PRODUCT_NAME "txt2pdf"

!include "MUI.nsh"

SetCompressor lzma

Name "txt2pdf 8.0"

VIProductVersion "8.0.0.0"
VIAddVersionKey "CompanyName" "SANFACE Software"
VIAddVersionKey "FileVersion" "8.0.0.0"
VIAddVersionKey "FileDescription" "txt2pdf 8.0 Self-Extract Setup"
VIAddVersionKey "InternalName" "txt2pdf.exe"
VIAddVersionKey "LegalCopyright" "1999-2005 SANFACE Software"
VIAddVersionKey "LegalTrademarks" "SANFACE Software"
VIAddVersionKey "OriginalFilename" "txt2pdf.exe"
VIAddVersionKey "ProductName" "txt2pdf"
VIAddVersionKey "ProductVersion" "8.0.0.0"
VIAddVersionKey "Comments" "txt2pdf to convert old txt, spool, text, textual report to nice pdf"

  !define MUI_ICON ${NSISDIR}\Contrib\Graphics\Icons\logo.ico
  !define MUI_UNICON ${NSISDIR}\Contrib\Graphics\Icons\logo.ico 

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages


  !insertmacro  MUI_PAGE_WELCOME
  !define MUI_LICENSEPAGE_RADIOBUTTONS
  !insertmacro  MUI_PAGE_LICENSE "LicenseWin.txt"
  !insertmacro  MUI_PAGE_COMPONENTS
  !insertmacro  MUI_PAGE_DIRECTORY
  !insertmacro  MUI_PAGE_INSTFILES
  !define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\Docs\txt2pdf.html"
  !insertmacro  MUI_PAGE_FINISH

  !insertmacro  MUI_UNPAGE_CONFIRM
  !insertmacro  MUI_UNPAGE_INSTFILES

  ;Language
  !insertmacro MUI_LANGUAGE "English"

  ;Descriptions
  LangString DESC_SecCopyTxt2pdf ${LANG_ENGLISH} "Copy ${PRODUCT_NAME} core to the application folder."
  LangString DESC_SecCreateUninst ${LANG_ENGLISH} "Create an uninstaller to delete ${PRODUCT_NAME}."
  LangString DESC_SecCreateShortcuts ${LANG_ENGLISH} "Create Shortcuts."
  LangString DESC_SecCreateShellExtensions ${LANG_ENGLISH} "Create Shell Extensions."
  LangString DESC_SecCreateIcon ${LANG_ENGLISH} "Create Desktop Icon to run Visual txt2pdf."
  LangString DESC_SecDownHlp ${LANG_ENGLISH} "Download the HELP Windows documentation."

; The name of the installer
;Name txt2pdf${VER}
Caption "txt2pdf v. ${VER_POINT} by SANFACE Software"

; The file to write
OutFile txt2pdf${VER}.exe

; The default installation directory
InstallDir $PROGRAMFILES\txt2pdf${VER}
; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM SOFTWARE\txt2pdf${VER} ""

;InstType "Full (w/ Source and Contrib)"
;InstType "Normal (w/ Contrib, w/o Source)"
;InstType "Lite (w/o Source or Contrib)"

AutoCloseWindow false
ShowInstDetails show
ShowUninstDetails show
SetOverwrite on
SetDateSave on

; The stuff to install
Section "txt2pdf${VER} (required)" SecCopyTxt2pdf
SectionIn RO

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  ; Put file there
  File txt2pdf.cfg
  File txt2pdf.pl
  File txt2pdf.exe
  File txt2pdf.nsi
  File Visual_txt2pdf.exe
  File colour.cfg
  File ReadmeWin.txt
  File LicenseWin.txt
  SetOutPath $INSTDIR\Tests
  File Tests\*.*
  SetOutPath $INSTDIR\EPD
  File EPD\*.*
  SetOutPath $INSTDIR\Docs
  File Docs\*.*
  SetOutPath $INSTDIR\Languages\greek
  File Languages\greek\*.*
  SetOutPath $INSTDIR\Languages\japanese
  File Languages\japanese\*.*
  SetOutPath $INSTDIR\Languages\korean
  File Languages\korean\*.*
  SetOutPath $INSTDIR\Languages\polish
  File Languages\polish\*.*
  SetOutPath $INSTDIR\Languages\simplchinese
  File Languages\simplchinese\*.*
  SetOutPath $INSTDIR\Languages\tradchinese
  File Languages\tradchinese\*.*
  SetOutPath $INSTDIR\Languages\thai
  File Languages\thai\*.*
  SetOutPath $INSTDIR\contributed\Lotus_Notes
  File contributed\Lotus_Notes\*.*
  SetOutPath $INSTDIR\contributed\NSIS
  File contributed\NSIS\*.*
  SetOutPath $INSTDIR\contributed\SCOlp
  File contributed\SCOlp\*.*
  SetOutPath $INSTDIR\contributed\txt2pdf.cgi
  File contributed\txt2pdf.cgi\*.*
  SetOutPath $INSTDIR\plug-ins
  File plug-ins\*.*

  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\txt2pdf${VER} "Install_Dir" "$INSTDIR"
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\txt2pdf${VER}" "DisplayName" "txt2pdf${VER} (remove only)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\txt2pdf${VER}" "UninstallString" '"$INSTDIR\uninstall-txt2pdf.exe"'

  ; since the installer is now created last (in 1.2+), this makes sure 
  ; that any old installer that is readonly is overwritten.
  Delete $INSTDIR\uninstall-txt2pdf.exe 

SectionEnd

Section "Create uninstaller" SecCreateUninst

  WriteUninstaller "$INSTDIR\uninstall-txt2pdf.exe"

SectionEnd

; optional section
Section "Start Menu Shortcuts" SecCreateShortcuts
  CreateDirectory "$SMPROGRAMS\txt2pdf${VER}"
  CreateShortCut "$SMPROGRAMS\txt2pdf${VER}\Uninstall.lnk" "$INSTDIR\uninstall-txt2pdf.exe"
  CreateShortCut "$SMPROGRAMS\txt2pdf${VER}\License.lnk" "$INSTDIR\LicenseWin.txt"
  CreateShortCut "$SMPROGRAMS\txt2pdf${VER}\Readme.lnk" "$INSTDIR\ReadmeWin.txt"
  CreateShortCut "$SMPROGRAMS\txt2pdf${VER}\txt2pdf.html.lnk" "$INSTDIR\Docs\txt2pdf.html"
  CreateShortCut "$SMPROGRAMS\txt2pdf${VER}\Visual txt2pdf.lnk" "$INSTDIR\Visual_txt2pdf.exe"
SectionEnd

Section "txt2pdf Development Shell Extensions" SecCreateShellExtensions
  SectionIn 1 2
  
  ; back up old value of .txt
  ReadRegStr $1 HKCR ".txt" ""
  StrCmp $1 ""  Label1
    StrCmp $1 "TXTFile"  Label1
    WriteRegStr HKCR ".txt" "backup_val" $1
Label1:

  WriteRegStr HKCR ".txt" "" "TXTFile"
  WriteRegStr HKCR "TXTFile" "" "Text File"
;  WriteRegStr HKCR "TXTFile\shell" "" "open"
;  WriteRegStr HKCR "TXTFile\DefaultIcon" "" $INSTDIR\txt2pdf.exe,0
;  WriteRegStr HKCR "TXTFile\shell\open\command" "" '"$INSTDIR\txt2pdf.exe" -conf "$INSTDIR\txt2pdf.cfg" "%1"'
  WriteRegStr HKCR "TXTFile\shell\compile" "" "Convert to PDF"
  WriteRegStr HKCR "TXTFile\shell\compile\command" "" '"$INSTDIR\txt2pdf.exe" -conf "$INSTDIR\txt2pdf.cfg" "%1"'
SectionEnd

Section "txt2pdf Desktop Icon" SecCreateIcon
  SetOutPath $INSTDIR
  CreateShortCut "$DESKTOP\txt2pdf.lnk" "$INSTDIR\Visual_txt2pdf.exe"
SectionEnd

Section "txt2pdf Download HELP" SecDownHlp
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
NSISdl::download http://www.sanface.com/archive/txt2pdf.chm txt2pdf.chm
Pop $R0 ;Get the return value
  StrCmp $R0 "success" DownloadOK DownloadNO
DownloadOK:
; If the download is OK the program can set the new documentation hlp
  CreateShortCut "$SMPROGRAMS\txt2pdf${VER}\txt2pdf.html.lnk" "$INSTDIR\txt2pdf.chm"
Goto +2
DownloadNO:
  MessageBox MB_OK "txt2pdf Download HELP require an Internet connection."
SectionEnd

;--------------------------------
;Installer Functions

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecCopyTxt2pdf} $(DESC_SecCopyTxt2pdf)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecCreateUninst} $(DESC_SecCreateUninst)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecCreateShortcuts} $(DESC_SecCreateShortcuts)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecCreateShellExtensions} $(DESC_SecCreateShellExtensions)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecCreateIcon} $(DESC_SecCreateIcon)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

; uninstall stuff

UninstallCaption "txt2pdf v. ${VER_POINT} by SANFACE Software"

; special uninstall section.

Section "Uninstall"
  ReadRegStr $1 HKCR ".txt" ""
  StrCmp $1 "TXTFile" 0 NoOwn ; only do this if we own it
    ReadRegStr $1 HKCR ".txt" "backup_val"
    StrCmp $1 "" 0 RestoreBackup ; if backup == "" then delete the whole key
      DeleteRegKey HKCR ".txt"
    Goto NoOwn
    RestoreBackup:
      WriteRegStr HKCR ".txt" "" $1
      DeleteRegValue HKCR ".txt" "backup_val"
  NoOwn:
  ; remove registry keys
  DeleteRegKey HKCR "TXTFile"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\txt2pdf${VER}"
  DeleteRegKey HKLM SOFTWARE\txt2pdf${VER}
  DeleteRegKey HKLM SOFTWARE\Sanface\txt2pdf
  ; remove files
  ; MUST REMOVE UNINSTALLER, too
  Delete $INSTDIR\uninstall-txt2pdf.exe

  ; remove shortcuts, if any.
  Delete $SMPROGRAMS\txt2pdf${VER}\*.lnk
  Delete $DESKTOP\txt2pdf.lnk
  ; remove directories used.
  RMDir $SMPROGRAMS\txt2pdf${VER}
  RMDir /r "$INSTDIR"

SectionEnd
