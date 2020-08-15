reaper.BR_GetMouseCursorContext()
tk = reaper.BR_GetMouseCursorContext_Track()

reaper.SetTrackColor(tk, reaper.ColorToNative(221,117,13))
retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( tk, "P_NAME", "2", true )
-- reaper.ShowConsoleMsg(info)
 reaper.SetTrackSendInfo_Value( tk, -1, 0, "I_MIDIFLAGS", 2.0 )
