
function accumulate_height(track_id)

	num_tracks = reaper.CountTracks(0)
	full_height = 0

	for i=0, num_tracks - 1 do

		tracktoadd = reaper.GetTrack(0, i)

		if tracktoadd ~= track_id then
			full_height = full_height + reaper.GetMediaTrackInfo_Value(tracktoadd, "I_WNDH")
		else
			break

		end
	end

	return full_height
end



ready = false



if reaper.HasExtState("calibrate", "y") == true then
	yoffset = reaper.GetExtState("calibrate", "y")
	ready = true


	if ready = true then
		x, y = reaper.GetMousePosition()



		reaper.BR_GetMouseCursorContext()
		track = reaper.BR_GetMouseCursorContext_Track()

		track_depth = reaper.GetMediaTrackInfo_Value(track, "I_WNDH")

		top_tack = yoffset

		reaper.ShowConsoleMsg(accumulate_height(track))


		reaper.ShowConsoleMsg(tostring(x)..'    '..tostring(y)..'\n')


		reaper.ShowConsoleMsg("track depth: "..tostring(track_depth))
	end

else
	reaper.ShowConsoleMsg("SCRIPT NOT CALIBRATED: Use corresponding calibration script to find top edge of track")

end
