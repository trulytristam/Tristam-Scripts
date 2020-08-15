function main()

reaper.Undo_BeginBlock()


	track = reaper.GetSelectedTrack(0,0)

	if track == nil then

	else

	 fxcount = reaper.TrackFX_GetCount(track)

	commandID = reaper.NamedCommandLookup("_S&M_PASTE_TRACKFXCHAIN2")

	 reaper.Main_OnCommand(commandID,0)

	reaper.TrackFX_Show( track, fxcount, 3 )
	
	end

end

reaper.Undo_EndBlock("addfxslot2",0)


reaper.PreventUIRefresh(1)

main()

reaper.PreventUIRefresh(-1)