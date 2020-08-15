
reaper.PreventUIRefresh(1)

reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40289,0) -- unselect all

reaper.BR_GetMouseCursorContext()
item = reaper.BR_GetMouseCursorContext_Item()

reaper.SetMediaItemSelected(item,true)

item_pos = reaper.GetMediaItemInfo_Value(item,"D_POSITION")
item_len = reaper.GetMediaItemInfo_Value(item,"D_LENGTH")
item_end = item_pos + item_len

reaper.GetSet_LoopTimeRange2(0,true,false,item_pos,item_end,false)

reaper.SetEditCurPos(item_pos,false,false)

reaper.Undo_EndBlock("",0)

reaper.PreventUIRefresh(-1)

