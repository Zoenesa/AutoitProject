#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=IconRes.ico
#AutoIt3Wrapper_Outfile=MainScript V.17.3.5.1.exe
#AutoIt3Wrapper_Outfile_x64=MainScript V.17.3.5.1_X64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_Comment=Elvenar AutoClick
#AutoIt3Wrapper_Res_Description=Elvenar AutoClicker Update Fix Config & Delay
#AutoIt3Wrapper_Res_Fileversion=17.3.5.1
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#AutoIt3Wrapper_Res_LegalCopyright=AgungJawata™
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;~ #include "ImageSearch.au3"
#include "modul\fileglobal.au3"
#include <File.au3>
#include <Date.au3>

Opt( "MouseClickDelay", 10)

Func _ImageSearch($RefImage, $resultPosition, ByRef $CordX, ByRef $CordY, $tolerance, $HBMP=0)
   return _ImageSearchArea($RefImage, $resultPosition, 0, 0, @DesktopWidth, @DesktopHeight, $CordX, $CordY, $tolerance, $HBMP)
EndFunc

Func _ImageSearchArea($RefImage, $resultPosition, $CordX1, $CordY1, $right, $bottom, ByRef $CordX, ByRef $CordY, $tolerance, $HBMP = 0)
    If $tolerance > 0 Then $RefImage = "*" & $tolerance & " " & $RefImage
    If IsString($RefImage) Then
        $result = DllCall("ImageSearchDLL.dll", "str", "ImageSearch", "int", $CordX1, "int", $CordY1, "int", $right, "int", $bottom, "str", $RefImage, "ptr", $HBMP)
		$err = @error
    Else
        $result = DllCall("ImageSearchDLL.dll", "str", "ImageSearch", "int", $CordX1, "int", $CordY1, "int", $right, "int", $bottom, "ptr", $RefImage, "ptr", $HBMP)
        $err = @error
    EndIf
    Switch $err
        Case 1
            ConsoleWriteError("unable to use the DLL file" & @CRLF)
            exit 1
        Case 2
            ConsoleWriteError('unknown "return type" ' & @CRLF)
            exit 1
        Case 3
            ConsoleWriteError('"ImageSearch" not found in DLL' & @CRLF)
            exit 1
        Case 4
            ConsoleWriteError('bad number of parameters' & @CRLF)
            exit 1
        Case 5
            ConsoleWriteError('bad parameter' & @CRLF)
            exit 1
    EndSwitch
    If $result[0] = "0" Then Return 0
	$array = StringSplit($result[0], "|")
	$tempArray = _ArrayToString( $array, "|")
;~ 	PesanKonsol("Image Array Result: ", $tempArray)
    $CordX = Int(Number($array[2]))
    $CordY = Int(Number($array[3]))
	If $resultPosition = 1 Then
		$CordX = $CordX + Int(Number($array[4]) / 2)
        $CordY = $CordY + Int(Number($array[5]) / 2)
    EndIf
    Return 1
EndFunc


#Region Deklarasi
Global $Paused

Local Static $LimitFindResource
Local Static $LimitFindGold
Local Static $LimitFindMetal
Local Static $LimitFindPlank
Local Static $LimitFindMarble
Local Static $LimitFindCrystal
Local Static $LimitFindScroll
Local Static $LimitFindSilk
Local Static $OnlySearchResource
Local Static $boolSearchArea
Local Static $SearchAreaTop
Local Static $SearchAreaLeft
Local Static $SearchAreaRight
Local Static $SearchAreaBottom

Local Static $GetJobResource
Local Static $GetJobMetal
Local Static $GetJobCrystal
Local Static $GetJobPlank
Local Static $GetJobMarble
Local Static $GetJobScroll
Local Static $GetJobSilk

;Set Posisi Window
Local Static $StartPointerPosition
Local Static $DelaySearchImage
Local Static $DelayPickRes
Local Static $DelayPickJob
Local Static $DelayGetJob
Local Static $StartPosX
Local Static $StartPosY
Local Static $EndPosX
Local Static $EndPosY

;Maks Stack Objek
Local Static $ResidenceStack
Local Static $ResourceStack
Local Static $MetalStack
Local Static $PlankStack
Local Static $MarbleStack
Local Static $CrystalStack
Local Static $ScrollStack
Local Static $SilkStack
Local Static $ReadServer
Local Static $multiServer
Local Static $MetalFound = 0

;Ref Kordinat
Local $xRes = 0, $yRes = 0, $xJob = 0, $yJob = 0, $xPosReset = 0, $yPosReset = 0
Local $xGold = 0, $yGold = 0, $xServer = 0, $yServer = 0
Local $CountJob = 0, $GoldFailClickX = 0, $GoldFailClickY = 0

Global $TotalPickResources = 0
Global $TotalPickGolds = 0
Global $TotalPickMetals = 0
Global $TotalPickPlanks = 0
Global $TotalPickMarbles = 0
Global $TotalPickCrystals = 0
Global $TotalPickScrolls = 0
Global $TotalPickSilks = 0

Global $UPosXRes
Global $UPosYRes
Global $UPosXGold
Global $UPosYGold
Global $UPosXMetal
Global $UPosYMetal
Global $UPosXPlank
Global $UPosYPlank
Global $UPosXMarble
Global $UPosYMarble
Global $UPosXCrystal
Global $UPosYCrystal
Global $UPosXScroll
Global $UPosYScroll
Global $UPosXSilk
Global $UPosYSilk

Global $tSetTitle

#EndRegion

#Region Hotkey
	HotKeySet("^+p", "TogglePause")
	HotKeySet("^+q", "CommandExit")
	HotKeySet("^+{HOME}", "CenteringScreen")
	HotKeySet("{HOME}", "CommandSetPosisiKota")
	HotKeySet( "^+k", "CommandStartServer")
	HotKeySet("^+r", "CommandRestart")
	HotKeySet("^{NUMPAD0}","CommandCariResource")
	HotKeySet("^{NUMPAD1}","CommandCariGold")
	HotKeySet("^{NUMPAD2}","CommandCariMetal")
	HotKeySet("^{NUMPAD3}","CommandCariCrystal")
	HotKeySet("^{NUMPAD4}","CommandCariPlank")
	HotKeySet("^{NUMPAD5}","CommandCariMarble")
	HotKeySet("^{NUMPAD6}","CommandCariScroll")
	HotKeySet("^{NUMPAD7}","CommandCariSilk")
	HotKeySet("^+g","ReadSettingan")
	HotKeySet("^{NUMPAD9}","CommandWriteLog")
	HotKeySet("{F7}","FindSponsorWnd")
#EndRegion

DllCall( "Kernel32.dll", "bool", "AllocConsole")
If FileExists(@ScriptDir & "\log\Elvenar.log") Then
	$hFileOpen = FileOpen(@ScriptDir & "\log\Elvenar.log", 0)
	$hFileRead = FileReadToArray($hFileOpen)
	;" [R:" & $tres & "; G:" & $tGold & "; Mt:" & $tMetal & "; P:" & $tPlank & "; Ma:" & $tMarb & "; Cr:" & $tCry & "; Sc:" & $tSco & "; Sl:" & $tSlk & "]"
	$TotalPickResources = Int($hFileRead[1])
	$TotalPickGolds = Int($hFileRead[2])
	$TotalPickMetals = Int($hFileRead[3])
	$TotalPickPlanks = Int($hFileRead[4])
	$TotalPickMarbles = Int($hFileRead[5])
	$TotalPickCrystals = Int($hFileRead[6])
	$TotalPickScrolls = Int($hFileRead[7])
	$TotalPickSilks = Int($hFileRead[8])
	$tempTitle = "Elvenar AutoClick Log [R:" & $TotalPickResources & "; G:" & $TotalPickGolds & "; Mt:" & $TotalPickMetals & "; P:" & $TotalPickPlanks & "; Ma:" & $TotalPickMarbles & "; Cr:" & $TotalPickCrystals & "; Sc:" & $TotalPickScrolls & "; Sl:" & $TotalPickSilks & "]"
	_WinApi_SetConsoleTitle($tempTitle)
	FileClose($hFileOpen)
Else
_WinApi_SetConsoleTitle("Elvenar AutoClick Log") ; & " [R:0; G:0; Mt:0; P:0; Ma:0; Cr:0; Sc:0; Sl:0]")
EndIf
WinSetOnTop( "Elvenar AutoClick Log", "", 1)
WinSetTrans( "Elvenar AutoClick Log", "", 200)
WinMove( "Elvenar AutoClick Log", "", 541, 0, 797, 105, 3)
DllClose("Kernel32.dll")

ReadSettingan()

Sleep(500)
WinActivate("Elvenar - Fantasy City Builder Game")

Sleep(30000)
FindSponsorWnd()

Func ReadSettingan()
	Global $hFileSetting = @ScriptDir & "\config\Config.ini"
	#Region Read Setup Job
	Sleep(500)
	PesanKonsol("Read Settingan", "Section [SetupJob]")

	$GetJobResource = IniRead($hFileSetting, "SetupJob", "Resource", 1)
	Sleep(10)
	PesanKonsol("Read Settingan $GetJobResource", "Key: Resource; Value: " & $GetJobResource)
	;------------------1
	$GetJobMetal = IniRead($hFileSetting, "SetupJob", "Metal", 1)
	Sleep(10)
	PesanKonsol("Read Settingan $GetJobResource", "Key: Metal; Value: " & $GetJobMetal)
	;------------------2
	$GetJobCrystal = IniRead( $hFileSetting, "SetupJob", "Crystal", 1)
	Sleep(10)
	PesanKonsol("Read Settingan $GetJobCrystal", "Key: Crystal; Value: " & $GetJobCrystal)
	;------------------3
	$GetJobPlank = IniRead( $hFileSetting, "SetupJob", "Plank", 1)
	Sleep(10)
	PesanKonsol("Read Settingan $GetJobPlank", "Key: Plank; Value: " & $GetJobPlank)
	;------------------4
	$GetJobMarble = IniRead( $hFileSetting, "SetupJob", "Marble", 1)
	Sleep(10)
	PesanKonsol("Read Settingan $GetJobMarble", "Key: Marble; Value: " & $GetJobMarble)
	;------------------5
	$GetJobScroll = Iniread( $hFileSetting, "SetupJob", "Scroll", 1)
	Sleep(10)
	PesanKonsol("Read Settingan $GetJobScroll", "Key: Scroll; Value: " & $GetJobScroll)
	;------------------6
	$GetJobSilk = IniRead( $hFileSetting, "SetupJob", "Silk", 1)
	Sleep(10)
	PesanKonsol("Read Settingan $GetJobSilk", "Key: Silk; Value: " & $GetJobSilk)
	#EndRegion

	#Region Total Building
	Sleep(500)
	PesanKonsol( "Read Setingan", "Section [TotalBuilding]")
	;------------------1
	$ResidenceStack = IniRead($hFileSetting, "TotalBuilding", "Residence", 19)
	Sleep(10)
	PesanKonsol("Read Settingan $ResidenceStack", "Key: Residence; Value: " & $ResidenceStack)
	;------------------2
	$ResourceStack = IniRead($hFileSetting, "TotalBuilding", "WorkShop", 6)
	Sleep(10)
	PesanKonsol("Read Settingan $ResourceStack", "Key: WorkShop; Value: " & $ResourceStack)
	;------------------3
	$MetalStack = IniRead($hFileSetting, "TotalBuilding", "Steel", 5)
	Sleep(10)
	PesanKonsol("Read Settingan $MetalStack", "Key: Steel; Value: " & $MetalStack)
	;------------------4
	$CrystalStack = IniRead($hFileSetting, "TotalBuilding", "Crystal", 2)
	Sleep(10)
	PesanKonsol("Read Settingan $CrystalStack", "Key: Crystal; Value: " & $CrystalStack)
	;------------------5
	$PlankStack = IniRead($hFileSetting, "TotalBuilding", "Plank", 4)
	Sleep(10)
	PesanKonsol("Read Settingan $PlankStack", "Key: Plank; Value: " & $PlankStack)
	;------------------9
	$MarbleStack = IniRead($hFileSetting, "TotalBuilding", "Marble", 5)
	Sleep(10)
	PesanKonsol("Read Settingan $MarbleStack", "Key: Marble; Value: " & $MarbleStack)
	;------------------7
	$ScrollStack = IniRead($hFileSetting, "TotalBuilding", "Scrolls", 1)
	Sleep(10)
	PesanKonsol("Read Settingan $ScrollStack", "Key: Scrolls; Value: " & $ScrollStack)
	;------------------8
	$SilkStack = IniRead($hFileSetting, "TotalBuilding", "Silk", 1)
	Sleep(10)
	PesanKonsol("Read Settingan $SilkStack", "Key: Silk; Value: " & $SilkStack)
	#EndRegion

	#Region Delay Timing
	Sleep(500)
	PesanKonsol("Read Settingan", "Section [DelayTiming]")
	;------------------1
	$DelaySearchImage = IniRead($hFileSetting, "DelayTiming", "SearchImage", 100)
	Sleep(10)
	PesanKonsol("Read Settingan $DelaySearchImage", "Key: SearchImage; Value: " & $DelaySearchImage)
	;------------------2
	$DelayPickRes = IniRead($hFileSetting, "DelayTiming","Resource", 100)
	Sleep(10)
	PesanKonsol("Read Settingan $DelayPickRes", "Key: Resource; Value: " & $DelayPickRes)
	;------------------3
	$DelayPickJob = IniRead($hFileSetting, "DelayTiming", "PickJob", 80)
	Sleep(10)
	PesanKonsol("Read Settingan $DelayPickJob", "Key: PickJob; Value: " & $DelayPickJob)
	;------------------4
	$DelayGetJob = IniRead($hFileSetting, "DelayTiming", "GetJob", 100)
	Sleep(10)
	PesanKonsol("Read Settingan $DelayGetJob", "Key: GetJob; Value: " & $DelayGetJob)
	#EndRegion

	#Region SettingAplikasi
	Sleep(100)
	PesanKonsol("Read Settingan", "Section [SettingAplikasi]")
	;------------------1
	$multiServer = IniRead($hFileSetting, "SettingAplikasi", "multiserver", 0)
	Sleep(10)
	PesanKonsol("Read Settingan $multiServer", "Section: SettingAplikasi " & "; Key: multiserver; Value: " & $multiServer)
	;------------------2
	$ReadServer = IniRead($hFileSetting, "SettingAplikasi", "Server1", "Arendyll")
	Sleep(10)
	PesanKonsol("Read Settingan $ReadServer", "Section: SettingAplikasi " & "; Key: Server1; Value: " & $ReadServer)
	;------------------3
	$LimitFindResource = IniRead($hFileSetting, "SettingAplikasi", "LimitFindResource", 100)
	Sleep(10)
	PesanKonsol("Read Settingan $LimitFindResource", "Key: LimitFindResource; Value: " & $LimitFindResource)
	;------------------4
	$LimitFindGold = IniRead($hFileSetting, "SettingAplikasi", "LimitFindGold", 90)
	Sleep(10)
	PesanKonsol("Read Settingan $LimitFindGold", "Key: LimitFindGold; Value: " & $LimitFindGold)
	;------------------5
	$LimitFindMetal = IniRead($hFileSetting, "SettingAplikasi", "LimitFindMetal", 100)
	Sleep(10)
	PesanKonsol("Read Settingan $LimitFindMetal", "Key: $LimitFindMetal; Value: " & $LimitFindMetal)
	;------------------6
	$LimitFindPlank = IniRead($hFileSetting, "SettingAplikasi", "LimitFindPlank", 100)
	Sleep(10)
	PesanKonsol("Read Settingan $LimitFindPlank", "Key: $LimitFindPlank; Value: " & $LimitFindPlank)
	;------------------7
	$LimitFindMarble = IniRead($hFileSetting, "SettingAplikasi", "LimitFindMarble", 100)
	Sleep(10)
	PesanKonsol("Read Settingan $LimitFindMarble", "Key: LimitFindMarble; Value: " & $LimitFindMarble)
	;------------------8
	$LimitFindCrystal = IniRead($hFileSetting, "SettingAplikasi", "LimitFindCrystal", 100)
	Sleep(10)
	PesanKonsol("Read Settingan $LimitFindCrystal", "Key: LimitFindCrystal; Value: " & $LimitFindCrystal)
	;------------------9
	$LimitFindScroll = IniRead($hFileSetting, "SettingAplikasi", "LimitFindScroll", 100)
	Sleep(10)
	PesanKonsol("Read Settingan $LimitFindScroll", "Key: LimitFindScroll; Value: " & $LimitFindScroll)
	;------------------10
	$LimitFindSilk = IniRead($hFileSetting, "SettingAplikasi", "LimitFindSilk", 100)
	Sleep(10)
	PesanKonsol("Read Settingan $LimitFindSilk", "Key: LimitFindSilk; Value: " & $LimitFindSilk)
	;------------------11
	$OnlySearchResource = IniRead($hFileSetting, "SettingAplikasi", "OnlyResource", 1)
	Sleep(10)
	PesanKonsol("Read Settingan $OnlySearchResource", "Key: OnlyResource; Value: " & $OnlySearchResource)
	;------------------12
	$boolSearchArea = IniRead($hFileSetting, "SettingAplikasi", "SearchArea", 1)
	Sleep(10)
	PesanKonsol("Read Settingan $boolSearchArea", "Key: SearchArea; Value: " & $boolSearchArea)
	;------------------13
	$SearchAreaTop = IniRead($hFileSetting, "SettingAplikasi", "TopX", 176)
	Sleep(10)
	PesanKonsol("Read Settingan $SearchAreaTop", "Key: TopX; Value: " & $SearchAreaTop)
	;------------------14
	$SearchAreaLeft = IniRead($hFileSetting, "SettingAplikasi", "TopY", 206)
	Sleep(10)
	PesanKonsol("Read Settingan $SearchAreaLeft", "Key: TopY; Value: " & $SearchAreaLeft)
	;------------------15
	$SearchAreaRight = IniRead($hFileSetting, "SettingAplikasi", "wRight", 1298)
	Sleep(10)
	PesanKonsol("Read Settingan $SearchAreaRight", "Key: wRight; Value: " & $SearchAreaRight)
	;------------------16
	$SearchAreaBottom = IniRead($hFileSetting, "SettingAplikasi", "hBottom", 730)
	Sleep(10)
	PesanKonsol("Read Settingan $SearchAreaBottom", "Key: hBottom; Value: " & $SearchAreaBottom)
	;------------------17
	$StartPointerPosition = IniRead($hFileSetting, "SettingAplikasi", "PointerWin", 0)
	Sleep(10)
	PesanKonsol("Read Settingan $StartPointerPosition", "Key: PointerWin; Value: " & $StartPointerPosition)
	#EndRegion

	#Region CoordinateUserPick
	Sleep(100)
	PesanKonsol("Read Settingan", "Section CoordinateUserPick")
	;------------------1
	$UPosXRes = IniRead($hFileSetting, "CoordinateUserPick", "PickXResource", 8)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosXRes", "Key: PickXResource; Value: " & $UPosXRes)
	;------------------2
	$UPosYRes = IniRead($hFileSetting, "CoordinateUserPick", "PickYResource", 65)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosYRes", "Key: GetJob; PickYResource: " & $UPosYRes)
	;------------------3
	$UPosXGold = IniRead($hFileSetting, "CoordinateUserPick", "PickXGold", 10)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosXGold", "Key: PickXGold; Value: " & $UPosXGold)
	;------------------4
	$UPosYGold = IniRead($hFileSetting, "CoordinateUserPick", "PickYGold", 70)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosYGold", "Key: PickYGold; Value: " & $UPosYGold)
	;------------------5
	$UPosXMetal = IniRead($hFileSetting, "CoordinateUserPick", "PickXMetal", 6)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosXMetal", "Key: PickXMetal; Value: " & $UPosXMetal)
	;------------------6
	$UPosYMetal = IniRead($hFileSetting, "CoordinateUserPick", "PickYMetal", 75)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosYMetal", "Key: PickYMetal; Value: " & $UPosYMetal)
	;------------------7
	$UPosXPlank = IniRead($hFileSetting, "CoordinateUserPick", "PickXPlank", 10)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosXPlank", "Key: PickXPlank; Value: " & $UPosXPlank)
	;------------------8
	$UPosYPlank = IniRead($hFileSetting, "CoordinateUserPick", "PickYPlank", 70)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosYPlank", "Key: PickYPlank; Value: " & $UPosYPlank)
	;------------------9
	$UPosXMarble = IniRead($hFileSetting, "CoordinateUserPick", "PickXMarble", 4)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosXMarble", "Key: PickXMarble; Value: " & $UPosXMarble)
	;------------------10
	$UPosYMarble = IniRead($hFileSetting, "CoordinateUserPick", "PickYMarble", 70)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosYMarble", "Key: PickYMarble; Value: " & $UPosYMarble)
	;------------------11
	$UPosXCrystal = IniRead($hFileSetting, "CoordinateUserPick", "PickXCrystal", 5)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosXCrystal", "Key: PickXCrystal; Value: " & $UPosXCrystal)
	;------------------12
	$UPosYCrystal = IniRead($hFileSetting, "CoordinateUserPick", "PickYCrystal", 75)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosYCrystal", "Key: PickYCrystal; Value: " & $UPosYCrystal)
	;------------------13
	$UPosXScroll = IniRead($hFileSetting, "CoordinateUserPick", "PickXScroll", 0)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosXScroll", "Key: ; Value: " & $UPosXScroll)
	;------------------14
	$UPosYScroll = IniRead($hFileSetting, "CoordinateUserPick", "PickYScroll", 60)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosYScroll", "Key: PickYScroll; Value: " & $UPosYScroll)
	;------------------15
	$UPosXSilk = IniRead( $hFileSetting, "CoordinateUserPick", "PickXSilk", 5)
	Sleep(10)
	PesanKonsol("Read Settingan ", "Key: PickXSilk; Value: " & $UPosXSilk)
	;------------------16
	$UPosYSilk = IniRead( $hFileSetting, "CoordinateUserPick", "PickYSilk", 70)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosYSilk", "Key: PickYSilk; Value: " & $UPosYSilk)
	;------------------17

	$StartPosX = IniRead($hFileSetting, "GetCenterArea", "StartPosX", 650)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosYSilk", "Key: StartPosX; Value: " & $StartPosX)
	;------------------18
	$StartPosY = IniRead($hFileSetting, "GetCenterArea", "StartPosY", 523)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosYSilk", "Key: StartPosY; Value: " & $StartPosY)
	;------------------19
	$EndPosX = IniRead($hFileSetting, "GetCenterArea", "EndPosX", 617)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosYSilk", "Key: EndPosX; Value: " & $EndPosX)
	;------------------20
	$EndPosY = IniRead($hFileSetting, "GetCenterArea", "EndPosY", 219)
	Sleep(10)
	PesanKonsol("Read Settingan $UPosYSilk", "Key: EndPosY; Value: " & $EndPosY)
	;------------------21
	#EndRegion
	Return 1
EndFunc

Func WriteSetingan()

EndFunc

If $StartPointerPosition = 1 Then
	CommandSetPosisiKota()
;~ 	CenteringScreen()
EndIf

Func CenteringScreen()
	Sleep(Random(2000,2600))
	MouseMove( Int(Number($StartPosX)), Int(Number($StartPosY)), 3) ;1237, 602
	Sleep(Random(500, 800))
	MouseDown( "left")
	MouseMove( Int(Number($EndPosX)), Int(Number($EndPosY)), 20);1154, 265
	Sleep(100)
	MouseUp( "left")
	CommandCariResource()
EndFunc

Func CommandCariResource()
;~ 	ReadSettingan()
	#Region Deklarasi Sub
	$iResc = 0
	$CountSearchResc = 0
	$CariResource = 0
	$xJob = 0
	$yJob = 0
	$CountJob = 0
	;Total Limit Searching Resource dari File Config
	$LimitFindResource = IniRead($hFileSetting, "SettingAplikasi", "LimitFindResource", 100)
	$OnlySearchResource = IniRead($hFileSetting, "SettingAplikasi", "OnlyResource", 1)
	$GetJobResource = IniRead( $hFileSetting, "SetupJob", "Resource", 1)
	#EndRegion
	#Region Loop Pencarian Image
	Do
		$CariResource = _ImageSearchArea( $ArrayImgResc[$iResc], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xRes, $yRes, 90)
		$iResc += 1
		If $iResc = 4 Then $iResc = 0
		$CountSearchResc += 1
		Sleep(Int(Number($DelaySearchImage)))
		PesanKonsol("Searching Resource, Limit: " & $LimitFindResource & ", Delay: " & $DelaySearchImage, "Count: " & $CountSearchResc & " Using Image: " & $iResc)
		If $CountSearchResc = Int($LimitFindResource) Then
			If $OnlySearchResource = 1 Then
				$CountSearchResc = 0
				ExitLoop
				CommandCariGold()
			EndIf
			PesanKonsol("Maksimum Stack Reach", "Switch Searching Resource to Gold")
			;Pass Jika Tidak ada Window Refresh dari Server Lanjut Eksekusi Cari Gold
			CommandCariGold()
		EndIf
		;Coba Reset Web While Counting Limit

		$ResetRefresh = _ImageSearch( @ScriptDir & "\img\03Main\SessionOk.bmp", 1, $xPosReset, $yPosReset, 60)
		If $ResetRefresh = 1 Then
			PesanKonsol("Searching End or Error Session")
			Sleep(500)
			PesanKonsol("Executing To Home")
			MouseClick( "left", $xPosReset, $yPosReset, 10)
			Sleep(Random(120000, 200000))
			CommandSetPosisiKota()
		Endif
	Until $CariResource = 1
	#EndRegion
	Sleep(200)
; 	Jika Resource Ditemukan Lanjutkan Pencarian Job
	If $CariResource = 1 Then
;		Tentukan Pencarian Berdasarkan User Config
		Sleep(100)
		PesanKonsol("Resource Found!", "Using Image: " & $iResc & "; PosX: " & $xRes & " PosY: " & $yRes)
;~ 		Sleep(Int(Number($DelayGetJob)))
		Sleep(500)
		MouseClick( "left", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 10)
		$TotalPickResources += 1
		MouseMove(105, 403, 3)
		PesanKonsol("Collecting Resource", "PosX: " & $xRes & " PosY: " & $yRes & " Total Resources Collected: " & $TotalPickResources)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		$PickJobResource = 0
		Switch $GetJobResource
			Case 1 ; 5min
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Beverage)")
				Do
					$PickJobResource  = _ImageSearch( $imgsrc5, 1, $xJob, $yJob, 60)
					Sleep(Int(Number($DelayPickJob)))
;~ 					Sleep(100)
					$CountJob += 1
					If $CountJob = 6 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "left", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 8)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $PickJobResource  = 1
			Case 2 ; 15min
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Simple Tools)")
				Do
					$PickJobResource  = _ImageSearch( $imgsrc6, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 6 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "left", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $PickJobResource  = 1
			Case 3 ; 1hr
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Bread)")
				Do
					$PickJobResource  = _ImageSearch( $imgsrc7, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 6 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "left", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $PickJobResource  = 1
			Case 4 ; 3hr
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Advanced Tools)")
				Do
					$PickJobResource  = _ImageSearch( $imgsrc8, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 6 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "left", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $PickJobResource  = 1
			Case 5 ; 9hr
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Basket Of Groceries)")
				Do
					$PickJobResource  = _ImageSearch( $imgsrc9, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 6 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "left", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $PickJobResource  = 1
			Case 6 ; 1day
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Toolbox)")
				Do
					$PickJobResource  = _ImageSearch( $imgsrc10, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 6 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "left", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $PickJobResource  = 1
			Case Else ; Jika di Settingan tidak ada Nilai
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Beverage)")
				Do
					$PickJobResource  = _ImageSearch( $imgsrc5, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 6 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "left", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $PickJobResource  = 1
		EndSwitch

		If $PickJobResource  = 1 Then
			Sleep(Int($DelayPickJob))
			MouseClick( "left", $xJob, $yJob, 1, 10)
			PesanKonsol("Job Found Count: " & $CountJob, "Start Pick Job: " & $GetJobResource)
			Sleep(200)
			MouseMove( 105, 404, 7) ;Save Posisi
			$xRes = 0 ; Reset Kordnat
			$yRes = 0
			$xJob = 0
			$yJob = 0
		EndIf
	Endif
	;UlangJika Stack tidak tercapai
	CommandCariResource()
EndFunc

Func CommandCariGold()
;~ 	ReadSettingan()
	#Region Deklarasi
	$iGold = 0
	$CountSearchGold = 0
	$xFalseWindw = 0
	$yFalseWindw = 0
	$LimitFindGold = IniRead($hFileSetting, "SettingAplikasi", "LimitFindGold", 90)
	#EndRegion
	#Region
	Do
		$CariGold = _ImageSearchArea( $ArrayImgFindGold[$iGold], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xGold, $yGold, 60)
		Local $FalseWindw = _ImageSearch( $imgTutupWindow, 1, $xFalseWindw, $yFalseWindw, 10)
		If $FalseWindw = 1 Then
			Sleep(100)
			MouseClick( "left", $xFalseWindw, $yFalseWindw, 1, 10)
			Sleep(100)
			MouseMove( 105, 404, 4)
		EndIf
		$iGold += 1
		If $iGold = 3 Then $iGold = 0
		$CountSearchGold += 1
		Sleep(Int($DelaySearchImage))
		PesanKonsol( "Searching Gold, Limit: " &$LimitFindGold & ", Delay: " & $DelaySearchImage, "Count: " & $CountSearchGold + 1 & " Using Image: " & $iGold)
		If $CountSearchGold = Int($LimitFindGold) Then
			PesanKonsol( "Maximum Stack Gold Reach", "Executing Search for Metal")
			;Coba Reset Web While Counting Limit
				$FindRefreshBtn = _ImageSearch( @ScriptDir & "img\03Main\SessionOk.bmp", 1, $xPosReset, $yPosReset, 60)
				If $FindRefreshBtn = 1 Then
					PesanKonsol("Executing To Home")
					MouseClick( "left", $xPosReset, $yPosReset, 10)
					Sleep(Random(125000, 200000))
					CommandSetPosisiKota()
				Endif
			;Pass Jika Tidak ada Window Refresh dari Server Lanjut Eksekusi Cari Gold
			PesanKonsol("Switch Searching Resource to Metal")
			CommandCariMetal()
		EndIf
		;Coba Reset Web While Counting Limit
		$FindRefreshBtn = _ImageSearch( @ScriptDir & "img\03Main\SessionOk.bmp", 1, $xPosReset, $yPosReset, 60)
		If $FindRefreshBtn = 1 Then
			PesanKonsol("Executing To Home")
			MouseClick( "left", $xPosReset, $yPosReset, 10)
			Sleep(Random(125000, 200000))
			CommandSetPosisiKota()
		Endif
	Until $CariGold = 1
	#EndRegion
	Sleep(200)
	If $CariGold = 1 Then
		Sleep(100)
		PesanKonsol("Gold Found", "PosX: " & $xGold & " PosY: " & $yGold)
		Sleep(Int(Number($DelayGetJob)))
		MouseClick( "left", $xGold + $UPosXGold, $yGold + $UPosYGold, 1, 8)
		$TotalPickGolds += 1
		MouseMove(105, 404, 5)
		PesanKonsol("Collecting Gold", "PosX: " & $xGold & " PosY: " & $yGold & " Total Golds Collected: " & $TotalPickGolds)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		$xGold = 0
		$yGold = 0
		$CountSearchGold = 0
	EndIf
	CommandCariGold()
EndFunc

Func CommandCariMetal()
;~ 	ReadSettingan()
	#Region Deklarasi Sub Cari Metal
	$iMetal = 0
	$xMetal = 0
	$yMetal = 0
	Local $MetalFound = 0
	$CountSearchMetal = 0
	$CountJob = 0
	$xJob = 0
	$yJob = 0
	$LimitFindMetal = IniRead($hFileSetting, "SettingAplikasi", "LimitFindMetal", 100)
	#EndRegion
	#Region Loop Pencarian Metal
	Do
 		$CariMetal = _ImageSearchArea( $ArrayImgFindMetal[$iMetal], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xMetal, $yMetal, 95)
 		$iMetal += 1
		$CountSearchMetal += 1
		If $iMetal = 4 Then $iMetal = 0
		Sleep(Int($DelaySearchImage))
		PesanKonsol("Searching Metal, Limit: " & $LimitFindMetal & ", Delay: " & $DelaySearchImage, "Count: " & $CountSearchMetal & " Using Image: " & $iMetal + 1)
		If $CountSearchMetal = Int($LimitFindMetal) Then
			PesanKonsol("Maksimum Stack Reach", "Switch")
			CommandCariCrystal()
		EndIf
	Until $CariMetal = 1
	#EndRegion
	Sleep(200)
	If $CariMetal = 1 Then
		Sleep(100)
		PesanKonsol("Metal Found", "Using Image: " & $iMetal & "; PosX: " & $xMetal & " PosY: " & $yMetal)
		Sleep(Int(Number($DelayGetJob)))
		MouseClick( "left", $xMetal + $UPosXMetal, $yMetal + $UPosYMetal, 1, 10)
		$TotalPickMetals += 1
;~ 		Sleep(200)
		MouseMove( 105, 404, 5)
		PesanKonsol( "Collecting Metal", "PosX: " & $xMetal & " PosY: " & $yMetal & " Total Collected Metals: " & $TotalPickMetals)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		$CountSearchMetal = 0
		$GetJobMetal = IniRead( $hFileSetting, "SetupJob", "Metal", 1)
		$PickJobMetal = 0
		Switch $GetJobMetal
			Case 1
				PesanKonsol( "Searching Job For Metal", "Using Job: " & $GetJobMetal & "(Precious Ring)")
				Do
					$PickJobMetal = _ImageSearch( $imgsrc11, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 6 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xMetal + $UPosXMetal, $yMetal + $UPosYMetal, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMetal = 1
			Case 2
				PesanKonsol( "Searching Job For Metal", "Using Job: " & $GetJobMetal & "(Precious Ring)")
				Do
					$PickJobMetal = _ImageSearch( $imgsrc38, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 6 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xMetal + $UPosXMetal, $yMetal + $UPosYMetal, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMetal = 1
			Case 3
				PesanKonsol( "Searching Job For Metal", "Using Job: " & $GetJobMetal & "(Precious Ring)")
				Do
					$PickJobMetal = _ImageSearch( $imgsrc39, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 6 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xMetal + $UPosXMetal, $yMetal + $UPosYMetal, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMetal = 1
			Case Else
				PesanKonsol( "Searching Job For Metal", "Using Job: " & $GetJobMetal & "(Precious Ring)")
				Do
					$PickJobMetal = _ImageSearch( $imgsrc11, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 6 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xMetal + $UPosXMetal, $yMetal + $UPosYMetal, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMetal = 1
		EndSwitch
		If $PickJobMetal = 1 Then
			Sleep(Int($DelayPickJob))
			MouseClick( "left", $xJob, $yJob, 1, 10)
			PesanKonsol("Job Found @Count: " & $CountJob, "Start Pick Job: " & $GetJobMetal)
			Sleep(200)
			MouseMove( 105, 404, 7)
			$xMetal = 0
			$yMetal = 0
			$xJob = 0
			$yJob = 0
		EndIf
	EndIf
	CommandCariMetal()
EndFunc

Func CommandCariCrystal()
;~ 	ReadSettingan()
	#Region Deklarasi
	$iCrystal = 0
	$xCrystal = 0
	$yCrystal = 0
	$CountSearchCrystal = 0
	Local $CrystalFound = 0
	$CountJob = 0
	$xJob = 0
	$yJob = 0
	$LimitFindCrystal = IniRead($hFileSetting, "SettingAplikasi", "LimitFindCrystal", 100)
	#EndRegion
	#Region Loop Cari Crystal
	Do
		$CariCrystal = _ImageSearchArea( $ArrayImgFindCrystal[$iCrystal], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xCrystal, $yCrystal, 80)
		$iCrystal += 1
		$CountSearchCrystal += 1
		If $iCrystal = 4 Then $iCrystal = 0
		Sleep(Int($DelaySearchImage))
		PesanKonsol( "Searching Crsytal, Limit: " & $LimitFindCrystal & ", Delay: " & $DelaySearchImage, "Count: " & $CountSearchCrystal & " Using Image: " & $iCrystal)
		If $CountSearchCrystal = Int($LimitFindCrystal) Then
			PesanKonsol("Maksimum Stack Reach", "Switch Searching Crystal To Scroll")
			CommandCariPlank()
		EndIf
	Until $CariCrystal = 1
	#EndRegion
	Sleep(200)
	If $CariCrystal = 1 Then
		Sleep(100)
		PesanKonsol("Crystal Found", "Using Image: " & $iCrystal & "; PosX: " & $xCrystal & " PosY: " & $yCrystal)
		Sleep(Int(Number($DelayGetJob)))
		MouseClick("left", $xCrystal + $UPosXCrystal, $yCrystal + $UPosYCrystal, 1, 10)
		$TotalPickCrystals += 1
		MouseMove(105, 404, 3)
		PesanKonsol("Collecting Crsytal", "PosX: " & $xCrystal & " PosY: " & $yCrystal & " Total Collected Crystals: " & $TotalPickCrystals)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		$CountSearchCrystal = 0
		$GetJobCrystal = IniRead( $hFileSetting, "SetupJob", "Crystal", 1)
		$PickJobCrystal = 0
		Switch $GetJobCrystal
			Case 1
				PesanKonsol("Searching Job Crystal", "Using Job: " & $GetJobCrystal & "(Small Flacon)")
				Do
					$PickJobCrystal = _ImageSearch( $imgsrc37, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("left", $xCrystal + $UPosXCrystal, $yCrystal + $UPosYCrystal, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobCrystal = 1
			Case 2
				PesanKonsol("Searching Job Crystal", "Using Job: " & $GetJobCrystal & "(Small Flacon)")
				Do
					$PickJobCrystal = _ImageSearch( $imgsrc38, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("left", $xCrystal + $UPosXCrystal, $yCrystal + $UPosYCrystal, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobCrystal = 1
			Case 3
				PesanKonsol("Searching Job Crystal", "Using Job: " & $GetJobCrystal & "(Small Flacon)")
				Do
					$PickJobCrystal = _ImageSearch( $imgsrc39, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("left", $xCrystal + $UPosXCrystal, $yCrystal + $UPosYCrystal, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobCrystal = 1
			Case Else
				PesanKonsol("Searching Job Crystal", "Using Job: " & $GetJobCrystal & "(Small Flacon)")
				Do
					$PickJobCrystal = _ImageSearch( $imgsrc37, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("left", $xCrystal + $UPosXCrystal, $yCrystal + $UPosYCrystal, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobCrystal = 1
		EndSwitch
		If $PickJobCrystal = 1 Then
			Sleep(Int($DelayPickRes))
			MouseClick("left", $xJob, $yJob, 1, 10)
			PesanKonsol("Job Found @Count: " & $CountJob, "Start Pick Job: " &$GetJobCrystal)
			Sleep(200)
			MouseMove(103, 404, 3)
			$xCrystal = 0
			$yCrystal = 0
			$xJob = 0
			$yJob = 0
		EndIf
	Endif
	CommandCariCrystal()
EndFunc

Func CommandCariPlank()
;~ 	ReadSettingan()
	#Region Deklarasi
	$xPlank = 0
	$yPlank = 0
	$iPlank = 0
	$CountSearchPlank = 0
	$CountJob = 0
	Local $PlankFound = 0
	$xJob = 0
	$yJob = 0
	$LimitFindPlank = IniRead($hFileSetting, "SettingAplikasi", "LimitFindPlank", 100)
	#EndRegion
	#Region Cari Plank
	Do
		$CariPlank = _ImageSearchArea( $ArrayImgFindPlank[$iPlank], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xPlank, $yPlank, 75)
		$iPlank += 1
		$CountSearchPlank += 1
		If $iPlank = 4 Then $iPlank = 0
		Sleep(Int($DelaySearchImage))
		PesanKonsol("Searching Plank, Limit: " & $LimitFindPlank & ", Delay: " & $DelaySearchImage, "Count: " & $CountSearchPlank & " Using Image: " & $iPlank)
		If $CountSearchPlank = Int($LimitFindPlank) Then
			PesanKonsol("Maksimum Stack Reach", "Switch")
			CommandCariMarble()
		EndIf
	Until $CariPlank = 1
	#EndRegion
	Sleep(200)
	If $CariPlank = 1 Then
		Sleep(100)
		PesanKonsol("Plank Found", "Using Image: " & $iPlank & "; PosX: " & $xPlank & " PosY: " & $yPlank)
		Sleep(Int(Number($DelayGetJob)))
		MouseClick("left", $xPlank + int($UPosXPlank), $yPlank + int($UPosYPlank), 1, 10)
		$TotalPickPlanks += 1
		MouseMove(105, 403, 3)
		PesanKonsol("Collecting Plank", "PosX: " & $xPlank & " PosY: " & $yPlank & " Total Planks Collected: " & $TotalPickPlanks)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		$CountSearchPlank = 0
		$GetJobPlank = IniRead( $hFileSetting, "SetupJob", "Plank", 1)
		$PickJobPlank = 0
		Switch $GetJobPlank
			Case 1
				PesanKonsol("Searching Job", "Using Job: " & $GetJobPlank & "(Beverage)")
				Do
					$PickJobPlank = _ImageSearch( $imgsrc11, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("left", $xPlank + int($UPosXPlank), $yPlank + int($UPosYPlank), 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobPlank = 1
			Case 2
				PesanKonsol("Searching Job", "Using Job: " & $GetJobPlank & "(Beverage)")
				Do
					$PickJobPlank = _ImageSearch( $imgsrc38, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("left", $xPlank + int($UPosXPlank), $yPlank + int($UPosYPlank), 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobPlank = 1
			Case 3
				PesanKonsol("Searching Job", "Using Job: " & $GetJobPlank & "(Beverage)")
				Do
					$PickJobPlank = _ImageSearch( $imgsrc39, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("left", $xPlank + int($UPosXPlank), $yPlank + int($UPosYPlank), 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobPlank = 1
			Case Else
				PesanKonsol("Searching Job", "Using Job: " & $GetJobPlank & "(Beverage)")
				Do
					$PickJobPlank = _ImageSearch( $imgsrc11, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("left", $xPlank + int($UPosXPlank), $yPlank + int($UPosYPlank), 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobPlank = 1
		EndSwitch
		If $PickJobPlank = 1 Then
			Sleep(Int($DelayPickRes))
			MouseClick( "left", $xJob, $yJob, 1, 10)
			PesanKonsol("Job Found @Count: " & $CountJob, "Stack Pick Job: " & $GetJobPlank)
			Sleep(200)
			MouseMove(103, 404, 3)
			$xPlank = 0
			$yPlank = 0
			$xJob = 0
			$yJob = 0
		EndIf
	EndIf
	CommandCariPlank()
EndFunc

Func CommandCariMarble()
;~ 	ReadSettingan()
	#Region Deklarasi
	$iMarble = 0
	$CountSearchMarble = 0
	$xMarble = 0
	$yMarble = 0
	$CountJob = 0
	Local $MarbleFound = 0
	$xJob = 0
	$yJob = 0
	#EndRegion
	#Region Loop Cari Marble
	$LimitFindMarble = IniRead($hFileSetting, "SettingAplikasi", "LimitFindMarble", 100)
	Do
		$CariMarble = _ImageSearchArea( $ArrayImgFindMarble[$iMarble], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xMarble, $yMarble, 85)
		Sleep(Int($DelaySearchImage))
		$iMarble += 1
		$CountSearchMarble += 1
		If $iMarble = 4 Then $iMarble = 0
		PesanKonsol("Searching Marble, Limit: " & $LimitFindMarble & ", Delay: " & $DelaySearchImage, "Count: " & $CountSearchMarble & " Using Image: " & $iMarble)
		If $CountSearchMarble = Int($LimitFindMarble) Then
			PesanKonsol("Maksimum Stack Reach", "Switch Searching Marble To Crystal")
			CommandCariScroll()
		EndIf
	Until $CariMarble = 1
	#EndRegion
	Sleep(200)
	If $CariMarble = 1 Then
		Sleep(100)
		PesanKonsol("Marble Found", "Using Image: " & $iMarble & "; PosX: " & $xMarble & " PosY: " & $yMarble)
		Sleep(Int(Number($DelayGetJob)))
		MouseClick( "left", $xMarble + $UPosXMarble, $yMarble + $UPosYMarble, 1, 10)
		$TotalPickMarbles += 1
		MouseMove(105, 404, 3)
		PesanKonsol("Collecting Marble", "PosX: " & $xMarble & " PosY: " & $yMarble & " Total Collected Marbles: " & $TotalPickMarbles)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		$CountSearchMarble = 0
		$GetJobMarble = IniRead( $hFileSetting, "SetupJob", "Marble", 1)
		$PickJobMarble = 0
		Switch $GetJobMarble
			Case 1
				PesanKonsol("Searching Job Marble", "Using Job: " & $GetJobMarble & "(Beverage)")
				Do
					$PickJobMarble = _ImageSearch( $imgsrc11, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xMarble + $UPosXMarble, $yMarble + $UPosYMarble, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMarble = 1
			Case 2
				PesanKonsol("Searching Job Marble", "Using Job: " & $GetJobMarble & "(Beverage)")
				Do
					$PickJobMarble = _ImageSearch( $imgsrc38, 1, $xJob, $yJob, 65)
					Sleep(100)
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xMarble + $UPosXMarble, $yMarble + $UPosYMarble, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMarble = 1
			Case 3
				PesanKonsol("Searching Job Marble", "Using Job: " & $GetJobMarble & "(Beverage)")
				Do
					$PickJobMarble = _ImageSearch( $imgsrc39, 1, $xJob, $yJob, 65)
					Sleep(100)
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xMarble + $UPosXMarble, $yMarble + $UPosYMarble, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMarble = 1
			Case Else
				PesanKonsol("Searching Job Marble", "Using Job: " & $GetJobMarble & "(Beverage)")
				Do
					$PickJobMarble = _ImageSearch( $imgsrc11, 1, $xJob, $yJob, 65)
					Sleep(100)
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xMarble + $UPosXMarble, $yMarble + $UPosYMarble, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMarble = 1
		EndSwitch
		If $PickJobMarble = 1 Then
			Sleep(Int($DelayPickRes))
			MouseClick( "left", $xJob, $yJob, 1, 10)
			PesanKonsol("Job Found @Count: " & $CountJob, "Start Pick Job: " & $GetJobMarble)
			Sleep(200)
			MouseMove(105, 404, 3)
			$xMarble = 0
			$yMarble = 0
			$xJob = 0
			$yJob = 0
		EndIf
	EndIf
	CommandCariMarble()
EndFunc

Func CommandCariScroll()
;~ 	ReadSettingan()
	$xScrol = 0
	$yScrol = 0
	$iScrol = 0
	$CountSearchScroll = 0
	$CountJob = 0
	$xJob = 0
	$yJob = 0
	$LimitFindScroll = IniRead($hFileSetting, "SettingAplikasi", "LimitFindScroll", 100)
	Do
		$CariScroll = _ImageSearchArea( $ArrayImgScroll[$iScrol], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xScrol, $yScrol, 75)
		$iScrol += 1
		If $iScrol = 4 Then $iScrol = 0
		$CountSearchScroll += 1
		Sleep(Int($DelaySearchImage))
		PesanKonsol("Searching Scroll, Limit: " & $LimitFindScroll & ", Delay: " & $DelaySearchImage, "Count: " & $CountSearchScroll & " Using Image: " & $iScrol)
		If $CountSearchScroll = Int($LimitFindScroll) Then
			CommandCariSilk()
		EndIf
	Until $CariScroll = 1
	Sleep(200)
	If $CariScroll = 1 Then
		Sleep(100)
		PesanKonsol("Scroll Found", "Using Image: " & $iScrol & " PoxX: " & $xScrol & " PosY: " & $yScrol)
		Sleep(Int(Number($DelayGetJob)))
		MouseClick( "left", $xScrol + $UPosXSilk, $yScrol + $UPosYSilk, 1, 10)
		$TotalPickScrolls += 1
		MouseMove( 105, 404, 5)
		PesanKonsol("Collecting Scroll", "PosX: " & $xScrol & " PosY: " & $yScrol & " Total Scrolls Collected: " & $TotalPickScrolls)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		$CountSearchScroll = 0
		$GetJobScroll= Iniread( $hFileSetting, "SetupJob", "Scroll", 1)
		$pickJobScroll = 0
		Switch $GetJobScroll
			Case 1
				Do
					$pickJobScroll = _ImageSearch( $imgsrc37, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						MouseClick("left", 103, 403, 1, 3)
						Sleep(300)
						MouseClick("left", $xScrol + $UPosXScroll, $yScrol + $UPosYScroll, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
					PesanKonsol("Searching Job")
				Until $pickJobScroll = 1
			Case 2
				Do
					$pickJobScroll = _ImageSearch( $imgsrc38, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						MouseClick("left", 103, 403, 1, 3)
						Sleep(300)
						MouseClick("left", $xScrol + $UPosXScroll, $yScrol + $UPosYScroll, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
					PesanKonsol("Searching Job")
				Until $pickJobScroll = 1
			Case 3
				Do
					$pickJobScroll = _ImageSearch( $imgsrc39, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						MouseClick("left", 103, 403, 1, 3)
						Sleep(300)
						MouseClick("left", $xScrol + $UPosXScroll, $yScrol + $UPosYScroll, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
					PesanKonsol("Searching Job")
				Until $pickJobScroll = 1
			Case Else
				Do
					$pickJobScroll = _ImageSearch( $imgsrc11, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						MouseClick("left", 103, 403, 1, 3)
						Sleep(300)
						MouseClick("left", $xScrol + $UPosXScroll, $yScrol + $UPosYScroll, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
					PesanKonsol("Searching Job")
				Until $pickJobScroll = 1
		EndSwitch
		If $pickJobScroll = 1 Then
			Sleep(Int($DelayPickJob))
			MouseClick("left", $xJob, $yJob, 1, 10)
			PesanKonsol("Executing Job")
			Sleep(200)
			MouseMove(105, 404, 3)
			$xScrol = 0
			$yScrol = 0
			$xJob = 0
			$yJob = 0
		EndIf
	EndIf
	CommandCariScroll()
EndFunc

Func CommandCariSilk()
;~ 	ReadSettingan()
	$iSilk = 0
	$CountSearchSilk = 0
	$xSilk = 0
	$ySilk = 0
	$CountJob = 0
	$LimitFindSilk = IniRead($hFileSetting, "SettingAplikasi", "LimitFindSilk", 100)
	Do
		$CariSilk = _ImageSearchArea( $ArrayImgSilks[$iSilk], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xSilk, $ySilk, 90)
		Sleep(Int($DelaySearchImage))
		$iSilk += 1
		If $iSilk = 4 Then $iSilk = 0
		$CountSearchSilk += 1
		PesanKonsol("Searching Silk, Limit: " & $LimitFindSilk & ", Delay: " & $DelaySearchImage, "Count: " & $CountSearchSilk & " Using Image: " & $iSilk)
		If $CountSearchSilk = Int($LimitFindSilk) Then
			PesanKonsol("Maximun Stack Silk Reach", "Switch Searchs to Resources")
			CommandCariResource()
		EndIf
	Until $CariSilk = 1
	Sleep(200)
	If $CariSilk = 1 Then
		Sleep(100)
		PesanKonsol("Silk Found", "Using Image: " & $iSilk & " PosX: " & $xSilk & " PosY: " & $ySilk)
		Sleep(Int(Number($DelayGetJob)))
		MouseClick("left", ($ySilk + $UPosXSilk), ($ySilk + $UPosYSilk), 1, 10)
		$TotalPickSilks += 1
		MouseMove(105, 404, 5)
		PesanKonsol("Collecting Silk", "PosX: " & $xSilk & " PosY: " & $ySilk & " Total Silk Collected: " & $TotalPickSilks)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		$GetJobSilk = IniRead( $hFileSetting, "SetupJob", "Silk", 1)
		$PickJobSilk = 0
		Switch $GetJobSilk
			Case 1
				PesanKonsol("Searching Job For Silk", "Using Job: " & $GetJobSilk & "()")
				Do
					$PickJobSilk = _ImageSearch( $imgsrc37, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xSilk + $UPosXSilk, $ySilk + $UPosYSilk, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobSilk = 1
			Case 2
				PesanKonsol("Searching Job For Silk", "Using Job: " & $GetJobSilk & "()")
				Do
					$PickJobSilk = _ImageSearch( $imgsrc38, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xSilk + $UPosXSilk, $ySilk + $UPosYSilk, 1,10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobSilk = 1
			Case 3
				PesanKonsol("Searching Job For Silk", "Using Job: " & $GetJobSilk & "()")
				Do
					$PickJobSilk = _ImageSearch( $imgsrc39, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xSilk + $UPosXSilk, $ySilk + $UPosYSilk, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobSilk = 1
			Case Else
				PesanKonsol("Searching Job For Silk", "Using Job: " & $GetJobSilk & "()")
				Do
					$PickJobSilk = _ImageSearch( $imgsrc37, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "left", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "left", $xSilk + $UPosXSilk, $ySilk + $UPosYSilk, 1, 10)
						Sleep(200)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobSilk = 1
		EndSwitch
		If $GetJobSilk = 1 Then
			Sleep(Int($DelayPickJob))
			MouseClick( "left", $xJob, $yJob, 1, 10)
			PesanKonsol("Job Found @Count: " & $CountJob, "Start Pick Job: " & $GetJobSilk)
			Sleep(200)
			MouseMove(105, 404, 3)
			$xSilk = 0
			$ySilk = 0
			$xJob = 0
			$yJob = 0
		EndIf
	EndIf
	CommandCariSilk()
EndFunc

Func CommandRestart()
	Sleep(Random(1000, 3000))
	ShellExecute(@ScriptFullPath)
	CommandExit()
EndFunc

Func PesanKonsol( $refMsg, $refComment = " ")
	ConsoleWrite( "[" & @YEAR & ":" & @MON & ":" & @MDAY & ":" & @HOUR & ":" & @MIN & ":" & @SEC & "]" & $refMsg & "; " & $refComment & @CRLF)
EndFunc

Func CommandSetPosisiKota()
	$xCity = 0
	$yCity = 0
	Local	$ImgCity[4] = [$imgCity1, $imgCity2, $imgCity3, $imgCity4]
	Local	$ImgHome[4] = [$imgHome1, $imgHome2, $imgHome3, $imgHome4]
	$iCity = 0
	$CountiCity = 0
	Do
		;World
		$CariCity = _ImageSearch( $ImgCity[$iCity], 1, $xCity, $yCity, 75)
		Sleep(300)
		$iCity += 1
		$CountiCity += 1
		If $iCity = 3 Then $iCity = 0
		PesanKonsol("Searching City: " & $CountiCity + 1)
	Until $CariCity = 1
	If $CariCity = 1 Then
		Sleep(200)
		MouseClick("left", $xCity, $yCity, 1, 10)
		PesanKonsol("Selecting World")
		$CariCity = 0
	EndIf
	Sleep(800)
	$iCity = 0
	$CountiCity = 0
	$xCity = 0
	$yCity = 0
	Do
		$CariHome = _ImageSearch( $ImgHome[$iCity], 1, $xCity, $yCity, 75)
		Sleep(300)
		$iCity += 1
		$CountiCity += 1
		If $iCity = 1 Then $iCity = 0
		PesanKonsol("Searching Home: " & $CountiCity, "Returning to Home")
	Until $CariHome = 1
	If $CariHome = 1 Then
		Sleep(200)
		MouseClick("left", $xCity, $yCity, 1, 10)
		$CariHome = 0
	EndIf
	Sleep(800)
	$iCity = 2
	$CountiCity = 0
	$xCity = 0
	$yCity = 0
	Do
		$CariHome = _ImageSearch( $ImgHome[$iCity], 1, $xCity, $yCity, 75)
		Sleep(300)
		$iCity += 1
		$CountiCity += 1
		If $iCity = 3 Then $iCity = 2
		PesanKonsol("Searching Home: " & $CountiCity, "Returning to Home")
	Until $CariHome = 1
	If $CariHome = 1 Then
		Sleep(200)
		CenteringScreen()
		;MouseClick("left", $xCity, $yCity, 1, 10)
	EndIf
	Sleep(800)
EndFunc

Func CommandSetTitle($tRes, $tGold, $tMetal, $tPlank, $tMarb, $tCry, $tSco, $tSlk,  $CurrTitle = "Elvenar AutoClick Log")
	Sleep(300)
	Local $AddTitle = " [R:" & $tres & "; G:" & $tGold & "; Mt:" & $tMetal & "; P:" & $tPlank & "; Ma:" & $tMarb & "; Cr:" & $tCry & "; Sc:" & $tSco & "; Sl:" & $tSlk & "]"
	$tSetTitle = $CurrTitle & $addTitle
;~ 	WinSetTitle( $CurrTitle, "", $tSetTitle)
	DllCall( "Kernel32.dll", "bool", "AllocConsole")
	_WinApi_SetConsoleTitle($tSetTitle)
	DllClose("Kernel32.dll")

	If Not FileExists(@ScriptDir & "\log\Elvenar.log") Then
		_FileCreate( @ScriptDir & "\log\Elvenar.log")
		FileOpen(@ScriptDir & "\log\Elvenar.log", 2)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", "Elvenar AutoClick Log" & _Now())
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", 0)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", 0)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", 0)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", 0)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", 0)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", 0)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", 0)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", 0)
		FileClose(@ScriptDir & "\log\Elvenar.log")
	Else
		FileOpen(@ScriptDir & "\log\Elvenar.log", 2)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", "Elvenar AutoClick Log" & _Now())
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $tres)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $tGold)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $tMetal)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $tPlank)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $tMarb)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $tCry)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $tSco)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $tSlk)
		FileClose(@ScriptDir & "\log\Elvenar.log")
	EndIf
EndFunc

Func CommandWriteLog()
	Local $tempTitle = $tSetTitle
	If Not FileExists(@ScriptDir & "\log\Elvenar.log") Then
		_FileCreate( @ScriptDir & "\log\Elvenar.log")
		FileOpen(@ScriptDir & "\log\Elvenar.log", 2)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", "Elvenar AutoClick Log" & _Now())
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickResources)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickGolds)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickMetals)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickPlanks)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickMarbles)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickCrystals)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickScrolls)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickSilks)
		FileClose(@ScriptDir & "\log\Elvenar.log")
	Else
		FileOpen(@ScriptDir & "\log\Elvenar.log", 2)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", "Elvenar AutoClick Log" & _Now())
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickResources)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickGolds)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickMetals)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickPlanks)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickMarbles)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickCrystals)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickScrolls)
		FileWriteLine( @ScriptDir & "\log\Elvenar.log", $TotalPickSilks)
		FileClose(@ScriptDir & "\log\Elvenar.log")
	EndIf
	Local $hLogRead = FileRead( @ScriptDir & "\log\Elvenar.log")
EndFunc

Func CommandStartServer()
	Sleep(Random(600,1500))
	Send( "^t")
	Sleep(Random(800,1200))
	Send("^w")
	Sleep(Random(700,900))
	ShellExecute( "Chrome.exe", "https://elvenar.com")
	$CountSearchingServer = 0
	Do
		$CariServer = _ImageSearch( $imgServer1, 1, $xServer, $yServer, 60)
		Sleep(100)
		PesanKonsol("Searching Server")
		$CountSearchingServer += 1
		If $CountSearchingServer = 100 Then
			ExitLoop
		EndIf
	Until $CariServer = 1
	If $CariServer = 1 Then
		Sleep(200)
		MouseClick( "left", $xServer, $yServer, 1, 10)
		Sleep(200)
		PesanKonsol("Selecting Server")
		Sleep(1000)
		PesanKonsol("Waiting....")
		Sleep(Random(30000, 60000))
		CommandSetPosisiKota()
	Else
		CommandSetPosisiKota()
	EndIf
EndFunc

Func FindSponsorWnd()
	$xtv = 0
	$ytv = 0
	PesanKonsol("Searching Sponsor Session Window")
	$tvhwnd = WinGetHandle( "Sponsored session", "")
	If WinExists( $tvhwnd) Then
		$wndw = WinGetPos( $tvhwnd, "OK")
		PesanKonsol("Result:" & $tvhwnd, "Pos " & "x: " & $wndw[0] & "y: " & $wndw[1])
		Sleep(2000)
		WinActivate( $tvhwnd)
		Sleep(2000)
		Send("{ENTER}")
		Sleep(1000)
		WinActivate("Elvenar - Fantasy City Builder Game")
		CommandSetPosisiKota()
	Else
		PesanKonsol("No Window")
		Sleep(500)
		WinActivate("Elvenar - Fantasy City Builder Game")
		CommandSetPosisiKota()
	EndIf
EndFunc

While 1
	Sleep(10)
Wend

Func TogglePause()
	$Paused = Not $Paused
	While $Paused
		Sleep(100)
		PesanKonsol("Aplikasi", "Script Paused")
	Wend
EndFunc

Func CommandExit()
	CommandWriteLog()
	Exit 0
EndFunc

Func _WinApi_SetConsoleTitle($sTitle, $hDLL = "Kernel32.dll")
    Local $iRet = DllCall($hDLL, "bool", "SetConsoleTitle", "str", $sTitle)
    If $iRet[0] < 1 Then Return False
    Return True
EndFunc
