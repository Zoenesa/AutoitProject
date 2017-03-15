#include "modul\fileglobal.au3"
#include <File.au3>
#include <Date.au3>

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

Func PesanKonsol( $refMsg, $refComment = " ")
	ConsoleWrite( "[" & @YEAR & ":" & @MON & ":" & @MDAY & ":" & @HOUR & ":" & @MIN & ":" & @SEC & "]" & $refMsg & "; " & $refComment & @CRLF)
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

Func CommandPencarian($EnumSearch, $FindImages, $TimerWait, $FileSetting, $oX, $oY, $Right, $Bottom, $Toleransi, $UserPickX, $UserPickY)
	$StatTimer = TimerInit()
	$TimerWait = $TimerWait * 1000
	$Pencarian = 0
	$Stack = 0
	$iNum = 0
	$refX = 0
	$refY = 0
	$JobX = 0
	$JobY = 0
	While TimerDiff($StatTimer) < $TimerWait
		Switch $EnumSearch
			Case 1 ;Metal
				PesanKonsol("Searching Resource","Metal")
				Do
					$Pencarian = _ImageSearchArea($FindImages[$iNum - 1], 1, $oX, $oY, $Right, $Bottom, $refX, $refY, $Toleransi)
					$iNum += 1
					If $iNum = 4 Then $iNum = 0
				Until $Pencarian = 1
				$GetJob = ReadSetting( $hfileSetting, "ResourceStat", "PickJob", 1)
				$UserPickX = ReadSetting( $hfileSetting, "ResourceStat", "UserPickX", 5)
				$UserPickY = ReadSetting( $hfileSetting, "ResourceStat", "UserPickY", 75)
			Case 2	;Crystal
				PesanKonsol("Searching Resource","Crystal")
				Do
					$Pencarian = _ImageSearchArea($FindImages[$iNum - 1], 1, $oX, $oY, $Right, $Bottom, $refX, $refY, $Toleransi)
					$iNum += 1
					If $iNum = 4 Then $iNum = 0
				Until $Pencarian = 1
				$GetJob = ReadSetting( $hfileSetting, "MetalStat", "PickJob", 1)
			Case 3
				PesanKonsol("Searching Resource","Elixir")
				Do
					$Pencarian = _ImageSearchArea($FindImages[$iNum - 1], 1, $oX, $oY, $Right, $Bottom, $refX, $refY, $Toleransi)
					$iNum += 1
					If $iNum = 4 Then $iNum = 0
				Until $Pencarian = 1
				$GetJob = ReadSetting( $hfileSetting, "CrystalStat", "PickJob", 1)
			Case 4

			Case 5

			Case 6

		EndSwitch

		Sleep(200)

		If $Pencarian = 1 Then
			MouseClick("left", $refX + $UserPickX, $refY + $UserPickY, 1, 7)
			Sleep(200)
			MouseMove(100,395,3)
			Sleep(600)
			Switch $EnumSearch
				Case 1

				Case 2

				Case 3

				Case 4

				Case 5

				Case 6

				Case 7

				Case 8

				Case 9

			EndSwitch

			MouseClick("left", $refX + $UserPickX, $refY + $UserPickY, 1, 7)
			Sleep(200)
			Switch $GetJob
				Case 1
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
		EndIf
	WEnd
EndFunc

Func SearchResource($TimerWait, $Init, $UserPickX, $UserPickY, $tolerance)
	$TimerWait = $TimerWait * 1000
	$Init = TimerInit()
	While TimerDiff($Init) < $TimerWait

	WEnd
EndFunc

