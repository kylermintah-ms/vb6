Attribute VB_Name = "MCommonDialog"
Option Explicit

Public Enum EErrorCommonDialog
    eeBaseCommonDialog = 13450  ' CommonDialog
End Enum

' Use these definitions because type library equivalents don't work
#If 1 Then
Private Type OPENFILENAME
    lStructSize As Long          ' Filled with UDT size
    hwndOwner As Long            ' Tied to Owner
    hInstance As Long            ' Ignored (used only by templates)
    lpstrFilter As String        ' Tied to Filter
    lpstrCustomFilter As String  ' Ignored (exercise for reader)
    nMaxCustFilter As Long       ' Ignored (exercise for reader)
    nFilterIndex As Long         ' Tied to FilterIndex
    lpstrFile As String          ' Tied to FileName
    nMaxFile As Long             ' Handled internally
    lpstrFileTitle As String     ' Tied to FileTitle
    nMaxFileTitle As Long        ' Handled internally
    lpstrInitialDir As String    ' Tied to InitDir
    lpstrTitle As String         ' Tied to DlgTitle
    Flags As Long                ' Tied to Flags
    nFileOffset As Integer       ' Ignored (exercise for reader)
    nFileExtension As Integer    ' Ignored (exercise for reader)
    lpstrDefExt As String        ' Tied to DefaultExt
    lCustData As Long            ' Ignored (needed for hooks)
    lpfnHook As Long             ' Ignored (good luck with hooks)
    lpTemplateName As String     ' Ignored (good luck with templates)
End Type

Private Declare Function GetOpenFileName Lib "COMDLG32" _
    Alias "GetOpenFileNameA" (file As OPENFILENAME) As Long
Private Declare Function GetSaveFileName Lib "COMDLG32" _
    Alias "GetSaveFileNameA" (file As OPENFILENAME) As Long
Private Declare Function GetFileTitle Lib "COMDLG32" _
    Alias "GetFileTitleA" (ByVal szFile As String, _
    ByVal szTitle As String, ByVal cbBuf As Long) As Long

Public Enum EOpenFile
    OFN_READONLY = &H1
    OFN_OVERWRITEPROMPT = &H2
    OFN_HIDEREADONLY = &H4
    OFN_NOCHANGEDIR = &H8
    OFN_SHOWHELP = &H10
    OFN_ENABLEHOOK = &H20
    OFN_ENABLETEMPLATE = &H40
    OFN_ENABLETEMPLATEHANDLE = &H80
    OFN_NOVALIDATE = &H100
    OFN_ALLOWMULTISELECT = &H200
    OFN_EXTENSIONDIFFERENT = &H400
    OFN_PATHMUSTEXIST = &H800
    OFN_FILEMUSTEXIST = &H1000
    OFN_CREATEPROMPT = &H2000
    OFN_SHAREAWARE = &H4000
    OFN_NOREADONLYRETURN = &H8000
    OFN_NOTESTFILECREATE = &H10000
    OFN_NONETWORKBUTTON = &H20000
    OFN_NOLONGNAMES = &H40000
    OFN_EXPLORER = &H80000
    OFN_NODEREFERENCELINKS = &H100000
    OFN_LONGNAMES = &H200000
End Enum

Private Type TCHOOSECOLOR
    lStructSize As Long
    hwndOwner As Long
    hInstance As Long
    rgbResult As Long
    lpCustColors As Long
    Flags As Long
    lCustData As Long
    lpfnHook As Long
    lpTemplateName As String
End Type

Private Declare Function ChooseColor Lib "COMDLG32.DLL" _
    Alias "ChooseColorA" (Color As TCHOOSECOLOR) As Long

Public Enum EChooseColor
    CC_RGBINIT = &H1
    CC_FULLOPEN = &H2
    CC_PREVENTFULLOPEN = &H4
    CC_COLORSHOWHELP = &H8
    CC_ENABLEHOOK = &H10
    CC_ENABLETEMPLATE = &H20
    CC_ENABLETEMPLATEHANDLE = &H40
    CC_SOLIDCOLOR = &H80
    CC_ANYCOLOR = &H100
End Enum

Private Type TCHOOSEFONT
    lStructSize As Long         ' Filled with UDT size
    hwndOwner As Long           ' Caller's window handle
    hDC As Long                 ' Printer DC/IC or NULL
    lpLogFont As Long           ' Pointer to LOGFONT
    iPointSize As Long          ' 10 * size in points of font
    Flags As Long               ' Type flags
    rgbColors As Long           ' Returned text color
    lCustData As Long           ' Data passed to hook function
    lpfnHook As Long            ' Pointer to hook function
    lpTemplateName As String    ' Custom template name
    hInstance As Long           ' Instance handle for template
    lpszStyle As String         ' Return style field
    nFontType As Integer        ' Font type bits
    iAlign As Integer           ' Filler
    nSizeMin As Long            ' Minimum point size allowed
    nSizeMax As Long            ' Maximum point size allowed
End Type

Private Declare Function ChooseFont Lib "COMDLG32" _
    Alias "ChooseFontA" (chfont As TCHOOSEFONT) As Long

Public Enum EChooseFont
    CF_SCREENFONTS = &H1
    CF_PRINTERFONTS = &H2
    CF_BOTH = &H3
    CF_FONTSHOWHELP = &H4
    CF_ENABLEHOOK = &H8
    CF_ENABLETEMPLATE = &H10
    CF_ENABLETEMPLATEHANDLE = &H20
    CF_INITTOLOGFONTSTRUCT = &H40
    CF_USESTYLE = &H80
    CF_EFFECTS = &H100
    CF_APPLY = &H200
    CF_ANSIONLY = &H400
    CF_NOVECTORFONTS = &H800
    CF_NOOEMFONTS = CF_NOVECTORFONTS
    CF_NOSIMULATIONS = &H1000
    CF_LIMITSIZE = &H2000
    CF_FIXEDPITCHONLY = &H4000
    CF_WYSIWYG = &H8000  ' Must also have ScreenFonts And PrinterFonts
    CF_FORCEFONTEXIST = &H10000
    CF_SCALABLEONLY = &H20000
    CF_TTONLY = &H40000
    CF_NOFACESEL = &H80000
    CF_NOSTYLESEL = &H100000
    CF_NOSIZESEL = &H200000
    CF_SELECTSCRIPT = &H400000
    CF_NOSCRIPTSEL = &H800000
    CF_NOVERTFONTS = &H1000000

End Enum

' These are extra nFontType bits that are added to what is returned to the
' EnumFonts callback routine

Public Enum EFontType
    SIMULATED_FONTTYPE = &H8000
    PRINTER_FONTTYPE = &H4000
    SCREEN_FONTTYPE = &H2000
    BOLD_FONTTYPE = &H100
    ITALIC_FONTTYPE = &H200
    REGULAR_FONTTYPE = &H400
End Enum

Private Type TPRINTDLG
    lStructSize As Long
    hwndOwner As Long
    hDevMode As Long
    hDevNames As Long
    hDC As Long
    Flags As Long
    nFromPage As Integer
    nToPage As Integer
    nMinPage As Integer
    nMaxPage As Integer
    nCopies As Integer
    hInstance As Long
    lCustData As Long
    lpfnPrintHook As Long
    lpfnSetupHook As Long
    lpPrintTemplateName As String
    lpSetupTemplateName As String
    hPrintTemplate As Long
    hSetupTemplate As Long
End Type

Private Declare Function PrintDlg Lib "COMDLG32.DLL" _
    Alias "PrintDlgA" (prtdlg As TPRINTDLG) As Integer

Public Enum EPrintDialog
    PD_ALLPAGES = &H0
    PD_SELECTION = &H1
    PD_PAGENUMS = &H2
    PD_NOSELECTION = &H4
    PD_NOPAGENUMS = &H8
    PD_COLLATE = &H10
    PD_PRINTTOFILE = &H20
    PD_PRINTSETUP = &H40
    PD_NOWARNING = &H80
    PD_RETURNDC = &H100
    PD_RETURNIC = &H200
    PD_RETURNDEFAULT = &H400
    PD_SHOWHELP = &H800
    PD_ENABLEPRINTHOOK = &H1000
    PD_ENABLESETUPHOOK = &H2000
    PD_ENABLEPRINTTEMPLATE = &H4000
    PD_ENABLESETUPTEMPLATE = &H8000
    PD_ENABLEPRINTTEMPLATEHANDLE = &H10000
    PD_ENABLESETUPTEMPLATEHANDLE = &H20000
    PD_USEDEVMODECOPIES = &H40000
    PD_USEDEVMODECOPIESANDCOLLATE = &H40000
    PD_DISABLEPRINTTOFILE = &H80000
    PD_HIDEPRINTTOFILE = &H100000
    PD_NONETWORKBUTTON = &H200000
End Enum

Private Type DEVNAMES
    wDriverOffset As Integer
    wDeviceOffset As Integer
    wOutputOffset As Integer
    wDefault As Integer
End Type

' New Win95 Page Setup dialogs are up to you

Private Type TPAGESETUPDLG
    lStructSize                 As Long
    hwndOwner                   As Long
    hDevMode                    As Long
    hDevNames                   As Long
    Flags                       As Long
    ptPaperSize                 As POINTL
    rtMinMargin                 As RECT
    rtMargin                    As RECT
    hInstance                   As Long
    lCustData                   As Long
    lpfnPageSetupHook           As Long
    lpfnPagePaintHook           As Long
    lpPageSetupTemplateName     As String
    hPageSetupTemplate          As Long
End Type

Private Declare Function PageSetupDlg Lib "COMDLG32" _
    Alias "PageSetupDlgA" (lppage As TPAGESETUPDLG) As Boolean

Public Enum EPageSetup
    PSD_DEFAULTMINMARGINS = &H0 ' Default (printer's)
    PSD_INWININIINTLMEASURE = &H0
    PSD_MINMARGINS = &H1
    PSD_MARGINS = &H2
    PSD_INTHOUSANDTHSOFINCHES = &H4
    PSD_INHUNDREDTHSOFMILLIMETERS = &H8
    PSD_DISABLEMARGINS = &H10
    PSD_DISABLEPRINTER = &H20
    PSD_NOWARNING = &H80
    PSD_DISABLEORIENTATION = &H100
    PSD_RETURNDEFAULT = &H400
    PSD_DISABLEPAPER = &H200
    PSD_SHOWHELP = &H800
    PSD_ENABLEPAGESETUPHOOK = &H2000
    PSD_ENABLEPAGESETUPTEMPLATE = &H8000
    PSD_ENABLEPAGESETUPTEMPLATEHANDLE = &H20000
    PSD_ENABLEPAGEPAINTHOOK = &H40000
    PSD_DISABLEPAGEPAINTING = &H80000
End Enum
#End If

' EPaperSize constants same as vbPRPS constants
Public Enum EPaperSize
    epsLetter = 1          ' Letter, 8 1/2 x 11 in.
    epsLetterSmall         ' Letter Small, 8 1/2 x 11 in.
    epsTabloid             ' Tabloid, 11 x 17 in.
    epsLedger              ' Ledger, 17 x 11 in.
    epsLegal               ' Legal, 8 1/2 x 14 in.
    epsStatement           ' Statement, 5 1/2 x 8 1/2 in.
    epsExecutive           ' Executive, 7 1/2 x 10 1/2 in.
    epsA3                  ' A3, 297 x 420 mm
    epsA4                  ' A4, 210 x 297 mm
    epsA4Small             ' A4 Small, 210 x 297 mm
    epsA5                  ' A5, 148 x 210 mm
    epsB4                  ' B4, 250 x 354 mm
    epsB5                  ' B5, 182 x 257 mm
    epsFolio               ' Folio, 8 1/2 x 13 in.
    epsQuarto              ' Quarto, 215 x 275 mm
    eps10x14               ' 10 x 14 in.
    eps11x17               ' 11 x 17 in.
    epsNote                ' Note, 8 1/2 x 11 in.
    epsEnv9                ' Envelope #9, 3 7/8 x 8 7/8 in.
    epsEnv10               ' Envelope #10, 4 1/8 x 9 1/2 in.
    epsEnv11               ' Envelope #11, 4 1/2 x 10 3/8 in.
    epsEnv12               ' Envelope #12, 4 1/2 x 11 in.
    epsEnv14               ' Envelope #14, 5 x 11 1/2 in.
    epsCSheet              ' C size sheet
    epsDSheet              ' D size sheet
    epsESheet              ' E size sheet
    epsEnvDL               ' Envelope DL, 110 x 220 mm
    epsEnvC3               ' Envelope C3, 324 x 458 mm
    epsEnvC4               ' Envelope C4, 229 x 324 mm
    epsEnvC5               ' Envelope C5, 162 x 229 mm
    epsEnvC6               ' Envelope C6, 114 x 162 mm
    epsEnvC65              ' Envelope C65, 114 x 229 mm
    epsEnvB4               ' Envelope B4, 250 x 353 mm
    epsEnvB5               ' Envelope B5, 176 x 250 mm
    epsEnvB6               ' Envelope B6, 176 x 125 mm
    epsEnvItaly            ' Envelope, 110 x 230 mm
    epsenvmonarch          ' Envelope Monarch, 3 7/8 x 7 1/2 in.
    epsEnvPersonal         ' Envelope, 3 5/8 x 6 1/2 in.
    epsFanfoldUS           ' U.S. Standard Fanfold, 14 7/8 x 11 in.
    epsFanfoldStdGerman    ' German Standard Fanfold, 8 1/2 x 12 in.
    epsFanfoldLglGerman    ' German Legal Fanfold, 8 1/2 x 13 in.
    epsUser = 256          ' User-defined
End Enum

' EPrintQuality constants same as vbPRPQ constants
Public Enum EPrintQuality
    epqDraft = -1
    epqLow = -2
    epqMedium = -3
    epqHigh = -4
End Enum

Public Enum EOrientation
    eoPortrait = 1
    eoLandscape
End Enum

Public Enum EPageSetupUnits
    epsuInches
    epsuMillimeters
End Enum

' Common dialog errors

Private Declare Function CommDlgExtendedError Lib "COMDLG32" () As Long

Public Enum EDialogError
    CDERR_DIALOGFAILURE = &HFFFF

    CDERR_GENERALCODES = &H0
    CDERR_STRUCTSIZE = &H1
    CDERR_INITIALIZATION = &H2
    CDERR_NOTEMPLATE = &H3
    CDERR_NOHINSTANCE = &H4
    CDERR_LOADSTRFAILURE = &H5
    CDERR_FINDRESFAILURE = &H6
    CDERR_LOADRESFAILURE = &H7
    CDERR_LOCKRESFAILURE = &H8
    CDERR_MEMALLOCFAILURE = &H9
    CDERR_MEMLOCKFAILURE = &HA
    CDERR_NOHOOK = &HB
    CDERR_REGISTERMSGFAIL = &HC

    PDERR_PRINTERCODES = &H1000
    PDERR_SETUPFAILURE = &H1001
    PDERR_PARSEFAILURE = &H1002
    PDERR_RETDEFFAILURE = &H1003
    PDERR_LOADDRVFAILURE = &H1004
    PDERR_GETDEVMODEFAIL = &H1005
    PDERR_INITFAILURE = &H1006
    PDERR_NODEVICES = &H1007
    PDERR_NODEFAULTPRN = &H1008
    PDERR_DNDMMISMATCH = &H1009
    PDERR_CREATEICFAILURE = &H100A
    PDERR_PRINTERNOTFOUND = &H100B
    PDERR_DEFAULTDIFFERENT = &H100C

    CFERR_CHOOSEFONTCODES = &H2000
    CFERR_NOFONTS = &H2001
    CFERR_MAXLESSTHANMIN = &H2002

    FNERR_FILENAMECODES = &H3000
    FNERR_SUBCLASSFAILURE = &H3001
    FNERR_INVALIDFILENAME = &H3002
    FNERR_BUFFERTOOSMALL = &H3003

    CCERR_CHOOSECOLORCODES = &H5000
End Enum

' Array of custom colors lasts for life of app
Private alCustom(0 To 15) As Long, fNotFirst As Boolean

Public Enum EPrintRange
    eprAll
    eprPageNumbers
    eprSelection
End Enum

#If fComponent Then
Private Sub Class_Initialize()
    InitColors
End Sub
#End If

Function VBGetOpenFileName(FileName As String, _
                           Optional FileTitle As String, _
                           Optional FileMustExist As Boolean = True, _
                           Optional MultiSelect As Boolean = False, _
                           Optional ReadOnly As Boolean = False, _
                           Optional HideReadOnly As Boolean = False, _
                           Optional filter As String = "All (*.*)| *.*", _
                           Optional FilterIndex As Long = 1, _
                           Optional InitDir As String, _
                           Optional DlgTitle As String, _
                           Optional DefaultExt As String, _
                           Optional Owner As Long = -1, _
                           Optional Flags As Long = 0) As Boolean

    Dim opfile As OPENFILENAME, s As String, afFlags As Long
With opfile
    .lStructSize = Len(opfile)
    
    ' Add in specific flags and strip out non-VB flags
    .Flags = (-FileMustExist * OFN_FILEMUSTEXIST) Or _
             (-MultiSelect * OFN_ALLOWMULTISELECT) Or _
             (-ReadOnly * OFN_READONLY) Or _
             (-HideReadOnly * OFN_HIDEREADONLY) Or _
             (Flags And CLng(Not (OFN_ENABLEHOOK Or _
                                  OFN_ENABLETEMPLATE)))
    ' Owner can take handle of owning window
    If Owner <> -1 Then .hwndOwner = Owner
    ' InitDir can take initial directory string
    .lpstrInitialDir = InitDir
    ' DefaultExt can take default extension
    .lpstrDefExt = DefaultExt
    ' DlgTitle can take dialog box title
    .lpstrTitle = DlgTitle
    
    ' To make Windows-style filter, replace | and : with nulls
    Dim ch As String, i As Long
    For i = 1 To Len(filter)
        ch = Mid$(filter, i, 1)
        If ch = "|" Or ch = ":" Then
            s = s & vbNullChar
        Else
            s = s & ch
        End If
    Next
    ' Put double null at end
    s = s & vbNullChar & vbNullChar
    .lpstrFilter = s
    .nFilterIndex = FilterIndex

    ' Pad file and file title buffers to maximum path
    s = FileName & String$(cMaxPath - Len(FileName), 0)
    .lpstrFile = s
    .nMaxFile = cMaxPath
    s = FileTitle & String$(cMaxFile - Len(FileTitle), 0)
    .lpstrFileTitle = s
    .nMaxFileTitle = cMaxFile
    ' All other fields set to zero
    
    If GetOpenFileName(opfile) Then
        VBGetOpenFileName = True
        FileName = MUtility.StrZToStr(.lpstrFile)
        FileTitle = MUtility.StrZToStr(.lpstrFileTitle)
        Flags = .Flags
        ' Return the filter index
        FilterIndex = .nFilterIndex
        ' Look up the filter the user selected and return that
        filter = FilterLookup(.lpstrFilter, FilterIndex)
        If (.Flags And OFN_READONLY) Then ReadOnly = True
    Else
        VBGetOpenFileName = False
        FileName = sEmpty
        FileTitle = sEmpty
        Flags = 0
        FilterIndex = -1
        filter = sEmpty
    End If
End With
End Function

Function VBGetSaveFileName(FileName As String, _
                           Optional FileTitle As String, _
                           Optional OverWritePrompt As Boolean = True, _
                           Optional filter As String = "All (*.*)| *.*", _
                           Optional FilterIndex As Long = 1, _
                           Optional InitDir As String, _
                           Optional DlgTitle As String, _
                           Optional DefaultExt As String, _
                           Optional Owner As Long = -1, _
                           Optional Flags As Long) As Boolean
            
    Dim opfile As OPENFILENAME, s As String
With opfile
    .lStructSize = Len(opfile)
    
    ' Add in specific flags and strip out non-VB flags
    .Flags = (-OverWritePrompt * OFN_OVERWRITEPROMPT) Or _
             OFN_HIDEREADONLY Or _
             (Flags And CLng(Not (OFN_ENABLEHOOK Or _
                                  OFN_ENABLETEMPLATE)))
    ' Owner can take handle of owning window
    If Owner <> -1 Then .hwndOwner = Owner
    ' InitDir can take initial directory string
    .lpstrInitialDir = InitDir
    ' DefaultExt can take default extension
    .lpstrDefExt = DefaultExt
    ' DlgTitle can take dialog box title
    .lpstrTitle = DlgTitle
    
    ' Make new filter with bars (|) replacing nulls and double null at end
    Dim ch As String, i As Long
    For i = 1 To Len(filter)
        ch = Mid$(filter, i, 1)
        If ch = "|" Or ch = ":" Then
            s = s & vbNullChar
        Else
            s = s & ch
        End If
    Next
    ' Put double null at end
    s = s & vbNullChar & vbNullChar
    .lpstrFilter = s
    .nFilterIndex = FilterIndex

    ' Pad file and file title buffers to maximum path
    s = FileName & String$(cMaxPath - Len(FileName), 0)
    .lpstrFile = s
    .nMaxFile = cMaxPath
    s = FileTitle & String$(cMaxFile - Len(FileTitle), 0)
    .lpstrFileTitle = s
    .nMaxFileTitle = cMaxFile
    ' All other fields zero
    
    If GetSaveFileName(opfile) Then
        VBGetSaveFileName = True
        FileName = MUtility.StrZToStr(.lpstrFile)
        FileTitle = MUtility.StrZToStr(.lpstrFileTitle)
        Flags = .Flags
        ' Return the filter index
        FilterIndex = .nFilterIndex
        ' Look up the filter the user selected and return that
        filter = FilterLookup(.lpstrFilter, FilterIndex)
    Else
        VBGetSaveFileName = False
        FileName = sEmpty
        FileTitle = sEmpty
        Flags = 0
        FilterIndex = 0
        filter = sEmpty
    End If
End With
End Function

Private Function FilterLookup(ByVal sFilters As String, ByVal iCur As Long) As String
    Dim iStart As Long, iEnd As Long, s As String
    iStart = 1
    If sFilters = sEmpty Then Exit Function
    Do
        ' Cut out both parts marked by null character
        iEnd = InStr(iStart, sFilters, vbNullChar)
        If iEnd = 0 Then Exit Function
        iEnd = InStr(iEnd + 1, sFilters, vbNullChar)
        If iEnd Then
            s = Mid$(sFilters, iStart, iEnd - iStart)
        Else
            s = Mid$(sFilters, iStart)
        End If
        iStart = iEnd + 1
        If iCur = 1 Then
            FilterLookup = s
            Exit Function
        End If
        iCur = iCur - 1
    Loop While iCur
End Function

Function VBGetFileTitle(sFile As String) As String
    Dim sFileTitle As String, cFileTitle As Long

    cFileTitle = cMaxPath
    sFileTitle = String$(cMaxPath, 0)
    cFileTitle = GetFileTitle(sFile, sFileTitle, cMaxPath)
    If cFileTitle Then
        VBGetFileTitle = sEmpty
    Else
        VBGetFileTitle = Left$(sFileTitle, InStr(sFileTitle, vbNullChar) - 1)
    End If

End Function

' ChooseColor wrapper
Function VBChooseColor(Color As Long, _
                       Optional AnyColor As Boolean = True, _
                       Optional FullOpen As Boolean = False, _
                       Optional DisableFullOpen As Boolean = False, _
                       Optional Owner As Long = -1, _
                       Optional Flags As Long) As Boolean

    Dim chclr As TCHOOSECOLOR
    chclr.lStructSize = Len(chclr)
    
    ' Color must get reference variable to receive result
    ' Flags can get reference variable or constant with bit flags
    ' Owner can take handle of owning window
    If Owner <> -1 Then chclr.hwndOwner = Owner

    ' Assign color (default uninitialized value of zero is good default)
    chclr.rgbResult = Color

    ' Mask out unwanted bits
    Dim afMask As Long
    afMask = CLng(Not (CC_ENABLEHOOK Or _
                       CC_ENABLETEMPLATE))
    ' Pass in flags
    chclr.Flags = afMask And (CC_RGBINIT Or _
                  IIf(AnyColor, CC_ANYCOLOR, CC_SOLIDCOLOR) Or _
                  (-FullOpen * CC_FULLOPEN) Or _
                  (-DisableFullOpen * CC_PREVENTFULLOPEN))

    ' If first time, initialize to white
    If fNotFirst = False Then InitColors

    chclr.lpCustColors = VarPtr(alCustom(0))
    ' All other fields zero
    
    If ChooseColor(chclr) Then
        VBChooseColor = True
        Color = chclr.rgbResult
    Else
        VBChooseColor = False
        Color = -1
    End If

End Function

Private Sub InitColors()
    Dim i As Long
    ' Initialize with first 16 system interface colors
    For i = 0 To 15
        alCustom(i) = GetSysColor(i)
    Next
    fNotFirst = True
End Sub

' Property to read or modify custom colors (use to save colors in registry)
Public Property Get CustomColor(i As Integer) As Long
    ' If first time, initialize to white
    If fNotFirst = False Then InitColors
    If i >= 0 And i <= 15 Then
        CustomColor = alCustom(i)
    Else
        CustomColor = -1
    End If
End Property

Public Property Let CustomColor(i As Integer, iValue As Long)
    ' If first time, initialize to system colors
    If fNotFirst = False Then InitColors
    If i >= 0 And i <= 15 Then
        alCustom(i) = iValue
    End If
End Property

' ChooseFont wrapper
Function VBChooseFont(CurFont As Font, _
                      Optional PrinterDC As Long = -1, _
                      Optional Owner As Long = -1, _
                      Optional Color As Long = vbBlack, _
                      Optional MinSize As Long = 0, _
                      Optional MaxSize As Long = 0, _
                      Optional Flags As Long = 0) As Boolean

    ' Unwanted Flags bits
    Const CF_FontNotSupported = CF_APPLY Or CF_ENABLEHOOK Or CF_ENABLETEMPLATE
    
    ' Flags can get reference variable or constant with bit flags
    ' PrinterDC can take printer DC
    If PrinterDC = -1 Then
        PrinterDC = 0
        If Flags And CF_PRINTERFONTS Then PrinterDC = Printer.hDC
    Else
        Flags = Flags Or CF_PRINTERFONTS
    End If
    ' Must have some fonts
    If (Flags And CF_PRINTERFONTS) = 0 Then Flags = Flags Or CF_SCREENFONTS
    ' Color can take initial color, receive chosen color
    If Color <> vbBlack Then Flags = Flags Or CF_EFFECTS
    ' MinSize can be minimum size accepted
    If MinSize Then Flags = Flags Or CF_LIMITSIZE
    ' MaxSize can be maximum size accepted
    If MaxSize Then Flags = Flags Or CF_LIMITSIZE

    ' Put in required internal flags and remove unsupported
    Flags = (Flags Or CF_INITTOLOGFONTSTRUCT) And Not CF_FontNotSupported
    
    ' Initialize LOGFONT variable
    Dim fnt As LOGFONT
    Const PointsPerTwip = 1440 / 72
    fnt.lfHeight = -(CurFont.Size * (PointsPerTwip / Screen.TwipsPerPixelY))
    fnt.lfWeight = CurFont.Weight
    fnt.lfItalic = CurFont.Italic
    fnt.lfUnderline = CurFont.Underline
    fnt.lfStrikeOut = CurFont.Strikethrough
    ' Other fields zero
    MBytes.StrToBytes fnt.lfFaceName, CurFont.Name

    ' Initialize TCHOOSEFONT variable
    Dim cf As TCHOOSEFONT
    cf.lStructSize = Len(cf)
    If Owner <> -1 Then cf.hwndOwner = Owner
    cf.hDC = PrinterDC
    cf.lpLogFont = VarPtr(fnt)
    cf.iPointSize = CurFont.Size * 10
    cf.Flags = Flags
    cf.rgbColors = Color
    cf.nSizeMin = MinSize
    cf.nSizeMax = MaxSize
    
    ' All other fields zero
    
    If ChooseFont(cf) Then
        VBChooseFont = True
        Flags = cf.Flags
        Color = cf.rgbColors
        CurFont.Bold = cf.nFontType And BOLD_FONTTYPE
        'CurFont.Italic = cf.nFontType And ITALIC_FONTTYPE
        CurFont.Italic = fnt.lfItalic
        CurFont.Strikethrough = fnt.lfStrikeOut
        CurFont.Underline = fnt.lfUnderline
        CurFont.Weight = fnt.lfWeight
        CurFont.Size = cf.iPointSize / 10
        CurFont.Name = MBytes.BytesToStr(fnt.lfFaceName)
    Else
        VBChooseFont = False
    End If

End Function

' PrintDlg wrapper
Function VBPrintDlg(hDC As Long, _
                    Optional PrintRange As EPrintRange = eprAll, _
                    Optional DisablePageNumbers As Boolean, _
                    Optional FromPage As Long = 1, _
                    Optional ToPage As Long = &HFFFF, _
                    Optional DisableSelection As Boolean, _
                    Optional Copies As Integer, _
                    Optional ShowPrintToFile As Boolean, _
                    Optional DisablePrintToFile As Boolean = True, _
                    Optional PrintToFile As Boolean, _
                    Optional Collate As Boolean, _
                    Optional PreventWarning As Boolean, _
                    Optional Owner As Long, _
                    Optional Printer As Object, _
                    Optional Flags As Long) As Boolean
    Dim afFlags As Long, afMask As Long
    
    ' Set PRINTDLG flags
    afFlags = (-DisablePageNumbers * PD_NOPAGENUMS) Or _
              (-DisablePrintToFile * PD_DISABLEPRINTTOFILE) Or _
              (-DisableSelection * PD_NOSELECTION) Or _
              (-PrintToFile * PD_PRINTTOFILE) Or _
              (-(Not ShowPrintToFile) * PD_HIDEPRINTTOFILE) Or _
              (-PreventWarning * PD_NOWARNING) Or _
              (-Collate * PD_COLLATE) Or _
              PD_USEDEVMODECOPIESANDCOLLATE Or _
              PD_RETURNDC
    If PrintRange = eprPageNumbers Then
        afFlags = afFlags Or PD_PAGENUMS
    ElseIf PrintRange = eprSelection Then
        afFlags = afFlags Or PD_SELECTION
    End If
    ' Mask out unwanted bits
    afMask = CLng(Not (PD_ENABLEPRINTHOOK Or _
                       PD_ENABLEPRINTTEMPLATE))
    afMask = afMask And _
             CLng(Not (PD_ENABLESETUPHOOK Or _
                       PD_ENABLESETUPTEMPLATE))
    
    ' Fill in PRINTDLG structure
    Dim pd As TPRINTDLG
    pd.lStructSize = Len(pd)
    pd.hwndOwner = Owner
    pd.Flags = afFlags And afMask
    pd.nFromPage = FromPage
    pd.nToPage = ToPage
    pd.nMinPage = 1
    pd.nMaxPage = &HFFFF
    
    ' Show Print dialog
    If PrintDlg(pd) Then
        VBPrintDlg = True
        ' Return dialog values in parameters
        hDC = pd.hDC
        If (pd.Flags And PD_PAGENUMS) Then
            PrintRange = eprPageNumbers
        ElseIf (pd.Flags And PD_SELECTION) Then
            PrintRange = eprSelection
        Else
            PrintRange = eprAll
        End If
        FromPage = pd.nFromPage
        ToPage = pd.nToPage
        PrintToFile = (pd.Flags And PD_PRINTTOFILE)
        ' Get DEVMODE structure from PRINTDLG
        Dim dvmode As DEVMODE, pDevMode As Long
        pDevMode = GlobalLock(pd.hDevMode)
        CopyMemory dvmode, ByVal pDevMode, Len(dvmode)
        Call GlobalUnlock(pd.hDevMode)
        ' Get Copies and Collate settings from DEVMODE structure
        Copies = dvmode.dmCopies
        Collate = (dvmode.dmCollate = APITRUE)
        ' Set default printer properties
        On Error Resume Next
        Printer.Copies = Copies
        Printer.Orientation = dvmode.dmOrientation
        Printer.PaperSize = dvmode.dmPaperSize
        Printer.PrintQuality = dvmode.dmPrintQuality
    Else
        VBPrintDlg = False
    End If
    
End Function

' PageSetupDlg wrapper
Function VBPageSetupDlg(Optional Owner As Long, _
                        Optional DisableMargins As Boolean, _
                        Optional DisableOrientation As Boolean, _
                        Optional DisablePaper As Boolean, _
                        Optional DisablePrinter As Boolean, _
                        Optional LeftMargin As Long, _
                        Optional MinLeftMargin As Long, _
                        Optional RightMargin As Long, _
                        Optional MinRightMargin As Long, _
                        Optional TopMargin As Long, _
                        Optional MinTopMargin As Long, _
                        Optional BottomMargin As Long, _
                        Optional MinBottomMargin As Long, _
                        Optional PaperSize As EPaperSize = epsLetter, _
                        Optional Orientation As EOrientation = eoPortrait, _
                        Optional PrintQuality As EPrintQuality = epqDraft, _
                        Optional Units As EPageSetupUnits = epsuInches, _
                        Optional Printer As Object, _
                        Optional Flags As Long) As Boolean
    Dim afFlags As Long, afMask As Long
    ' Mask out unwanted bits
    afMask = Not (PSD_ENABLEPAGEPAINTHOOK Or _
                  PSD_ENABLEPAGESETUPHOOK Or _
                  PSD_ENABLEPAGESETUPTEMPLATE)
    ' Set TPAGESETUPDLG flags
    afFlags = (-DisableMargins * PSD_DISABLEMARGINS) Or _
              (-DisableOrientation * PSD_DISABLEORIENTATION) Or _
              (-DisablePaper * PSD_DISABLEPAPER) Or _
              (-DisablePrinter * PSD_DISABLEPRINTER) Or _
              PSD_MARGINS Or PSD_MINMARGINS And afMask
    Dim lUnits As Long
    If Units = epsuInches Then
        afFlags = afFlags Or PSD_INTHOUSANDTHSOFINCHES
        lUnits = 1000
    Else
        afFlags = afFlags Or PSD_INHUNDREDTHSOFMILLIMETERS
        lUnits = 100
    End If
    
    Dim psd As TPAGESETUPDLG
    ' Fill in PRINTDLG structure
    psd.lStructSize = Len(psd)
    psd.hwndOwner = Owner
    psd.rtMargin.Top = TopMargin * lUnits
    psd.rtMargin.Left = LeftMargin * lUnits
    psd.rtMargin.bottom = BottomMargin * lUnits
    psd.rtMargin.Right = RightMargin * lUnits
    psd.rtMinMargin.Top = MinTopMargin * lUnits
    psd.rtMinMargin.Left = MinLeftMargin * lUnits
    psd.rtMinMargin.bottom = MinBottomMargin * lUnits
    psd.rtMinMargin.Right = MinRightMargin * lUnits
    psd.Flags = afFlags
    
    ' Show Print dialog
    If PageSetupDlg(psd) Then
        VBPageSetupDlg = True
        ' Return dialog values in parameters
        TopMargin = psd.rtMargin.Top / lUnits
        LeftMargin = psd.rtMargin.Left / lUnits
        BottomMargin = psd.rtMargin.bottom / lUnits
        RightMargin = psd.rtMargin.Right / lUnits
        MinTopMargin = psd.rtMinMargin.Top / lUnits
        MinLeftMargin = psd.rtMinMargin.Left / lUnits
        MinBottomMargin = psd.rtMinMargin.bottom / lUnits
        MinRightMargin = psd.rtMinMargin.Right / lUnits
        
        ' Get DEVMODE structure from PRINTDLG
        Dim dvmode As DEVMODE, pDevMode As Long
        pDevMode = GlobalLock(psd.hDevMode)
        CopyMemory dvmode, ByVal pDevMode, Len(dvmode)
        Call GlobalUnlock(psd.hDevMode)
        PaperSize = dvmode.dmPaperSize
        Orientation = dvmode.dmOrientation
        PrintQuality = dvmode.dmPrintQuality
        ' Set default printer properties
        On Error Resume Next
        Printer.Copies = dvmode.dmCopies
        Printer.Orientation = dvmode.dmOrientation
        Printer.PaperSize = dvmode.dmPaperSize
        Printer.PrintQuality = dvmode.dmPrintQuality
    End If

End Function

#If fComponent = 0 Then
Private Sub ErrRaise(e As Long)
    Dim sText As String, sSource As String
    If e > 1000 Then
        sSource = App.ExeName & ".CommonDialog"
        Select Case e
        Case eeBaseCommonDialog
            BugAssert True
       ' Case ee...
       '     Add additional errors
        End Select
        Err.Raise COMError(e), sSource, sText
    Else
        ' Raise standard Visual Basic error
        sSource = App.ExeName & ".VBError"
        Err.Raise e, sSource
    End If
End Sub
#End If

