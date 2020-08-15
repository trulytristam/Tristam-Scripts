reaper.Main_OnCommand(1016,0)

reaper.BR_GetMouseCursorContext()
item = reaper.BR_GetMouseCursorContext_Item()



if item ~= nil then
	item_position = reaper.GetMediaItemInfo_Value(item,"D_POSITION")
end

track = reaper.BR_GetMouseCursorContext_Track()


reaper.Main_OnCommand(40297,0) --unselect all tracks
--reaper.Main_OnCommand(40340,0) --unsolo all tracks


reaper.SetMediaTrackInfo_Value(track,"I_SELECTED",1)
reaper.SetMediaTrackInfo_Value(track,"I_SOLO",1)

if item_position ~= nil then
reaper.SetEditCurPos2(0,item_position,0,0)
end

reaper.Main_OnCommand(40044,0)








