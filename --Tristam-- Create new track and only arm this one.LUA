
reaper.Undo_BeginBlock2(0)


function main()

		reaper.Main_OnCommand(40491,0) ----unarm all tracks

		track_to_unarm = reaper.GetSelectedTrack(0,0)

		reaper.SetMediaTrackInfo_Value(track_to_unarm,"I_RECARM",0)

		--reaper.Main_OnCommand(40285,0)
		reaper.Main_OnCommand(40001,0)

		new_track = reaper.GetSelectedTrack(0,0)

		reaper.SetMediaTrackInfo_Value(new_track,"I_RECARM",1)

		

end


reaper.Undo_EndBlock("New script",0)



reaper.PreventUIRefresh(1)
main()
reaper.PreventUIRefresh(-1)