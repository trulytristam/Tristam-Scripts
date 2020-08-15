reaper.Main_OnCommand(42197,0) -- set time sel
reaper.Main_OnCommand(41163,0) -- unarm envs
reaper.Main_OnCommand(42088,0) -- del aut item
reaper.Main_OnCommand(40330,0) -- select points in time

--reaper.Main_OnCommand(42199,0) -- reduce by half
reaper.Main_OnCommand(42199,0) -- reduce by half








env = reaper.GetSelectedEnvelope(0)
track, index, index2 = reaper.Envelope_GetParentTrack( env )


start_time, end_time = reaper.GetSet_LoopTimeRange2(0,0,0,0,0,0)


points_pos = {}

p = 0 
i = 0

while true do 

	retval, time, value, shape, tension, selected = reaper.GetEnvelopePoint( env, p )

	if time >= start_time and time <= end_time then
		points_pos[i] = time
		points_pos[i+1] = value
		points_pos[i+2] = shape
		points_pos[i+3] = tension
		points_pos[i+4] = selected
		i = i + 5
	end

	if retval == false then
		break
	end

	p = p +1

end



t= 0
while true do

	item_on_track = reaper.GetTrackMediaItem(track,t)

	if item_on_track == nil then
		break
	end 

	item_pos = reaper.GetMediaItemInfo_Value(item_on_track,D_POSITION)
	item_len = reaper.GetMediaItemInfo_Value(item_on_track,D_LENGTH)
	item_end = item_pos+item_len







	t = t+1 





end