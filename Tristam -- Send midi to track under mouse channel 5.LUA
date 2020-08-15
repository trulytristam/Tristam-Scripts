reaper.BR_GetMouseCursorContext()
tk = reaper.BR_GetMouseCursorContext_Track()

reaper.SetTrackColor(tk, reaper.ColorToNative(135,81,145))
retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( tk, "P_NAME", "5", true )
-- reaper.ShowConsoleMsg(info)
 reaper.SetTrackSendInfo_Value( tk, -1, 0, "I_MIDIFLAGS", 5.0 )
