
function main()

track_number = reaper.CountSelectedTracks()


	for i = 0, track_number -1 do

			
		track = reaper.GetSelectedTrack(0,i)


		item_number =  reaper.CountTrackMediaItems(track)
			
				
			for j = 0, item_number - 1 do
				
				item = reaper.GetTrackMediaItem(track,j)
						reaper.SetMediaItemInfo_Value(item,"B_UISEL",1)

		
		    end	

	end	    

end

reaper.PreventUIRefresh(1)
main()
reaper.PreventUIRefresh(-1)

reaper.UpdateArrange()

