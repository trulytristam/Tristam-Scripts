

_,_,_ = reaper.BR_GetMouseCursorContext()


track_under_mouse = reaper.BR_GetMouseCursorContext_Track()

reaper.SetMediaTrackInfo_Value(track_under_mouse, "I_RECARM", 1)

