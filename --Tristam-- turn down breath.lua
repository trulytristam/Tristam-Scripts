
function len(item)
	return reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
end

function find_fade_len(leftlen,midlen,rightlen)
	fraction = 15

	local fade_left = ((leftlen + midlen) / 2) /fraction
	local fade_right = ((rightlen + midlen) / 2) /fraction

	return fade_left, fade_right
end

function create_fades(item1,item2,fadelen)
	pos1 = reaper.GetMediaItemInfo_Value(item1, "D_POSITION")
	pos2 = reaper.GetMediaItemInfo_Value(item2, "D_POSITION")
	len1 = reaper.GetMediaItemInfo_Value(item1, "D_LENGTH")
	len2 = reaper.GetMediaItemInfo_Value(item2, "D_LENGTH")
	end1 = pos1 + len1
	end2 = pos2 + len2

	take2 = reaper.GetTake(item2, 0)




	reaper.ShowConsoleMsg(fadelen/2)
	reaper.SetMediaItemInfo_Value(item1, "D_LENGTH", len1 + (fadelen/2))
	--reaper.SetMediaItemInfo_Value(item1, "D_FADEOUTLEN", fadelen/2)

	reaper.ShowConsoleMsg(pos2)
	reaper.ShowConsoleMsg("\n")
	reaper.ShowConsoleMsg(fadelen/2)
	--reaper.SetMediaItemInfo_Value(item2, "D_POSITION", pos2 - (fadelen/2))
	--reaper.SetMediaItemTakeInfo_Value(take2, "D_STARTOFFS", (fadelen/2)/2)
	--reaper.SetMediaItemInfo_Value(item2, "D_FADEINLEN", fadelen/2)

end


function lower_volume(item, amount)

	item_vol = reaper.GetMediaItemInfo_Value(item, "D_VOL")
	reaper.SetMediaItemInfo_Value(item, "D_VOL", item_vol-amount)
end

function main_spit(track, mouse1, mouse2)
	reaper.BR_GetMouseCursorContext()
	itemleft = reaper.BR_GetMouseCursorContext_Item()


	itemmid = reaper.SplitMediaItem(itemleft, mouse1)
	itemright = reaper.SplitMediaItem(itemmid, mouse2)
	leftlen, midlen, rightlen = len(itemleft), len(itemmid), len(itemright)

	fadeleft, faderight = find_fade_len(leftlen,midlen,rightlen)


	create_fades(itemleft, itemmid, fadeleft)
	--create_fades(itemmid, itemright, faderight)


	lower_volume(itemmid, 0.2)
	
end	




flag = 0


if reaper.HasExtState("mouse", "pos") == false then
	reaper.BR_GetMouseCursorContext()
	mouse_pos = reaper.BR_GetMouseCursorContext_Position()
	reaper.SetExtState("mouse", "pos", mouse_pos, 0)
else
	mouse_pos1 = reaper.GetExtState("mouse", "pos")
	reaper.BR_GetMouseCursorContext()
	mouse_pos2 = reaper.BR_GetMouseCursorContext_Position()
	reaper.DeleteExtState("mouse", "pos", 0)
	flag = 1
end	








track = reaper.GetSelectedTrack(0, 0)

if flag == 1 then
	main_spit(track,mouse_pos1,mouse_pos2)
end


reaper.UpdateArrange()