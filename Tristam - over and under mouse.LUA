



midi_take = reaper.MIDIEditor_GetTake(reaper.MIDIEditor_GetActive())


reaper.BR_GetMouseCursorContext()
mouse_pos = reaper.BR_GetMouseCursorContext_Position()
mouse_pos_ppq = reaper.MIDI_GetPPQPosFromProjTime(midi_take,mouse_pos)




notes_to_play = {}


iter = 1
i=0
while true do
	 retval, selected, muted, startppqpos, endppqpos, chan, pitch, vel = reaper.MIDI_GetNote( midi_take, i )


	if vel == 0 then
	 	break
	end 

	if startppqpos < mouse_pos_ppq and endppqpos > mouse_pos_ppq then
		 notes_to_play[iter] = pitch
		 notes_to_play[iter+1] = vel
		 notes_to_play[iter+2] = 144+chan

		 iter = iter+3
	end
	
	i = i+1
end

-- for i=0, 2 do
-- 	reaper.Main_OnCommand(40294,0)
-- end
--
i=1
while notes_to_play[i]~= nil do

	i = i+1
	if notes_to_play[i]==-1 then
		break
	end
end
--


i = 1

while notes_to_play[i]~= nil do
	
	pitch = notes_to_play[i]
	vel = notes_to_play[i+1]
	chan = notes_to_play[i+2]

	reaper.StuffMIDIMessage(0,chan,pitch,vel)

	i = i+3

end






reaper.StuffMIDIMessage(0,4,47,100)


reaper.Main_OnCommand(40345,0)