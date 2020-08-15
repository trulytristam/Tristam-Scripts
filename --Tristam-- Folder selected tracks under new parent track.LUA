
function main()


		first_track_in_sel = reaper.GetSelectedTrack(0,0)

		first_track_index = reaper.GetMediaTrackInfo_Value(first_track_in_sel, "IP_TRACKNUMBER")

		reaper.InsertTrackAtIndex( first_track_index - 1, true )

		parent_track = reaper.GetTrack(0, first_track_index - 1)

		reaper.SetMediaTrackInfo_Value(parent_track,"I_SELECTED",1)

		track_to_indent = reaper.GetSelectedTrack(0,reaper.CountSelectedTracks(0) - 1)

		reaper.SetMediaTrackInfo_Value(track_to_indent,"I_FOLDERDEPTH", -1)

		reaper.SetMediaTrackInfo_Value(parent_track,"I_FOLDERDEPTH",1)

		reaper.SetOnlyTrackSelected(parent_track)

end


reaper.PreventUIRefresh(1)

main()

reaper.PreventUIRefresh(-1)






