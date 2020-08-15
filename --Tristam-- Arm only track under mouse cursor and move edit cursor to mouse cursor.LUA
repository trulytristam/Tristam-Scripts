function main()

reaper.Undo_BeginBlock()

		reaper.Main_OnCommand(40297,0) ----unselect all tracks
			reaper.Main_OnCommand(40491,0) ----unarm all tracks


		_,_,_ = reaper.BR_GetMouseCursorContext()
		track_under_mouse = reaper.BR_GetMouseCursorContext_Track()



		reaper.SetTrackSelected(track_under_mouse,1)
		reaper.SetMediaTrackInfo_Value(track_under_mouse, "I_RECARM", 1)

		reaper.Main_OnCommand(40513,0)

		reaper.Undo_EndBlock("Arm only track under mouse cursor",0)


end




reaper.PreventUIRefresh(1)
main()
reaper.PreventUIRefresh(-1)

