function hasstate()
	if reaper.HasExtState("stored", "distance") == true and reaper.HasExtState("stored", "mousepos") == true then
		return true
	end
	return false
	-- body
end

function main()

	reaper.BR_GetMouseCursorContext()
	new_mouse_pos = reaper.BR_GetMouseCursorContext_Position()
	new_mouse_pos_snap = reaper.SnapToGrid(0, new_mouse_pos)

	item_to_move = reaper.GetSelectedMediaItem(0, 0)
	item_to_move_pos = reaper.GetMediaItemInfo_Value(item_to_move, "D_POSITION")
	distancenew = new_mouse_pos_snap - item_to_move_pos

	if hasstate() == true then

		distance = reaper.GetExtState("stored", "distance")
		mouse_pos = reaper.GetExtState("stored", "mousepos")
	else
		reaper.SetExtState( "stored", "distance", distancenew, 0 )
		reaper.SetExtState( "stored", "mousepos", new_mouse_pos_snap, 0)
		distance = distancenew
	end

	new_pos = item_to_move_pos + distance

	reaper.Main_OnCommand(40698, 0)--copy


	if tostring(new_mouse_pos_snap) == mouse_pos then
		reaper.SetEditCurPos(new_pos, 0, 0)
		reaper.Main_OnCommand(40058, 0)
		reaper.SetEditCurPos(cur_pos, 0, 0)
	else
		reaper.DeleteExtState("stored", "distance", 0)
		reaper.DeleteExtState("stored", "mousepos", 0)
		reaper.SetEditCurPos(new_mouse_pos_snap, 0, 0)
		reaper.Main_OnCommand(40058, 0)

		distancenew = new_mouse_pos_snap - item_to_move_pos

		reaper.SetExtState( "stored", "distance", distancenew, 0 )
		reaper.SetExtState( "stored", "mousepos", new_mouse_pos_snap, 0)
	end		
end

reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

cur_pos = reaper.GetCursorPosition()
startarr, endarr = reaper.BR_GetArrangeView(0)

main()

reaper.SetEditCurPos2(0, cur_pos, 1, 0)

reaper.BR_SetArrangeView(0, startarr, endarr)
reaper.Undo_EndBlock("paste at given distance as long as mouse stays in same place", 0)

reaper.PreventUIRefresh(-1)
