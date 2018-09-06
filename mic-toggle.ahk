#SingleInstance force
; Copyright (c) 2018-present, Frederick Emmott
; All Rights Reserved.
;
; This source code is licensed under the MIT license found in the
; LICENSE file in the root directory of this source tree

; Use VA instead of SoundSet/SoundGet because of being able to set these on the default capture device
#include <VA>

PlayEffect()
{
	Muted := VA_GetMasterMute("capture")
	if (Muted) {
		SoundPlay, mute.wav
	} else {
		SoundPlay, unmute.wav
	}
}

; Mouse button 4 - Back
XButton1::
Muted := VA_GetMasterMute("capture")
VA_SetMasterMute(!Muted, "capture")
PlayEffect()
KeyWait, XButton1
if (Muted) {
	; Keep PTT on for slightly longer
	Sleep, 250
}
VA_SetMasterMute(Muted, "capture")
PlayEffect()
return

; Mouse Button 5 - Forward
XButton2::
WasMuted := VA_GetMasterMute("capture")
VA_SetMasterMute(!WasMuted, "capture")
PlayEffect()
Muted := !WasMuted
return

if (Muted) {
	ComObjCreate("SAPI.SpVoice").Speak("Push To Talk")
} else {
	ComObjCreate("SAPI.SpVoice").Speak("Push To Mute")
}
return