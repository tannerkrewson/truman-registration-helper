
SendMode Input ; Makes AutoHotkey Send faster

vKeysToSend := Object()
vMyHotkey := Object()

; Get the CRNs
Loop, %0% ; For each parameter:
{
		param := %A_Index%
		vKeysToSend[A_Index] := param
}

; Create Hotkeys
for i, keysToSend in vKeysToSend
{
	thisHotkey = ^!%i%
	vMyHotkey.Insert(thisHotkey)
	Hotkey,^!%i%, Register
}

Register()
{
	global vKeysToSend
	global vMyHotkey
	for keysToSend in vKeysToSend	                 ; Loop through the ten possible hotkeys
	{
	    TempHotkey := vMyHotkey[A_Index]           ;vMyHotkey(1-10) stores the Hotkey combinations
	    If (TempHotkey = A_ThisHotkey)
	    {
	        TempKeysToSend := vKeysToSend[A_Index] ;vKeysToSend(1-10) stores what keys will be sent
	        TempKeysToSend = %TempKeysToSend%      ;In order for it to work correctly it must be enclosed in quotes
					CRN_Array := StrSplit(TempKeysToSend, ",")
					for i, crn in CRN_Array
					{
						Send, %crn%
						Send, {TAB}
					}
	        Break
	    }
	}
	return
}
