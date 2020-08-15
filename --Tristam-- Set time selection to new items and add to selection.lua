
reaper.PreventUIRefresh(1)

reaper.Undo_BeginBlock()

reaper.BR_GetMouseCursorContext()
item = reaper.BR_GetMouseCursorContext_Item()
--reaper.SetMediaItemSelected(item,true)

--reaper.Main_OnCommand(40290,0) --set time selection to items

reaper.ShowConsoleMsg("hi")

reaper.Undo_EndBlock("",0)

reaper.PreventUIRefresh(-1)