










-- reaper.Main_OnCommand(40698,0) -- copy

--reaper.Main_OnCommand(40001,0) -- insert track
-- reaper.MoveEditCursor(anything_postion,0)

-- reaper.Main_OnCommand(40058,0) -- paste

reaper.Undo_BeginBlock2(0)
 
reaper.PreventUIRefresh(-1)


reaper.Main_OnCommand(40062,	0) -- duplicate

first = reaper.GetSelectedMediaItem(0,	0)
reaper.SetMediaItemInfo_Value(first, "B_UISEL", 0)




anything = reaper.GetSelectedMediaItem(0,0)

anything_postion = reaper.GetMediaItemInfo_Value(anything,"D_POSITION")

anything_length = reaper.GetMediaItemInfo_Value(anything,"D_LENGTH")


reaper.Main_OnCommand(41051,0) --reverse

reaper.SetMediaItemInfo_Value(anything,"D_POSITION",anything_postion-anything_length)

reaper.PreventUIRefresh(1)

reaper.Undo_EndBlock2(0,"Reverse and offset",0)
--reaper.ShowConsoleMsg(anything_postion)

