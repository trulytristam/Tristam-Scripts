

tracknum = reaper.CountSelectedTracks(0)


track = reaper.GetSelectedTrack(0,0)



--reaper.ShowConsoleMsg(trackvol.."\n")

is_new_value,filename,sectionID,cmdID,mode,resolution,val = reaper.get_action_context()

increment = 0





function volumechange(updown) 

		for i = 0, tracknum - 1  do

			track = reaper.GetSelectedTrack(0,i)

			trackvol = reaper.GetMediaTrackInfo_Value(track,"D_VOL")

	if trackvol <= 0.25 then
		increment = 0.010
	elseif trackvol >= 0.25 and trackvol <= 1 then
		increment = 0.02
	elseif trackvol > 1 and trackvol <= 1.2 then
		increment = 0.02
	elseif trackvol > 1.2 then
		increment = 0.035
	end

	increment = increment * 0.8

			reaper.SetMediaTrackInfo_Value(track,"D_VOL",trackvol+(updown * increment))
		end
end

reaper.PreventUIRefresh(1)

if val > 0 then
	volumechange(1)
elseif val < 0 then
	volumechange(-1)
end

reaper.PreventUIRefresh(-1)

reaper.UpdateArrange()


