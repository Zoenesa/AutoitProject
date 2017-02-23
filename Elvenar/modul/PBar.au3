#include "fileglobal.au3"
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#Region ### START Koda GUI section ### Form=c:\users\triraksa village\downloads\compressed\koda_1.7.3.0\forms\progressbar.kxf
$Form1 = GUICreate("Checking Files", 468, 86, -1, -1, $GUI_SS_DEFAULT_GUI)
$Progress1 = GUICtrlCreateProgress(8, 56, 358, 19)
$Label1 = GUICtrlCreateLabel("%", 384, 57, 76, 17)
$Label2 = GUICtrlCreateLabel("Checking Files", 8, 2, 449, 41)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Local $int = 0
Local $nHFileArr[39] = [$imgsrc1, $imgsrc2, $imgsrc3, _
$imgsrc4, $imgsrc5, $imgsrc6, $imgsrc7, $imgsrc8, $imgsrc9, _
$imgsrc10, $imgsrc11, $imgsrc12, $imgsrc13, $imgsrc14, $imgsrc15, _
$imgsrc16, $imgsrc17, $imgsrc18, $imgsrc19, $imgsrc20, $imgsrc21, $imgsrc22, _
$imgsrc23, $imgsrc24, $imgsrc25, $imgsrc26, $imgsrc27, $imgsrc28, $imgsrc29, _
$imgsrc30, $imgsrc31, $imgsrc32, $imgsrc33, $imgsrc34, $imgsrc35, $imgsrc36, _
$imgsrc37, $imgsrc38, $imgsrc39]

HotKeySet( "{HOME}", "ProgressBarInc")

Func ProgressBarInc()

$countFoundFileOK = 0
$countFoundFileErr = 0
	For $i = 0 To 38
		$int = Int(100 / 38 * $i)
		GUICtrlSetData($Progress1, $int)
		GUICtrlSetData($Form1, "Checking Files: " & $int)
		If FileExists( $nHFileArr[$i]) Then
		Sleep(100)
		GUICtrlSetData($Label2,"checking" & @CRLF & $nHFileArr[$i] & " OK")
		$countFoundFileOK += 1
		Else
		Sleep(100)
		GUICtrlSetData($Label2,"checking" & @CRLF & $nHFileArr[$i] & " File Not Found")
		$countFoundFileErr += 1
		EndIf
		Sleep(50)
		GUICtrlSetData($Label1, $int & " %")
		Switch $i
			Case 0 To 9
				Sleep(300)
			Case 10 To 18
				Sleep(580)
			Case 19 To 20
				Sleep(450)
			Case 21 To 28
				Sleep(600)
			Case 29 To 38
				Sleep(1120)
		EndSwitch
	Next
	GUICtrlSetData($Label2, "All File Checked" & @CRLF & " OK: " & $countFoundFileOK & "; Not Found: " & $countFoundFileErr)
	Sleep(1000)
	;GUISetState(@SW_HIDE)
EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch

	Sleep(200)
WEnd
