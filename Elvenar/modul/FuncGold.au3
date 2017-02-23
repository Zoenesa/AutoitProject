#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
#include-once
#include <File.au3>
#include "ImageSearch.au3"
#include "fileglobal.au3"

Global $xGold = 0, $yGold = 0
Func CommandGold()
	$CountFGold = 0
	$TotalCountGold = 0
	Do
		Local $CariGold = _ImageSearch( $ArrayImgFindGold[$CountFGold], 1, $xGold, $yGold, 60)
		$xFalseClose = 0
		$yFalseClose = 0
		Local $FalseKlik = _ImageSearch( $imgTutupWindow, 1, $xFalseClose, $yFalseClose, 10)
		If $FalseKlik = 1 Then
			Sleep(200)
			MouseClick( "primary", $xFalseClose, $yFalseClose, 1, 20)
			Sleep(200)
			MouseMove ( 466, 699, 10)
		EndIf
		Sleep(200)
		ToolTip( "Lookup Gold: " & $CountFGold & @CRLF & "Count: " & $TotalCountGold + 1, 0, 0, "Searching Gold")
		$CountFGold += 1
		If $CountFGold = 4 Then $CountFGold = 0
		$TotalCountGold += 1
	Until $CariGold  = 1

		$TotalCountGold = 0

	If $CariGold = 1 Then
		ToolTip( "Gold Found...." & @CRLF & "@x: " & $xGold & ", @y: " & $yGold & @CRLF & "Using Find No: " & $CountFGold, 0, 0, "Info")
		Sleep(300)
		MouseClick("primary", $xGold + 10, $yGold + 65, 1, 30)
		Sleep(200)

		MouseMove ( 466, 699, 10)
		$xGold = 0
		$yGold = 0
  	EndIf
		$CountFGold = 0
KoleksiGold()
EndFunc