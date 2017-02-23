#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=IconRes.ico
#AutoIt3Wrapper_Outfile=MainScript V.22.exe
#AutoIt3Wrapper_Outfile_x64=MainScript V.22_X64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_Comment=Elvenar AutoClick
#AutoIt3Wrapper_Res_Description=Elvenar AutoClicker
#AutoIt3Wrapper_Res_Fileversion=17.2.23.6
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

Local $LimitSettingFindResource = IniRead( $hfileSetting, "SettingAplikasi", "LimitFindResource", 400)
Local $LimitSettingFindGold = IniRead( $hfilesetting, "SettingAplikasi", "LimitFindGold", 90)
Local $LimitFindMetal = IniRead( $hfilesetting, "SettingAplikasi", "LimitFindMetal", 100)
Local $LimitFindPlank = IniRead( $hfileSetting, "SettingAplikasi", "LimitFindPlank", 100)
Local $LimitFindMarble = IniRead( $hfileSetting, "SettingAplikasi", "LimitFindMarble", 100)
Local $LimitFindCrystal = IniRead( $hfileSetting, "SettingAplikasi", "LimitFindCrystal", 100)
Local $LimitFindScroll = IniRead( $hfileSetting, "SettingAplikasi", "LimitFindScroll", 100)
Local $LimitFindSilk = IniRead( $hfileSetting, "SettingAplikasi", "LimitFindSilk", 100)

Local $boolSearchArea = IniRead( $hfileSetting, "SettingAplikasi", "SearchArea", 1)
Local $SearchAreaTop = IniRead( $hfilesetting, "SettingAplikasi", "TopX", 176)
Local $SearchAreaLeft = IniRead( $hfilesetting, "SettingAplikasi", "TopY", 206)
Local $SearchAreaRight = IniRead( $hfilesetting, "SettingAplikasi", "wRight", 1298)
Local $SearchAreaBottom = IniRead( $hfilesetting, "SettingAplikasi", "hBottom", 730)

;Set Posisi Window
Local $StartPointerPosition = IniRead( $hfilesetting, "SettingAplikasi", "PointerWin", 0)
Local $DelaySearchJob = IniRead( $hfilesetting, "DelayTimingPickJob", "SearchJob", 100)
Local $DelayPickRes = IniRead( $hfilesetting, "DelayTimingPickJob","Resource", 800)
Local $DelayPickJob = IniRead( $hfilesetting, "DelayTimingPickJob", "PickJob", 800)

;Maks Stack Objek
Local $ResidenceStack = IniRead( $hfilesetting, "TotalBuilding", "Residence", 19)
Local $ResourceStack = IniRead( $hfileSetting, "TotalBuilding", "WorkShop", 6)
Local $MetalStack = IniRead( $hfileSetting, "TotalBuilding", "Steel", 5)
Local $PlankStack = IniRead( $hfilesetting, "TotalBuilding", "Plank", 4)
Local $MarbleStack = IniRead( $hfileSetting, "TotalBuilding", "Marble", 5)
Local $CrystalStack = IniRead( $hfilesetting, "TotalBuilding", "Crystal", 2)
Local $ScrollStack = IniRead( $hfilesetting, "TotalBuilding", "Scrolls", 1)
Local $SilkStack = IniRead( $hfilesetting, "TotalBuilding", "Silk", 1)
Local $ReadServer = IniRead( $hfilesetting, "SettingAplikasi", "Server1", "Arendyll")
Local $multiServer = IniRead( $hfileSetting, "SettingAplikasi", "multiserver", 0)

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
Global $UPosXRes = IniRead( $hfilesetting, "CoordinateUserPick", "PickXResource", 8)
Global $UPosYRes = IniRead( $hfileSetting, "CoordinateUserPick", "PickYResource", 65)
Global $UPosXGold = IniRead( $hfileSetting, "CoordinateUserPick", "PickXGold", 10)
Global $UPosYGold = IniRead( $hfileSetting, "CoordinateUserPick", "PickYGold", 70)
Global $UPosXMetal = IniRead( $hfileSetting, "CoordinateUserPick", "PickXMetal", 6)
Global $UPosYMetal = IniRead( $hfileSetting, "CoordinateUserPick", "PickYMetal", 75)
Global $UPosXPlank = IniRead( $hfileSetting, "CoordinateUserPick", "PickXPlank", 10)
Global $UPosYPlank = IniRead( $hfileSetting, "CoordinateUserPick", "PickYPlank", 70)
Global $UPosXMarble = IniRead( $hfileSetting, "CoordinateUserPick", "PickXMarble", 4)
Global $UPosYMarble = IniRead( $hfileSetting, "CoordinateUserPick", "PickYMarble", 70)
Global $UPosXCrystal = IniRead( $hfileSetting, "CoordinateUserPick", "PickXCrystal", 5)
Global $UPosYCrystal = IniRead( $hfileSetting, "CoordinateUserPick", "PickYCrystal", 75)
Global $UPosXScroll = IniRead( $hfileSetting, "CoordinateUserPick", "PickX", 0)
Global $UPosYScroll = IniRead( $hfileSetting, "CoordinateUserPick", "PickY", 60)
;~ Global $UPosX = IniRead( $hfileSetting, "CoordinateUserPick", "PickX", 0)
;~ Global $UPosY = IniRead( $hfileSetting, "CoordinateUserPick", "PickY", 60)

#EndRegion

#Region Hotkey
HotKeySet("^+p", "TogglePause")
HotKeySet("^+q", "CommandExit")
HotKeySet("{PGUP}", "CommandCariResource")
HotKeySet( "^+{F7}", "CommandCariGold")
HotKeySet("{F6}", "CenteringScreen")
HotKeySet("{HOME}", "CommandSetPosisiKota")
HotKeySet("^+{F9}", "CommandCariCrystal")
HotKeySet("^+{F8}", "CommandCariMetal")
HotKeySet("^+{F10}", "CommandCariPlank")
HotKeySet("^+{F11}", "CommandCariMarble")
HotKeySet( "^+K", "CommandStartServer")
HotKeySet("^+r", "CommandRestart")
#EndRegion

DllCall( "Kernel32.dll", "bool", "AllocConsole")
_WinApi_SetConsoleTitle("Elvenar AutoClick Log")
WinSetOnTop( "Elvenar AutoClick Log", "", 1)
WinSetTrans( "Elvenar AutoClick Log", "", 200)
WinMove( "Elvenar AutoClick Log", "", 720, 4, 640, 95, 3)
DllClose("Kernel32.dll")

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
	Local $MetalFound = 0
	$CountSearchResc = 0
	$CariResource = 0
	$xJob = 0
	$yJob = 0
	$CountJob = 0
	#EndRegion
	#Region Loop Pencarian Image
	Do
		If	$boolSearchArea = 1 Then
			$CariResource = _ImageSearchArea( $ArrayImgResc[$iResc], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xRes, $yRes, 90)
		Else
			$CariResource = _ImageSearch( $ArrayImgResc[$iResc], 1, $xRes, $yRes, 90)
		EndIf
		$iResc += 1
		If $iResc = 4 Then $iResc = 0
		$CountSearchResc += 1
		Sleep(Int($DelaySearchJob))
		PesanKonsol("Searching Resource", "Count: " & $CountSearchResc & " Using Image: " & ($iResc + 1))
		;Total Limit Searching Resource dari File Config
		If $CountSearchResc = Int($LimitSettingFindResource) Then
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
		PesanKonsol("Resource Found!", " Using Image: " & $iResc & "; PosX: " & $xRes & " PosY: " & $yRes)
		Sleep(200)
		MouseClick( "primary", $xRes + $UPosXRes, $yRes + $UPosYRes, 1, 8)
		$TotalPickResources += 1
		MouseMove(105, 403, 3)
		PesanKonsol("Collecting Resource", "PosX: " & $xRes & " PosY: " & $yRes & " Total Resources Collected: " & $TotalPickResources)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)

		$GetJobFromConfig = IniRead( $hfileSetting, "SetupJob", "Resource", 1)
		$PilihanJob = 0
		Switch $GetJobFromConfig
			Case 1 ; 5min
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobFromConfig & "(Beverage)")
				Do
					$PilihanJob = _ImageSearch( $imgsrc5, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchJob))
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
				Until $PilihanJob = 1

			Case 2 ; 15min
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobFromConfig & "(Simple Tools)")
				Do
					$PilihanJob = _ImageSearch( $imgsrc6, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchJob))
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
				Until $PilihanJob = 1

			Case 3 ; 1hr
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobFromConfig & "(Bread)")
				Do
					$PilihanJob = _ImageSearch( $imgsrc7, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchJob))
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
				Until $PilihanJob = 1

			Case 4 ; 3hr
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobFromConfig & "(Advanced Tools)")
				Do
					$PilihanJob = _ImageSearch( $imgsrc8, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchJob))
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
				Until $PilihanJob = 1

			Case 5 ; 9hr
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobFromConfig & "(Basket Of Groceries)")
				Do
					$PilihanJob = _ImageSearch( $imgsrc9, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchJob))
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
				Until $PilihanJob = 1

			Case 6 ; 1day
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobFromConfig & "(Toolbox)")
				Do
					$PilihanJob = _ImageSearch( $imgsrc10, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchJob))
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
				Until $PilihanJob = 1

			Case Else ; Jika di Settingan tidak ada Nilai
				PesanKonsol("Searching Job For Resource", "Using Job: " & $GetJobFromConfig & "(Beverage)")
				Do
					$PilihanJob = _ImageSearch( $imgsrc5, 1, $xJob, $yJob, 60)
					Sleep(int($DelaySearchJob))
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
				Until $PilihanJob = 1

		EndSwitch

		If $PilihanJob = 1 Then
			Sleep(Int($DelayPickRes))
			MouseClick( "primary", $xJob, $yJob, 1, 10)
			PesanKonsol("Job Found @Count: " & $CountJob, "Start Pick Job: " & $GetJobFromConfig)
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
		Sleep(100)
		$iGold += 1
		PesanKonsol( "Searching Gold", "Count: " & $CountSearchGold + 1 & " Using Image: " & $iGold)
		If $iGold = 3 Then $iGold = 0
		$CountSearchGold += 1
		If $CountSearchGold = Int($LimitSettingFindGold) Then
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
		PesanKonsol("Gold Found", "PosX: " & $xGold & " PosY: " & $yGold)
		Sleep(100)
		MouseClick( "primary", $xGold + $UPosXGold, $yGold + $UPosYGold, 1, 8)
		$TotalPickGolds += 1
		Sleep(100)
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
		If $boolSearchArea = 1 Then
			$CariMetal = _ImageSearchArea( $ArrayImgFindMetal[$iMetal], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xMetal, $yMetal, 90)
		Else
			$CariMetal = _ImageSearch( $ArrayImgFindMetal[$iMetal], 1, $xMetal, $yMetal, 90)
		EndIf
		$iMetal += 1
		$CountSearchMetal += 1
		If $iMetal = 4 Then $iMetal = 0
		Sleep(Int($DelaySearchJob))
		PesanKonsol("Searching Metal", "Count: " & $CountSearchMetal & " Using Image: " & $iMetal + 1)
		If $CountSearchMetal = Int($LimitFindMetal) Then
			PesanKonsol("Maksimum Stack Reach", "Switch")
			CommandCariPlank()
		EndIf
	Until $CariMetal = 1
	#EndRegion
	If $CariMetal = 1 Then
		Sleep(100)
		PesanKonsol("Metal Found", "Using Image: " & $iMetal & "; PosX: " & $xMetal & " PosY: " & $yMetal)
		Sleep(200)
		MouseClick( "primary", $xMetal + $UPosXMetal, $yMetal + $UPosYMetal, 1, 8)
		$TotalPickMetals += 1
;~ 		Sleep(200)
		MouseMove( 105, 404, 5)
		PesanKonsol( "Collecting Metal", "PosX: " & $xMetal & " PosY: " & $yMetal & " Total Collected Metals: " & $TotalPickMetals)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		$CountSearchMetal = 0
		$GetJobMetal = IniRead( $hfileSetting, "SetupJob", "Metal", 1)
		$PickJobMetal = 0
		Switch $GetJobMetal
			Case 1
				PesanKonsol( "Searching Job For Metal", "Using Job: " & $GetJobMetal & "(Precious Ring)")
				Do
					$PickJobMetal = _ImageSearch( $imgsrc11, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchJob))
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
					Sleep(Int($DelaySearchJob))
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
					Sleep(Int($DelaySearchJob))
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
					Sleep(Int($DelaySearchJob))
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
			Sleep(Int($DelayPickRes))
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
		Sleep(Int($DelaySearchJob))
		PesanKonsol("Searching Plank", "Count: " & $CountSearchPlank & " Using Image: " & $iPlank)
		If $CountSearchPlank = Int($LimitFindPlank) Then
			PesanKonsol("Maksimum Stack Reach", "Switch")
			CommandCariMarble()
		EndIf
	Until $CariPlank = 1
	#EndRegion

	If $CariPlank = 1 Then
		Sleep(100)
		PesanKonsol("Plank Found", "Using Image: " & $iPlank & "; PosX: " & $xPlank & " PosY: " & $yPlank)
		Sleep(200)
		MouseClick("primary", $xPlank + int($UPosXPlank), $yPlank + int($UPosYPlank), 1, 8)
		$TotalPickPlanks += 1
		MouseMove(105, 403, 3)
		PesanKonsol("Collecting Plank", "PosX: " & $xPlank & " PosY: " & $yPlank & " Total Planks Collected: " & $TotalPickPlanks)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		$CountSearchPlank = 0
		$GetJobPlank = IniRead( $hfileSetting, "SetupJob", "Plank", 1)
		$PickJobPlank = 0
		Switch $GetJobPlank
			Case 1
				PesanKonsol("Searching Job", "Using Job: " & $GetJobPlank & "(Beverage)")
				Do
					$PickJobPlank = _ImageSearch( $imgsrc11, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchJob))
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
					Sleep(Int($DelaySearchJob))
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
					Sleep(Int($DelaySearchJob))
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
					Sleep(Int($DelaySearchJob))
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
		Sleep(100)
		$iMarble += 1
		$CountSearchMarble += 1
		If $iMarble = 4 Then $iMarble = 0
		PesanKonsol("Searching Marble", "Count: " & $CountSearchMarble)
		If $CountSearchMarble = Int($LimitFindMarble) Then
			PesanKonsol("Maksimum Stack Reach", "Switch Searching Marble To Crystal")
			CommandCariCrystal()
		EndIf
	Until $CariMarble = 1
	#EndRegion
	If $CariMarble = 1 Then
		Sleep(100)
		PesanKonsol("Marble Found", "Using Image: " & $iMarble & "; PosX: " & $xMarble & " PosY: " & $yMarble)
		Sleep(200)
		MouseClick( "primary", $xMarble + $UPosXMarble, $yMarble + $UPosYMarble, 1, 8)
		$TotalPickMarbles += 1
		MouseMove(105, 404, 3)
		PesanKonsol("Collecting Marble", "PosX: " & $xMarble & " PosY: " & $yMarble & " Total Collected Marbles: " & $TotalPickMarbles)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		$CountSearchMarble = 0
		$GetJobMarble = IniRead( $hfilesetting, "SetupJob", "Marble", 1)
		$PickJobMarble = 0
		Switch $GetJobMarble
			Case 1
				PesanKonsol("Searching Job Marble", "Using Job: " & $GetJobMarble & "(Beverage)")
				Do
					$PickJobMarble = _ImageSearch( $imgsrc11, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchJob))
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
		Sleep(Int($DelaySearchJob))
		PesanKonsol( "Searching Crsytal", "Count: " & $CountSearchCrystal & " Using Image: " & $iCrystal)
		If $CountSearchCrystal = Int($LimitFindCrystal) Then
			PesanKonsol("Maksimum Stack Reach", "Switch Searching Crystal To Scroll")
			CommandCariScroll()
		EndIf
	Until $CariCrystal = 1
	#EndRegion

	If $CariCrystal = 1 Then
		Sleep(100)
		PesanKonsol("Crystal Found", "Using Image: " & $iCrystal & "; PosX: " & $xCrystal & " PosY: " & $yCrystal)
		Sleep(200)
		MouseClick("primary", $xCrystal + $UPosXCrystal, $yCrystal + $UPosYCrystal, 1, 8)
		$TotalPickCrystals += 1
		MouseMove(105, 404, 3)
		PesanKonsol("Collecting Crsytal", "PosX: " & $xCrystal & " PosY: " & $yCrystal & " Total Collected Crystals: " & $TotalPickCrystals)
		CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		$CountSearchCrystal = 0
		$GetJobCrystal = IniRead( $hfilesetting, "SetupJob", "Crystal", 1)
		$PickJobCrystal = 0
		Switch $GetJobCrystal
			Case 1
				PesanKonsol("Searching Job Crystal", "Using Job: " & $GetJobCrystal & "(Small Flacon)")
				Do
					$PickJobCrystal = _ImageSearch( $imgsrc37, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchJob))
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
					Sleep(Int($DelaySearchJob))
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
					Sleep(Int($DelaySearchJob))
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
					Sleep(Int($DelaySearchJob))
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

Func CommandCariScroll()
	$xScrol = 0
	$yScrol = 0
	$iScrol = 0
	$CountSearchScroll = 0
	$CountJob = 0
	$xJob = 0
	$yJob = 0
	$NumScroll = 0
	Do
		If $boolSearchArea = 1 Then
			$CariScroll = _ImageSearchArea( $ArrayImgScrollSilk[$iScrol], 1, Int($SearchAreaTop), Int($SearchAreaLeft), Int($SearchAreaRight), Int($SearchAreaBottom), $xScrol, $yScrol, 70)
		Else
			$CariScroll = _ImageSearch( $ArrayImgScrollSilk[$iScrol], 1, $iScrol, $yScrol, 70)
		EndIf
		Sleep(100)
		$iScrol += 1
		If $iScrol = 4 Then $iScrol = 0
		$CountSearchScroll += 1
		$NumScroll = $iScrol
		PesanKonsol("Searching Scroll", "Counting: " & $CountSearchScroll)
		If $CountSearchScroll = 80 Then
			CommandCariResource()
		EndIf
	Until $CariScroll = 1

	If $CariScroll = 1 Then
		Sleep(100)
		PesanKonsol("Scroll Found")
		Sleep(200)
		MouseClick( "primary", $xScrol + 4, $yScrol + 70, 1, 10)
		Switch $NumScroll
			Case 1, 2
				$TotalPickScrolls += 1
				CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
			Case 3, 4
				$TotalPickSilks += 1
				CommandSetTitle($TotalPickResources , $TotalPickGolds, $TotalPickMetals, $TotalPickPlanks, $TotalPickMarbles, $TotalPickCrystals, $TotalPickScrolls, $TotalPickSilks)
		EndSwitch
		If $NumScroll = 0 Then
			ToolTip( "0",0,0,"Using If")
		ElseIf $NumScroll = 1 Then
			ToolTip( "1",0,0,"Using If")
		ElseIf $NumScroll = 2 Then
			ToolTip( "2",0,0,"Using If")
		ElseIf $NumScroll = 3 Then
			ToolTip( "3",0,0,"Using If")
		ElseIf $NumScroll = 4 Then
			ToolTip( "4",0,0,"Using If")
		EndIf

		Select
			Case $NumScroll = 0
			ToolTip( "0",0,0,"Using Select Case")
			Case $NumScroll = 1
			ToolTip( "1",0,0,"Using Select Case")
			Case $NumScroll = 2
			ToolTip( "2",0,0,"Using Select Case")
			Case $NumScroll = 3
			ToolTip( "3",0,0,"Using Select Case")
			Case $NumScroll = 4
			ToolTip( "4",0,0,"Using Select Case")
		EndSelect

		$GetJobScroll= Iniread( $hfilesetting, "SetupJob", "Scroll", 1)
		$pickJobScroll = 0
		Switch $GetJobScroll
			Case 1
				Do
					$pickJobScroll = _ImageSearch( $imgsrc11, 1, $xJob, $yJob, 65)
					Sleep(Int($DelaySearchJob))
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
					Sleep(Int($DelaySearchJob))
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
					Sleep(Int($DelaySearchJob))
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
					Sleep(Int($DelaySearchJob))
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
			Sleep(200)
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



