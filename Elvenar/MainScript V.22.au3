#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=IconRes.ico
#AutoIt3Wrapper_Outfile=MainScript V.22.exe
#AutoIt3Wrapper_Outfile_x64=MainScript V.22_X64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_Comment=Elvenar AutoClick
#AutoIt3Wrapper_Res_Description=Elvenar AutoClicker
#AutoIt3Wrapper_Res_Fileversion=17.2.23.11
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#AutoIt3Wrapper_Res_LegalCopyright=AgungJawata™
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "ImageSearch.au3"
#include "modul\fileglobal.au3"

Opt( "MouseClickDelay", 10)

#Region Deklarasi
Global $Paused

Global $hFileSetting = @ScriptDir & "\config\Config.ini"

Local $LimitFindResource
Local $LimitFindGold
Local $LimitFindMetal
Local $LimitFindPlank
Local $LimitFindMarble
Local $LimitFindCrystal
Local $LimitFindScroll
Local $LimitFindSilk
Local $OnlySearchResource
Local $boolSearchArea
Local $SearchAreaTop
Local $SearchAreaLeft
Local $SearchAreaRight
Local $SearchAreaBottom

;Set Posisi Window
Local $StartPointerPosition
Local $DelaySearchImage
Local $DelayPickRes
Local $DelayPickJob

;Maks Stack Objek
Local $ResidenceStack
Local $ResourceStack
Local $MetalStack
Local $PlankStack
Local $MarbleStack
Local $CrystalStack
Local $ScrollStack
Local $SilkStack
Local $ReadServer
Local $multiServer
Local $MetalFound = 0

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

#EndRegion

#Region Hotkey
	HotKeySet("^+p", "TogglePause")
	HotKeySet("^+q", "CommandExit")
	HotKeySet("^+{HOME}", "CenteringScreen")
	HotKeySet("{HOME}", "CommandSetPosisiKota")
	HotKeySet( "^+K", "CommandStartServer")
	HotKeySet("^+r", "CommandRestart")
	HotKeySet("^{NUMPAD0}","CommandCariResource")
	HotKeySet("^{NUMPAD1}","CommandCariGold")
	HotKeySet("^{NUMPAD2}","CommandCariMetal")
	HotKeySet("^{NUMPAD3}","CommandCariPlank")
	HotKeySet("^{NUMPAD4}","CommandCariMarble")
	HotKeySet("^{NUMPAD5}","CommandCariCrystal")
	HotKeySet("^{NUMPAD6}","CommandCariScroll")
;~ 	HotKeySet("^+{NUMPAD7}","CommandCariSilk")
;~ 	HotKeySet("^+{NUMPAD8}","CommandCariResource")
;~ 	HotKeySet("^+{NUMPAD9}","CommandCariResource")
#EndRegion

DllCall( "Kernel32.dll", "bool", "AllocConsole")
_WinApi_SetConsoleTitle("Elvenar AutoClick Log")
WinSetOnTop( "Elvenar AutoClick Log", "", 1)
WinSetTrans( "Elvenar AutoClick Log", "", 200)
WinMove( "Elvenar AutoClick Log", "", 720, 4, 640, 95, 3)
DllClose("Kernel32.dll")

ReadSettingan()

Func ReadSettingan()

	$ResidenceStack = IniRead($hFileSetting, "TotalBuilding", "Residence", 19)
	$ResourceStack = IniRead($hFileSetting, "TotalBuilding", "WorkShop", 6)
	$MetalStack = IniRead($hFileSetting, "TotalBuilding", "Steel", 5)
	$PlankStack = IniRead($hFileSetting, "TotalBuilding", "Plank", 4)
	$MarbleStack = IniRead($hFileSetting, "TotalBuilding", "Marble", 5)
	$CrystalStack = IniRead($hFileSetting, "TotalBuilding", "Crystal", 2)
	$ScrollStack = IniRead($hFileSetting, "TotalBuilding", "Scrolls", 1)
	$SilkStack = IniRead($hFileSetting, "TotalBuilding", "Silk", 1)
	$ReadServer = IniRead($hFileSetting, "SettingAplikasi", "Server1", "Arendyll")
	$multiServer = IniRead($hFileSetting, "SettingAplikasi", "multiserver", 0)
	$GetJobResource = IniRead($hFileSetting, "SetupJob", "Resource", 1)
	$GetJobMetal = IniRead($hFileSetting, "SetupJob", "Metal", 1)

	$LimitFindResource = IniRead($hFileSetting, "SettingAplikasi", "LimitFindResource", 100)
	$LimitFindGold = IniRead($hFileSetting, "SettingAplikasi", "LimitFindGold", 90)
	$LimitFindMetal = IniRead($hFileSetting, "SettingAplikasi", "LimitFindMetal", 100)
	$LimitFindPlank = IniRead($hFileSetting, "SettingAplikasi", "LimitFindPlank", 100)
	$LimitFindMarble = IniRead($hFileSetting, "SettingAplikasi", "LimitFindMarble", 100)
	$LimitFindCrystal = IniRead($hFileSetting, "SettingAplikasi", "LimitFindCrystal", 100)
	$LimitFindScroll = IniRead($hFileSetting, "SettingAplikasi", "LimitFindScroll", 100)
	$LimitFindSilk = IniRead($hFileSetting, "SettingAplikasi", "LimitFindSilk", 100)

	$OnlySearchResource = IniRead($hFileSetting, "SettingAplikasi", "OnlyResource", 1)
	$boolSearchArea = IniRead($hFileSetting, "SettingAplikasi", "SearchArea", 1)
	$SearchAreaTop = IniRead($hFileSetting, "SettingAplikasi", "TopX", 176)
	$SearchAreaLeft = IniRead($hFileSetting, "SettingAplikasi", "TopY", 206)
	$SearchAreaRight = IniRead($hFileSetting, "SettingAplikasi", "wRight", 1298)
	$SearchAreaBottom = IniRead($hFileSetting, "SettingAplikasi", "hBottom", 730)

	$StartPointerPosition = IniRead($hFileSetting, "SettingAplikasi", "PointerWin", 0)
	$DelaySearchImage = IniRead($hFileSetting, "DelayTiming", "SearchImage", 100)
	$DelayPickRes = IniRead($hFileSetting, "DelayTiming","Resource", 400)
	$DelayPickJob = IniRead($hFileSetting, "DelayTiming", "PickJob", 400)
	$DelayGetJob = IniRead($hFileSetting, "DelayTiming", "GetJob", 400)

	$UPosXRes = IniRead($hFileSetting, "CoordinateUserPick", "PickXResource", 8)
	$UPosYRes = IniRead($hFileSetting, "CoordinateUserPick", "PickYResource", 65)
	$UPosXGold = IniRead($hFileSetting, "CoordinateUserPick", "PickXGold", 10)
	$UPosYGold = IniRead($hFileSetting, "CoordinateUserPick", "PickYGold", 70)
	$UPosXMetal = IniRead($hFileSetting, "CoordinateUserPick", "PickXMetal", 6)
	$UPosYMetal = IniRead($hFileSetting, "CoordinateUserPick", "PickYMetal", 75)
	$UPosXPlank = IniRead($hFileSetting, "CoordinateUserPick", "PickXPlank", 10)
	$UPosYPlank = IniRead($hFileSetting, "CoordinateUserPick", "PickYPlank", 70)
	$UPosXMarble = IniRead($hFileSetting, "CoordinateUserPick", "PickXMarble", 4)
	$UPosYMarble = IniRead($hFileSetting, "CoordinateUserPick", "PickYMarble", 70)
	$UPosXCrystal = IniRead($hFileSetting, "CoordinateUserPick", "PickXCrystal", 5)
	$UPosYCrystal = IniRead($hFileSetting, "CoordinateUserPick", "PickYCrystal", 75)
	$UPosXScroll = IniRead($hFileSetting, "CoordinateUserPick", "PickX", 0)
	$UPosYScroll = IniRead($hFileSetting, "CoordinateUserPick", "PickY", 60)
	$UPosXSilk = IniRead( $hFileSetting, "CoordinateUserPick", "PickX", 5)
	$UPosYSilk = IniRead( $hFileSetting, "CoordinateUserPick", "PickY", 70)

EndFunc

Func WriteSetingan()

EndFunc

If $StartPointerPosition = 1 Then
	CommandSetPosisiKota()
;~ 	CenteringScreen()
EndIf

Func CenteringScreen()
	Sleep(Random(2000,2600))
	MouseMove( 1237, 602, 3)
	Sleep(Random(500, 800))
	MouseDown( "primary")
	MouseMove( 1154, 265, 40)
	Sleep(100)
	MouseUp( "primary")
	CommandCariResource()
EndFunc

Func CommandCariResource()
	#Region Deklarasi Sub
	$iResc = 0
	$CountSearchResc = 0
	$CariResource = 0
	$xJob = 0
	$yJob = 0
	$CountJob = 0
	#EndRegion
	#Region Loop Pencarian Image
	Do
		$CariResource = _ImageSearchArea( $ArrayImgResc[$iResc], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xRes, $yRes, 90)
		$iResc += 1
		If $iResc = 4 Then $iResc = 0
		$CountSearchResc += 1
		Sleep(Int($DelaySearchImage))
		PesanKonsol("Searching Resource", "Count: " & $CountSearchResc & " Using Image: " & $iResc)
		;Total Limit Searching Resource dari File Config
		$LimitFindResource = IniRead($hFileSetting, "SettingAplikasi", "LimitFindResource", 100)
		If $CountSearchResc = Int($LimitFindResource) Then
			$OnlySearchResource = IniRead($hFileSetting, "SettingAplikasi", "OnlyResource", 1)
			If $OnlySearchResource = 1 Then
				$CountSearchResc = 0
				ExitLoop
				CommandCariGold()
			EndIf
			PesanKonsol("Maksimum Stack Reach", "Switch")
			;Coba Reset Web While Counting Limit
			$ResetRefresh = _ImageSearch( @ScriptDir & "\img\03Main\SessionBig.bmp", 1, $xPosReset, $yPosReset, 60)
			If $ResetRefresh = 1 Then
				PesanKonsol("Refreshing Web")
				$xPosReset = 0
				$yPosReset = 0
				Sleep(500)
				$FindRefreshBtn = _ImageSearch( @ScriptDir & "img\03Main\SessionOk.bmp", 1, $xPosReset, $yPosReset, 60)
				If $FindRefreshBtn = 1 Then
					PesanKonsol("Executing To Home")
					MouseClick( "primary", $xPosReset, $yPosReset, 10)
					Sleep(Random(125000, 200000))
					CommandSetPosisiKota()
				Endif
			Endif
			;Pass Jika Tidak ada Window Refresh dari Server Lanjut Eksekusi Cari Gold
			PesanKonsol("Switch Searching Resource to Gold")
			CommandCariGold()
		EndIf
		;Coba Reset Web While Counting Limit

		$ResetRefresh = _ImageSearch( @ScriptDir & "\img\03Main\SessionBig.bmp", 1, $xPosReset, $yPosReset, 60)
		If $ResetRefresh = 1 Then
			PesanKonsol("Refreshing Web")
			$xPosReset = 0
			$yPosReset = 0
			Sleep(500)
			$FindRefreshBtn = _ImageSearch( @ScriptDir & "img\03Main\SessionOk.bmp", 1, $xPosReset, $yPosReset, 60)
			If $FindRefreshBtn = 1 Then
				PesanKonsol("Executing To Home")
				MouseClick( "primary", $xPosReset, $yPosReset, 10)
				Sleep(Random(125000, 200000))
				CommandSetPosisiKota()
			Endif
		Endif
	Until $CariResource = 1
	#EndRegion
; 	Jika Resource Ditemukan Lanjutkan Pencarian Job
	If $CariResource = 1 Then
;		Tentukan Pencarian Berdasarkan User Config
		Sleep(100)
		PesanKonsol("Resource Found!", "Using Image: " & $iResc & "; PosX: " & $xRes & " PosY: " & $yRes)
		Sleep(Int($DelayGetJob))
		MouseClick( "primary", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 8)
		$TotalPickResources += 1
		MouseMove(105, 403, 3)
		PesanKonsol("Collecting Resource", "PosX: " & $xRes & " PosY: " & $yRes & " Total Resources Collected: " & $TotalPickResources)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		$GetJobResource = IniRead( $hFileSetting, "SetupJob", "Resource", 1)
		$GetJobResource = 0
		Switch $GetJobResource
			Case 1 ; 5min
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Beverage)")
				Do
					$GetJobResource = _ImageSearch( $imgsrc5, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "primary", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 8)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $GetJobResource = 1
			Case 2 ; 15min
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Simple Tools)")
				Do
					$GetJobResource = _ImageSearch( $imgsrc6, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "primary", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 8)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $GetJobResource = 1
			Case 3 ; 1hr
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Bread)")
				Do
					$GetJobResource = _ImageSearch( $imgsrc7, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "primary", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 8)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $GetJobResource = 1
			Case 4 ; 3hr
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Advanced Tools)")
				Do
					$GetJobResource = _ImageSearch( $imgsrc8, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "primary", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 8)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $GetJobResource = 1
			Case 5 ; 9hr
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Basket Of Groceries)")
				Do
					$GetJobResource = _ImageSearch( $imgsrc9, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "primary", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 8)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $GetJobResource = 1
			Case 6 ; 1day
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Toolbox)")
				Do
					$GetJobResource = _ImageSearch( $imgsrc10, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "primary", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 8)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $GetJobResource = 1
			Case Else ; Jika di Settingan tidak ada Nilai
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobResource & "(Beverage)")
				Do
					$GetJobResource = _ImageSearch( $imgsrc5, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						; Ulangi Klik Jika Terjadi Delay GetRequest
						MouseClick( "primary", 103, 403, 1, 3) ;Save Klik
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 8)
						MouseMove(103, 404, 3)
						$CountJob = 0 ;Loop
					EndIf
					PesanKonsol("Searching Job", "Count: " & $CountJob)
				Until $GetJobResource = 1
		EndSwitch

		If $GetJobResource = 1 Then
			Sleep(Int($DelayPickJob))
			MouseClick( "primary", $xJob, $yJob, 1, 10)
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
	#Region Deklarasi
	$iGold = 0
	$CountSearchGold = 0
	$xFalseWindw = 0
	$yFalseWindw = 0
	#EndRegion
	#Region
	Do
		$CariGold = _ImageSearchArea( $ArrayImgFindGold[$iGold], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xGold, $yGold, 60)
		Local $FalseWindw = _ImageSearch( $imgTutupWindow, 1, $xFalseWindw, $yFalseWindw, 10)
		If $FalseWindw = 1 Then
			Sleep(100)
			MouseClick( "primary", $xFalseWindw, $yFalseWindw, 1, 8)
			Sleep(100)
			MouseMove( 105, 404, 4)
		EndIf
		PesanKonsol( "Searching Gold", "Count: " & $CountSearchGold + 1 & " Using Image: " & $iGold)
		$iGold += 1
		If $iGold = 3 Then $iGold = 0
		$CountSearchGold += 1
		Sleep(((Int($DelaySearchImage))/2) * 1.6)
		$LimitFindGold = IniRead($hFileSetting, "SettingAplikasi", "LimitFindGold", 90)
		If $CountSearchGold = Int($LimitFindGold) Then
			PesanKonsol( "Maximum Stack Gold Reach", "Executing Search for Metal")
			;Coba Reset Web While Counting Limit
			$ResetRefresh = _ImageSearch( @ScriptDir & "\img\03Main\SessionBig.bmp", 1, $xPosReset, $yPosReset, 60)
			If $ResetRefresh = 1 Then
				PesanKonsol("Refreshing Web")
				$xPosReset = 0
				$yPosReset = 0
				Sleep(500)
				$FindRefreshBtn = _ImageSearch( @ScriptDir & "img\03Main\SessionOk.bmp", 1, $xPosReset, $yPosReset, 60)
				If $FindRefreshBtn = 1 Then
					PesanKonsol("Executing To Home")
					MouseClick( "primary", $xPosReset, $yPosReset, 10)
					Sleep(Random(125000, 200000))
					CommandSetPosisiKota()
				Endif
			Endif
			;Pass Jika Tidak ada Window Refresh dari Server Lanjut Eksekusi Cari Gold
			PesanKonsol("Switch Searching Resource to Metal")
			CommandCariMetal()
		EndIf
		;Coba Reset Web While Counting Limit
		$ResetRefresh = _ImageSearch( @ScriptDir & "\img\03Main\SessionBig.bmp", 1, $xPosReset, $yPosReset, 60)
		If $ResetRefresh = 1 Then
			PesanKonsol("Refreshing Web")
			$xPosReset = 0
			$yPosReset = 0
			Sleep(500)
			$FindRefreshBtn = _ImageSearch( @ScriptDir & "img\03Main\SessionOk.bmp", 1, $xPosReset, $yPosReset, 60)
			If $FindRefreshBtn = 1 Then
				PesanKonsol("Executing To Home")
				MouseClick( "primary", $xPosReset, $yPosReset, 10)
				Sleep(Random(125000, 200000))
				CommandSetPosisiKota()
			Endif
		Endif
	Until $CariGold = 1
	#EndRegion
	If $CariGold = 1 Then
		Sleep(100)
		PesanKonsol("Gold Found", "PosX: " & $xGold & " PosY: " & $yGold)
		Sleep(Int($DelayGetJob))
		MouseClick( "primary", $xGold + $UPosXGold, $yGold + $UPosYGold, 1, 8)
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
	#Region Deklarasi Sub Cari Metal
	$iMetal = 0
	$xMetal = 0
	$yMetal = 0
	Local $MetalFound = 0
	$CountSearchMetal = 0
	$CountJob = 0
	$xJob = 0
	$yJob = 0
	#EndRegion
	#Region Loop Pencarian Metal
	Do
 		$CariMetal = _ImageSearchArea( $ArrayImgFindMetal[$iMetal], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xMetal, $yMetal, 95)
 		$iMetal += 1
		$CountSearchMetal += 1
		If $iMetal = 4 Then $iMetal = 0
		Sleep(Int($DelaySearchImage))
		PesanKonsol("Searching Metal", "Count: " & $CountSearchMetal & " Using Image: " & $iMetal + 1)
		$LimitFindMetal = IniRead($hFileSetting, "SettingAplikasi", "LimitFindMetal", 100)
		If $CountSearchMetal = Int($LimitFindMetal) Then
			PesanKonsol("Maksimum Stack Reach", "Switch")
			CommandCariCrystal()
		EndIf
	Until $CariMetal = 1
	#EndRegion
	If $CariMetal = 1 Then
		Sleep(100)
		PesanKonsol("Metal Found", "Using Image: " & $iMetal & "; PosX: " & $xMetal & " PosY: " & $yMetal)
		Sleep(Int($DelayGetJob))
		MouseClick( "primary", $xMetal + $UPosXMetal, $yMetal + $UPosYMetal, 1, 8)
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
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xMetal + $UPosXMetal, $yMetal + $UPosYMetal, 1, 8)
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
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xMetal + $UPosXMetal, $yMetal + $UPosYMetal, 1, 8)
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
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xMetal + $UPosXMetal, $yMetal + $UPosYMetal, 1, 8)
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
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xMetal + $UPosXMetal, $yMetal + $UPosYMetal, 1, 8)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMetal = 1
		EndSwitch
		If $PickJobMetal = 1 Then
			Sleep(Int($DelayPickJob))
			MouseClick( "primary", $xJob, $yJob, 1, 10)
			PesanKonsol("Job Found @Count: " & $CountJob, "Start Pick Job: " & $GetJobMetal)
			Sleep(200)
			MouseMove( 105, 404, 7)
;~ 			$MetalFound += 1
			$xMetal = 0
			$yMetal = 0
			$xJob = 0
			$yJob = 0
		EndIf
	EndIf
	CommandCariMetal()
EndFunc

Func CommandCariCrystal()
	#Region Deklarasi
	$iCrystal = 0
	$xCrystal = 0
	$yCrystal = 0
	$CountSearchCrystal = 0
	Local $CrystalFound = 0
	$CountJob = 0
	$xJob = 0
	$yJob = 0
	#EndRegion
	#Region Loop Cari Crystal
	Do
		If $boolSearchArea = 1 Then
			$CariCrystal = _ImageSearchArea( $ArrayImgFindCrystal[$iCrystal], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xCrystal, $yCrystal, 70)
		Else
			$CariCrystal = _ImageSearch( $ArrayImgFindCrystal[$iCrystal], 1, $xCrystal, $yCrystal, 70)
		EndIf
		$iCrystal += 1
		$CountSearchCrystal += 1
		If $iCrystal = 4 Then $iCrystal = 0
		Sleep(Int($DelaySearchImage))
		PesanKonsol( "Searching Crsytal", "Count: " & $CountSearchCrystal & " Using Image: " & $iCrystal)
		If $CountSearchCrystal = Int($LimitFindCrystal) Then
			PesanKonsol("Maksimum Stack Reach", "Switch Searching Crystal To Scroll")
			CommandCariPlank()
		EndIf
	Until $CariCrystal = 1
	#EndRegion

	If $CariCrystal = 1 Then
		Sleep(100)
		PesanKonsol("Crystal Found", "Using Image: " & $iCrystal & "; PosX: " & $xCrystal & " PosY: " & $yCrystal)
		Sleep(Int($DelayGetJob))
		MouseClick("primary", $xCrystal + $UPosXCrystal, $yCrystal + $UPosYCrystal, 1, 8)
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
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("primary", $xCrystal + $UPosXCrystal, $yCrystal + $UPosYCrystal, 1, 8)
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
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("primary", $xCrystal + $UPosXCrystal, $yCrystal + $UPosYCrystal, 1, 8)
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
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("primary", $xCrystal + $UPosXCrystal, $yCrystal + $UPosYCrystal, 1, 8)
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
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("primary", $xCrystal + $UPosXCrystal, $yCrystal + $UPosYCrystal, 1, 8)
						$CountJob = 0
					EndIf
				Until $PickJobCrystal = 1
		EndSwitch
		If $PickJobCrystal = 1 Then
			Sleep(Int($DelayPickRes))
			MouseClick("primary", $xJob, $yJob, 1, 10)
			PesanKonsol("Job Found @Count: " & $CountJob, "Start Pick Job: " &$GetJobCrystal)
			Sleep(200)
			MouseMove(105, 404, 7)
;~ 			$CrystalFound += 1
			$xCrystal = 0
			$yCrystal = 0
			$xJob = 0
			$yJob = 0
		EndIf
	Endif
	CommandCariCrystal()
EndFunc

Func CommandCariPlank()
	#Region Deklarasi
	$xPlank = 0
	$yPlank = 0
	$iPlank = 0
	$CountSearchPlank = 0
	$CountJob = 0
	Local $PlankFound = 0
	$xJob = 0
	$yJob = 0
	#EndRegion
	#Region Cari Plank
	Do
		If $boolSearchArea = 1 Then
			$CariPlank = _ImageSearchArea( $ArrayImgFindPlank[$iPlank], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xPlank, $yPlank, 70)
		Else
			$CariMetal = _ImageSearch( $ArrayImgFindPlank[$iPlank], 1, $xPlank, $yPlank, 70)
		EndIf
		$iPlank += 1
		$CountSearchPlank += 1
		If $iPlank = 4 Then $iPlank = 0
		Sleep(Int($DelaySearchImage))
		PesanKonsol("Searching Plank", "Count: " & $CountSearchPlank & " Using Image: " & $iPlank)
		$LimitFindPlank =
		If $CountSearchPlank = Int($LimitFindPlank) Then
			PesanKonsol("Maksimum Stack Reach", "Switch")
			CommandCariMarble()
		EndIf
	Until $CariPlank = 1
	#EndRegion

	If $CariPlank = 1 Then
		Sleep(100)
		PesanKonsol("Plank Found", "Using Image: " & $iPlank & "; PosX: " & $xPlank & " PosY: " & $yPlank)
		Sleep(Int($DelayGetJob))
		MouseClick("primary", $xPlank + int($UPosXPlank), $yPlank + int($UPosYPlank), 1, 8)
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
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("primary", $xPlank + int($UPosXPlank), $yPlank + int($UPosYPlank), 1, 8)
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
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("primary", $xPlank + int($UPosXPlank), $yPlank + int($UPosYPlank), 1, 8)
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
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("primary", $xPlank + int($UPosXPlank), $yPlank + int($UPosYPlank), 1, 8)
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
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick("primary", $xPlank + int($UPosXPlank), $yPlank + int($UPosYPlank), 1, 8)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobPlank = 1
		EndSwitch
		If $PickJobPlank = 1 Then
			Sleep(Int($DelayPickRes))
			MouseClick( "primary", $xJob, $yJob, 1, 10)
			PesanKonsol("Job Found @Count: " & $CountJob, "Stack Pick Job: " & $GetJobPlank)
			Sleep(200)
			MouseMove( 105, 404, 7)
;~ 			$PlankFound += 1
			$xPlank = 0
			$yPlank = 0
			$xJob = 0
			$yJob = 0
		EndIf
	EndIf
	CommandCariPlank()
EndFunc

Func CommandCariMarble()
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
	Do
		If $boolSearchArea = 1 Then
			$CariMarble = _ImageSearchArea( $ArrayImgFindMarble[$iMarble], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xMarble, $yMarble, 70)
		Else
			$CariMarble = _ImageSearch( $ArrayImgFindMarble[$iMarble], 1, $xMarble, $yMarble, 70)
		EndIf
		Sleep(Int($DelaySearchImage))
		$iMarble += 1
		$CountSearchMarble += 1
		If $iMarble = 4 Then $iMarble = 0
		PesanKonsol("Searching Marble", "Count: " & $CountSearchMarble)
		If $CountSearchMarble = Int($LimitFindMarble) Then
			PesanKonsol("Maksimum Stack Reach", "Switch Searching Marble To Crystal")
			CommandCariScroll()
		EndIf
	Until $CariMarble = 1
	#EndRegion
	If $CariMarble = 1 Then
		Sleep(100)
		PesanKonsol("Marble Found", "Using Image: " & $iMarble & "; PosX: " & $xMarble & " PosY: " & $yMarble)
		Sleep(Int($DelayGetJob))
		MouseClick( "primary", $xMarble + $UPosXMarble, $yMarble + $UPosYMarble, 1, 8)
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
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xMarble + $UPosXMarble, $yMarble + $UPosYMarble, 1, 10)
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
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xMarble + $UPosXMarble, $yMarble + $UPosYMarble, 1, 10)
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
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xMarble + $UPosXMarble, $yMarble + $UPosYMarble, 1, 10)
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
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xMarble + $UPosXMarble, $yMarble + $UPosYMarble, 1, 10)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMarble = 1
		EndSwitch
		If $PickJobMarble = 1 Then
			Sleep(Int($DelayPickRes))
			MouseClick( "primary", $xJob, $yJob, 1, 10)
			PesanKonsol("Job Found @Count: " & $CountJob, "Start Pick Job: " & $GetJobMarble)
			Sleep(200)
			MouseMove(105, 404, 7)
;~ 			$MarbleFound += 1
			$xMarble = 0
			$yMarble = 0
			$xJob = 0
			$yJob = 0
		EndIf
	EndIf
	CommandCariMarble()
EndFunc

Func CommandCariScroll()
	$xScrol = 0
	$yScrol = 0
	$iScrol = 0
	$CountSearchScroll = 0
	$CountJob = 0
	$xJob = 0
	$yJob = 0
	Do
		$CariScroll = _ImageSearchArea( $ArrayImgScrollSilk[$iScrol], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xScrol, $yScrol, 75)
 		Sleep(Int($DelaySearchImage))
		$iScrol += 1
		If $iScrol = 1 Then $iScrol = 0
		$CountSearchScroll += 1
		PesanKonsol("Searching Scroll", "Count: " & $CountSearchScroll & " Using Image: " & $iSilk)
		$LimitFindScroll = IniRead($hFileSetting, "SettingAplikasi", "LimitFindScroll", 100)
		If $CountSearchScroll = Int($LimitFindScroll) Then
			CommandCariSilk()
		EndIf
	Until $CariScroll = 1

	If $CariScroll = 1 Then
		Sleep(100)
		PesanKonsol("Scroll Found", "Using Image: " & $iScrol & " PoxX: " & $xScrol & " PosY: " & $yScrol)
		Sleep(Int($DelayGetJob))
		MouseClick( "primary", $xScrol + $UPosXSilk, $yScrol + $UPosYSilk, 1, 10)
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
						MouseClick("primary", 103, 403, 1, 3)
						Sleep(300)
						MouseClick("primary", $xScrol + 4, $yScrol + 70, 1, 10)
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
						MouseClick("primary", 103, 403, 1, 3)
						Sleep(300)
						MouseClick("primary", $xScrol + 4, $yScrol + 70, 1, 10)
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
						MouseClick("primary", 103, 403, 1, 3)
						Sleep(300)
						MouseClick("primary", $xScrol + 4, $yScrol + 70, 1, 10)
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
						MouseClick("primary", 103, 403, 1, 3)
						Sleep(300)
						MouseClick("primary", $xScrol + 4, $yScrol + 70, 1, 10)
						$CountJob = 0
					EndIf
					PesanKonsol("Searching Job")
				Until $pickJobScroll = 1
		EndSwitch
		If $pickJobScroll = 1 Then
			Sleep(Int($DelayPickJob))
			MouseClick("primary", $xJob, $yJob, 1, 10)
			PesanKonsol("Executing Job")
			Sleep(200)
			MouseMove(105, 404, 6)
			$xScrol = 0
			$yScrol = 0
			$xJob = 0
			$yJob = 0
		EndIf
	EndIf
	CommandCariScroll()
EndFunc

Func CommandCariSilk()
	$iSilk = 0
	$CountSearchSilk = 0
	$xSilk = 0
	$ySilk = 0
	$CountJob = 0
	Do
		$CariSilk = _ImageSearchArea( $ArrayImgScroll[$iSilk], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xRes, $yRes, 75)
		$iSilk += 1
		If $iSilk = 1 Then $iSilk = 0
		$CountSearchSilk += 1
		Sleep(Int($DelaySearchImage))
		PesanKonsol("Searching Resource", "Count: " & $CountSearchSilk & " Using Image: " & $iSilk)
		$LimitFindSilk = IniRead($hFileSetting, "SettingAplikasi", "LimitFindSilk", 100)
		If $CountSearchSilk = Int($LimitFindSilk) Then
			PesanKonsol("Maximun Stack Silk Reach", "Switch Searchs to Resources")
			CommandCariResource()
		EndIf
	Until $CariSilk = 1
	If $CariSilk = 1 Then
		Sleep(100)
		PesanKonsol("Silk Found", "Using Image: " & $iSilk & " PosX: " & $xSilk & " PosY: " & $ySilk)
		Sleep(Int($DelayGetJob))
		MouseClick("primary", $ySilk + $UPosXSilk, $ySilk + $UPosYSilk, 1, 8)
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
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xSilk + $UPosXSilk, $ySilk + $UPosYSilk, 1, 8)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMetal = 1
			Case 2
				PesanKonsol("Searching Job For Silk", "Using Job: " & $GetJobSilk & "()")
				Do
					$PickJobSilk = _ImageSearch( $imgsrc38, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xSilk + $UPosXSilk, $ySilk + $UPosYSilk, 1, 8)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMetal = 1
			Case 3
				PesanKonsol("Searching Job For Silk", "Using Job: " & $GetJobSilk & "()")
				Do
					$PickJobSilk = _ImageSearch( $imgsrc39, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xSilk + $UPosXSilk, $ySilk + $UPosYSilk, 1, 8)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMetal = 1
			Case Else
				PesanKonsol("Searching Job For Silk", "Using Job: " & $GetJobSilk & "()")
				Do
					$PickJobSilk = _ImageSearch( $imgsrc37, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchImage))
					$CountJob += 1
					If $CountJob = 8 Then
						Sleep(200)
						MouseClick( "primary", 103, 404, 1, 3)
						PesanKonsol("Loop Pick Job", "Force Pick Job..." & " Count: " & $CountJob)
						Sleep(200)
						MouseClick( "primary", $xSilk + $UPosXSilk, $ySilk + $UPosYSilk, 1, 8)
						MouseMove(103, 404, 3)
						$CountJob = 0
					EndIf
				Until $PickJobMetal = 1
		EndSwitch
		If $GetJobSilk = 1 Then
			Sleep(Int($DelayPickJob))
			MouseClick( "primary", $xJob, $yJob, 1, 10)
			PesanKonsol("Job Found @Count: " & $CountJob, "Start Pick Job: " & $GetJobMetal)
			Sleep(200)
			MouseMove(105,404,7)
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
	Exit
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
		MouseClick("primary", $xCity, $yCity, 1, 10)
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
		MouseClick("primary", $xCity, $yCity, 1, 10)
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
		;MouseClick("primary", $xCity, $yCity, 1, 10)
	EndIf
	Sleep(800)
EndFunc

Func CommandSetTitle($tRes, $tGold, $tMetal, $tPlank, $tMarb, $tCry, $tSco, $tSlk,  $CurrTitle = "Elvenar AutoClick Log")
	Sleep(300)
	Local $AddTitle = " [R:" & $tres & "; G:" & $tGold & "; Mt:" & $tMetal & "; P:" & $tPlank & "; Ma:" & $tMarb & "; Cr:" & $tCry & "; Sc:" & $tSco & "; Sl:" & $tSlk & "]"
	Local $tSetTitle = $CurrTitle & $addTitle
;~ 	WinSetTitle( $CurrTitle, "", $tSetTitle)
	DllCall( "Kernel32.dll", "bool", "AllocConsole")
	_WinApi_SetConsoleTitle($tSetTitle)
	DllClose("Kernel32.dll")
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
		MouseClick( "primary", $xServer, $yServer, 1, 10)
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
	Exit 0
EndFunc

Func _WinApi_SetConsoleTitle($sTitle, $hDLL = "Kernel32.dll")
    Local $iRet = DllCall($hDLL, "bool", "SetConsoleTitle", "str", $sTitle)
    If $iRet[0] < 1 Then Return False
    Return True
EndFunc

