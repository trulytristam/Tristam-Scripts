reaper.BR_GetMouseCursorContext()
mouse_pos = reaper.BR_GetMouseCursorContext_Position()

item = reaper.GetSelectedMediaItem(0,0)
item_pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
item_length = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
item_center = item_pos + (item_length/2)
item_take = reaper.GetActiveTake(item)
next_grid = reaper.BR_GetNextGridDivision(item_pos)
dist_to_move = next_grid - item_pos
item_startoffs = reaper.GetMediaItemTakeInfo_Value(item_take,"D_STARTOFFS")
zoom_level = reaper.GetHZoomLevel()


	if zoom_level < 200 and zoom_level > 120 then
		dist_to_move = dist_to_move * 2
	elseif zoom_level < 120 then
		dist_to_move = dist_to_move * 4
	end

is_new_value,filename,sectionID,cmdID,mode,resolution,val = reaper.get_action_context()
if val > 0 then
	reaper.SetMediaItemTakeInfo_Value(item_take,"D_STARTOFFS", item_startoffs - dist_to_move)
elseif val < 0 then
	reaper.SetMediaItemTakeInfo_Value(item_take,"D_STARTOFFS", item_startoffs + dist_to_move)
end

reaper.UpdateArrange()








