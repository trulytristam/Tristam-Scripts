reaper.BR_GetMouseCursorContext()
tk = reaper.BR_GetMouseCursorContext_Track()

reaper.SetTrackColor(tk, reaper.ColorToNative(60,166,86))
retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( tk, "P_NAME", "3", true )
-- info = reaper.GetTrackSendInfo_Value(tk,-1,0,"I_MIDIFLAGS")
-- reaper.ShowConsoleMsg(info)
 reaper.SetTrackSendInfo_Value( tk, -1, 0, "I_MIDIFLAGS", 3.0 )
