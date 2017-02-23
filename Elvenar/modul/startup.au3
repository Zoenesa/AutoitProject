#include "fileglobal.au3"
$int = 0
Func CariMetal()
	$resultMsg = ""
	$errMsg = ""

	Do
	If FileExists( $ArrayImgFindGold[$int]) Then
		$resultMsg = $resultMsg & $int & ": " & $ArrayImgFindGold[$int] & @CRLF
	Else
		$errMsg = $errMsg & $int & ": " & $ArrayImgFindGold[$int] & @CRLF
	EndIf
	$int +=1
	Until $int = 4
	MsgBox( 0, "", "OK:						" & _
	@CRLF & $resultMsg & @CRLF & "Not Found:" & @CRLF & $errMsg)
EndFunc

CariMetal()
