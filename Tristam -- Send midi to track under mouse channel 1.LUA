reaper.BR_GetMouseCursorContext()
tk = reaper.BR_GetMouseCursorContext_Track()

reaper.SetTrackColor(tk, reaper.ColorToNative(234,64,94))
 retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( tk, "P_NAME", "1", true )
 reaper.SetTrackSendInfo_Value( tk, -1, 0, "I_MIDIFLAGS", 1.0 )
