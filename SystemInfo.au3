#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.1.1.0
 Author:         myName

 Script Function:
    Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Generated by AutoIt Scriptomatic

$wbemFlagReturnImmediately = 0x10
$wbemFlagForwardOnly = 0x20
$colItems = ""
$strComputer = "localhost"
$Message = ""

$Output=""
$Output = $Output & "Computer: " & $strComputer  & @CRLF
$Output = $Output & "==========================================" & @CRLF
$objWMIService = ObjGet("winmgmts:\\" & $strComputer & "\root\CIMV2")
$colItems = $objWMIService.ExecQuery("SELECT * FROM Win32_ComputerSystemProduct", "WQL", _
                                          $wbemFlagReturnImmediately + $wbemFlagForwardOnly)

If IsObj($colItems) then
   For $objItem In $colItems

    $Message = $Message & "PC Name: " & @ComputerName & @CR
    $Message = $Message & "PC Type: " & $objItem.Name & @CR
    $Message = $Message & "Service Tag: " &  $objItem.IdentifyingNumber & @CR

   Next
Else
	$Message = $Message & "PC Name: " & @ComputerName & @CR
    $Message = $Message & "PC Type: Not Found" & @CR
    $Message = $Message & "Service Tag: Not Found" & @CR
Endif

$x = MsgBox(4, "System Information", $Message & @CR & "Copy service tag to clipboard?")
IF $x = 6 Then
	ClipPut($objItem.IdentifyingNumber)
	Exit
EndIf
