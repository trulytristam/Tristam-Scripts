reaper.BR_GetMouseCursorContext()
tk = reaper.BR_GetMouseCursorContext_Track()
tk_pos = reaper.BR_GetMouseCursorContext_Position()
reaper.SetMediaTrackInfo_Value(tk,"I_SELECTED",1)



reaper.SetEditCurPos(tk_pos,0,0)
reaper.Main_OnCommand(1013,0)--insert media at cursor from browswer