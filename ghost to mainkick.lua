function select_only_and_set_last_touched(track)
	reaper.Main_OnCommand( 40297, 0 ) -- unselect all trakcs
	reaper.SetMediaTrackInfo_Value( track , "I_SELECTED", 1 )
	reaper.Main_OnCommand( 40914 , 0 ) -- last touched
end


tracknum = reaper.CountTracks(0)
bothfound = 0

for i=0, tracknum -1 do
	if bothfound > 1 then
		break 
	end

	scantrack = reaper.GetTrack(0, i)
	retval, scantrack_name =  reaper.GetTrackName(scantrack, "")

	

	if scantrack_name == "ghost" then
		tractopasteon = scantrack
		bothfound = bothfound + 1
		

	elseif scantrack_name == "mainkick" then
		track_to_follow = scantrack
		bothfound = bothfound + 1
		
	end
end





function main(track_to_follow, tractopasteon)
	reaper.BR_GetMouseCursorContext()
	--track_to_follow =  reaper.BR_GetMouseCursorContext_Track()
	item_to_paste = reaper.GetSelectedMediaItem( 0, 0 )
	select_only_and_set_last_touched(tractopasteon)
	--tractopasteon = reaper.GetMediaItem_Track( item_to_paste )

	start2, end2 = reaper.GetSet_LoopTimeRange2( 0,0 , 0, 0, 0, 0 )
	--tractopasteon =  reaper.GetSelectedTrack( 0, 0)
	first_item_in_track = reaper.GetTrackMediaItem( tractopasteon, 0 )
	curpos = reaper.GetCursorPosition()
	--save cursor position to restore at the end

	----------------------------UNSELECT ALL ON TRACK AND SELECT ONLY ON
	--get first track media item
	first_item = reaper.GetTrackMediaItem( tractopasteon, 0 )
	--unselect all items
	reaper.Main_OnCommand(40289,0)
	--set first item as only selected
	reaper.SetMediaItemSelected( first_item, 1 )
	--copy item
	reaper.Main_OnCommand(40698, 0)

	if start2 == end2 then
		reaper.Main_OnCommand(40421, 0) -- select all on track
		reaper.Main_OnCommand(40006, 0) -- remove items

	else
		
		reaper.Main_OnCommand(40718, 0) -- select all in track and time selection
		reaper.Main_OnCommand(40006, 0) -- remove items

	end
	select_only_and_set_last_touched(track_to_follow)

	--reaper.Main_OnCommand(40718, 0) -- select all in track and time selection

	reaper.Main_OnCommand(40421, 0) -- select all on track
	number_of_items = reaper.CountSelectedMediaItems( 0 )

	martin = {}

	for i = 0, number_of_items -1 do
		
		--reaper.ShowConsoleMsg(i)
		itemtostore =  reaper.GetSelectedMediaItem(0, i )
		postostore = reaper.GetMediaItemInfo_Value( itemtostore  , "D_POSITION" )
		--reaper.ShowConsoleMsg(postostore)
		--reaper.ShowConsoleMsg(i)
		if start2 == end2 then
			martin[i+1] = postostore

		elseif postostore >= start2 and postostore < end2 then
			martin[i+1] = postostore
		end
	end

	select_only_and_set_last_touched(tractopasteon)

	--- move cursor and paste for as many positions in martin
	for k, v in pairs(martin) do
		reaper.SetEditCurPos( v, false, false ) --move cursor
		reaper.Main_OnCommand(40058, 0) -- paste		
	end
	reaper.SetEditCurPos(curpos, 0, 0 )
	reaper.Main_OnCommand(40289,0)

end

reaper.PreventUIRefresh( 1 )


reaper.Undo_BeginBlock()


main(track_to_follow, tractopasteon)	


reaper.Undo_EndBlock( "paste at all instance in track under mouse" , 0 )

reaper.PreventUIRefresh( -1 )

reaper.UpdateArrange()































