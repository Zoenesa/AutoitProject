#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=IconRes.ico
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Change2CUI=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "modul\fileglobal.au3"
#include <File.au3>
#include <Date.au3>
#include "modul\Console.au3"

Local $Paused, $GetJob
Local $ResourceStack, $MetalStack, $CrystalStack, $ElixirStack, $PlankStack, $MarbleStack, $ScrollStack, $SilkStack, $DustStack, $GemsStack
Local $hfileSetting = @ScriptDir & "\Config\Resources.ini"

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


DllCall( "Kernel32.dll", "bool", "AllocConsole")
_WinApi_SetConsoleTitle("Elvenar AutoClick Log")
WinSetOnTop( "Elvenar AutoClick Log", "", 1)
WinSetTrans( "Elvenar AutoClick Log", "", 200)
WinMove( "Elvenar AutoClick Log", "", 1, 15, 797, 105, 3)
DllClose("Kernel32.dll")

Main()

Func Main()
	$MetalSetting = @ScriptDir & "\Config\Resources.ini"
	CommandPencarian(1, 20,$MetalSetting, 0, 0, @DesktopWidth, @DesktopHeight, 95, 5, 75)
EndFunc

Func PesanKonsol( $refMsg, $refComment = " ", $refColor = 1)
;~ 	ConsoleWrite( "[" & @YEAR & ":" & @MON & ":" & @MDAY & _
;~ 	":" & @HOUR & ":" & @MIN & ":" & @SEC & "]" & _
;~ 	$refMsg & "; " & $refComment & @CRLF)
	Switch $refColor
		Case 1 ;Searching
			Cout("[" & @YEAR & "/" & @MON & "/" & @MDAY & _
			"-" & @HOUR & ":" & @MIN & ":" & @SEC & "]" & _
			$refMsg & "; " & $refComment & @CRLF, $FOREGROUND_GREEN)
		Case 2	;Read Setting
			Cout("[" & @YEAR & "/" & @MON & "/" & @MDAY & _
			"-" & @HOUR & ":" & @MIN & ":" & @SEC & "]" & _
			$refMsg & "; " & $refComment & @CRLF, $FOREGROUND_RED)
		Case 3	;Searching Found
			Cout("[" & @YEAR & "/" & @MON & "/" & @MDAY & _
			"-" & @HOUR & ":" & @MIN & ":" & @SEC & "]" & _
			$refMsg & "; " & $refComment & @CRLF, $FOREGROUND_BLUE)
	EndSwitch
EndFunc

Func CommandSetTitle($tRes, $tGold, $tMetal, $tPlank, $tMarb, $tCry, $tSco, $tSlk, $tElx, $tDst, $tGem, $CurrTitle = "Elvenar AutoClick Log")
	Sleep(300)
	Local $AddTitle = " [R:" & $tres & "|G:" & $tGold & "|Mt:" & $tMetal & "|P:" & $tPlank & "|Ma:" & $tMarb & "|Cr:" & $tCry & "|Sc:" & $tSco & "|Sl:" & $tSlk & "|El:" & $tElx & "|Ds:" & $tDst & "|Gm:" & $tGem & "]"
	$tSetTitle = $CurrTitle & $addTitle
	DllCall( "Kernel32.dll", "bool", "AllocConsole")
	_WinApi_SetConsoleTitle($tSetTitle)
	DllClose("Kernel32.dll")
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

Func ReadSetting($FileSetting, $iSection, $iKey, $iDefault)
	Return IniRead($FileSetting, $iSection, $iKey, $iDefault)
EndFunc

Local $StatTimer, $TimerWait, $Pencarian, $Stack, $iNum, $refX, $refY, $JobX, $JobY, $NumCase, $FindImages

Func CommandPencarian($EnumSearch, $TimerWait, $FileSetting, $oX, $oY, $Right, $Bottom, $Toleransi, $UserPickX, $UserPickY)
	$StatTimer = TimerInit()
;~ 	$TimerWait = ReadSetting( $hfileSetting, "MetalStat", "TimerWait", 30)
	$TimerWait = $TimerWait * 1000
	$Pencarian = 0
	$Stack = 0
	$iNum = 1
	$refX = 0
	$refY = 0
	$JobX = 0
	$JobY = 0
	$NumCase = 0

	While TimerDiff($StatTimer) < $TimerWait
		Switch $EnumSearch
			Case 1 ;Metal
				$NumCase = 1
				PesanKonsol("Searching Resource","Metals")
				#Region Read Settings Metal Stat
					$GetJob = ReadSetting( $hfileSetting, "MetalStat", "PickJob", 1)
					$UserPickX = ReadSetting( $hfileSetting, "MetalStat", "UserPickX", 5)
					$UserPickY = ReadSetting( $hfileSetting, "MetalStat", "UserPickY", 75)
					$Toleransi = ReadSetting( $hfileSetting, "MetalStat", "Tolerance", 75)
					$oX = ReadSetting( $hfileSetting, "MetalStat", "PosX", 100)
					$oY = ReadSetting( $hfileSetting, "MetalStat", "PosY", 100)
					$Right = ReadSetting( $hfileSetting, "MetalStat", "wRight", 1018)
					$Bottom = ReadSetting( $hfileSetting, "MetalStat", "hBottom", 628)
				#EndRegion
				Do
					PesanKonsol("Pencarian","Metals")
					$Pencarian = _ImageSearchArea($ArrayImgFindMetal[$iNum], 1, $oX, $oY, $Right, $Bottom, $refX, $refY, $Toleransi)
					$iNum += 1
					If $iNum = 4 Then $iNum = 0
				Until $Pencarian = 1
			Case 2	;Crystal
				$NumCase = 2
				PesanKonsol("Searching Resource","Crystals")
				#Region Read Settings Crystal Stat
					$GetJob = ReadSetting( $hfileSetting, "CrystalStat", "PickJob", 1)
					$UserPickX = ReadSetting( $hfileSetting, "CrystalStat", "UserPickX", 5)
					$UserPickY = ReadSetting( $hfileSetting, "CrystalStat", "UserPickY", 75)
					$Toleransi = ReadSetting( $hfileSetting, "CrystalStat", "Tolerance", 75)
					$oX = ReadSetting( $hfileSetting, "CrystalStat", "PosX", 100)
					$oY = ReadSetting( $hfileSetting, "CrystalStat", "PosY", 100)
					$Right = ReadSetting( $hfileSetting, "CrystalStat", "wRight", 1018)
					$Bottom = ReadSetting( $hfileSetting, "CrystalStat", "hBottom", 628)
				#EndRegion
				Do
					$Pencarian = _ImageSearchArea($ArrayImgFindCrystal[$iNum - 1], 1, $oX, $oY, $Right, $Bottom, $refX, $refY, $Toleransi)
					$iNum += 1
					If $iNum = 4 Then $iNum = 0
				Until $Pencarian = 1
			Case 3
				$NumCase = 3
				PesanKonsol("Searching Resource","Elixir")
				#Region Read Settings Elixir Stat
					$GetJob = ReadSetting( $hfileSetting, "ElixirStat", "PickJob", 1)
					$UserPickX = ReadSetting( $hfileSetting, "ElixirStat", "UserPickX", 5)
					$UserPickY = ReadSetting( $hfileSetting, "ElixirStat", "UserPickY", 75)
					$Toleransi = ReadSetting( $hfileSetting, "ElixirStat", "Tolerance", 75)
					$oX = ReadSetting( $hfileSetting, "ElixirStat", "PosX", 100)
					$oY = ReadSetting( $hfileSetting, "ElixirStat", "PosY", 100)
					$Right = ReadSetting( $hfileSetting, "ElixirStat", "wRight", 1018)
					$Bottom = ReadSetting( $hfileSetting, "ElixirStat", "hBottom", 628)
				#EndRegion
		EndSwitch

		Sleep(200)

		If $Pencarian = 1 Then
			MouseClick("left", $refX + $UserPickX, $refY + $UserPickY, 1, 7)
			Sleep(200)
			MouseMove(100,395,3)
			Sleep(600)

			Switch $EnumSearch ;If Found Stack ++
				Case 1	;Metal Stack
					$MetalStack += 1
					PesanKonsol("Found Metal Completed Production", "X:" & $refX & "|Y:" & $refY & "|Total Metals Found:" & $MetalStack)
				Case 2	;Crystal Stack
					$CrystalStack += 1
					PesanKonsol("Found Crystal Completed Production", "X:" & $refX & "|Y:" & $refY & "|Total Crystals Found:" & $CrystalStack)
				Case 3	;Elixir Stack
					$ElixirStack += 1
					PesanKonsol("Found Elixir Completed Production", "X:" & $refX & "|Y:" & $refY & "|Total Elixirs Found:" & $ElixirStack)
				Case 4	;Plank Stack
					$PlankStack += 1
					PesanKonsol("Found Plank Completed Production", "X:" & $refX & "|Y:" & $refY & "|Total Planks Found:" & $PlankStack)
				Case 5	;Marble Stack
					$MarbleStack += 1
					PesanKonsol("Found Marble Completed Production", "X:" & $refX & "|Y:" & $refY & "|Total Marbles Found:" & $MarbleStack)
				Case 6	;Scroll Stack
					$ScrollStack += 1
					PesanKonsol("Found Scroll Completed Production", "X:" & $refX & "|Y:" & $refY & "|Total Scrolls Found:" & $ScrollStack)
				Case 7	;Silk Stack
					$SilkStack += 1
					PesanKonsol("Found Silk Completed Production", "X:" & $refX & "|Y:" & $refY & "|Total Silks Found:" & $SilkStack)
				Case 8	;Magic Dust Stack
					$DustStack += 1
					PesanKonsol("Found Magic Dust Completed Production", "X:" & $refX & "|Y:" & $refY & "|Total Magic Dust Found:" & $DustStack)
				Case 9	;Gems Stack
					$GemsStack += 1
					PesanKonsol("Found Gem Completed Production", "X:" & $refX & "|Y:" & $refY & "|Total Gems Found:" & $GemsStack)
			EndSwitch

			MouseClick("left", $refX + $UserPickX, $refY + $UserPickY, 1, 7)

			Sleep(200)
			; Searching Ready Production
			Switch $GetJob
				Case 1
					PesanKonsol("Searching Ready For Production", "")
					Do
						$Production = _ImageSearch( $imgsrc11, 1, $JobX, $JobY, 65)
					Until $Production = 1
					If $Production = 1 Then
						MouseClick("left", $JobX, $JobY, 1, 7)
						Sleep(200)
						MouseMove(100,395,3)
					EndIf
				Case 2
					Do
						$Production = _ImageSearch( $imgsrc38, 1, $JobX, $JobY, 65)
					Until $Production = 1
					If $Production = 1 Then
						MouseClick("left", $JobX, $JobY, 1, 7)
						Sleep(200)
						MouseMove(100,395,3)
					EndIf
				Case Else
					Do
						$Production = _ImageSearch( $imgsrc11, 1, $JobX, $JobY, 65)
					Until $Production = 1
					If $Production = 1 Then
						MouseClick("left", $JobX, $JobY, 1, 7)
						Sleep(200)
						MouseMove(100,395,3)
					EndIf
			EndSwitch
			return 1
		EndIf
	WEnd
EndFunc

Func SearchResource($TimerWait, $Init, $UserPickX, $UserPickY, $tolerance)
	$TimerWait = $TimerWait * 1000
	$Init = TimerInit()
	While TimerDiff($Init) < $TimerWait

	WEnd
EndFunc

