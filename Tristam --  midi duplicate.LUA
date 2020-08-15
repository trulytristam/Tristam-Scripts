
function pitch_not_in_table(p, pitch_table)
	local i = 1
	local pich = 1

	if pitch_table[1] == nil then
		return true

	else

		while pich ~= nil do
			pich = pitch_table[i]

			if pich == p then
				return false
			end

			i = i+1
		end

		return true
	end
end     


function main()

	midi_take = reaper.MIDIEditor_GetTake(reaper.MIDIEditor_GetActive())
	time_start, time_end = reaper.GetSet_LoopTimeRange2(0,0,0,0,0,0)

	ppq_time_start = reaper.MIDI_GetPPQPosFromProjTime(midi_take,time_start)
	ppq_time_end = reaper.MIDI_GetPPQPosFromProjTime(midi_take,time_end)
	ppq_time_length = ppq_time_end-ppq_time_start



	note_index = -2

	note_table = {}
	pitch_table = {}
	pitch_iter = 1


	i = 1
	number_of_entries = 0


	longest_note = 0

	---
	smallest_note_ppq = 10000000
	greatest_note_ppq = 0
	---


	while note_index ~= -1 do

		note_index = reaper.MIDI_EnumSelNotes( midi_take, note_index )



		if note_index == -1 then
			break
		end



		retval, selected, muted, startppqpos, endppqpos, chan, pitch, vel = reaper.MIDI_GetNote( midi_take, note_index )


		note_pitch = pitch

		if pitch_not_in_table(note_pitch, pitch_table) then

			pitch_table[pitch_iter] = note_pitch
			pitch_iter = pitch_iter + 1
		end

		if startppqpos < smallest_note_ppq then
			smallest_note_ppq = startppqpos
		end

		if endppqpos > greatest_note_ppq then
			greatest_note_ppq = endppqpos
		end


		note_length = endppqpos-startppqpos

		if note_length > longest_note then
			longest_note = note_length
		end


		note_table[i] = startppqpos
		note_table[1+i] = endppqpos
		note_table[2+i] = pitch
		note_table[3+i] = vel
		note_table[4+i] = chan

		i = i+5
		number_of_entries = number_of_entries+1

	end





	smallest_note_projtime = reaper.MIDI_GetProjTimeFromPPQPos(midi_take,smallest_note_ppq)
	greatest_note_projtime = reaper.MIDI_GetProjTimeFromPPQPos(midi_take,greatest_note_ppq)



	if time_start > smallest_note_projtime and time_end < greatest_note_projtime or time_start < smallest_note_projtime and time_end <= smallest_note_projtime or time_start >= greatest_note_projtime and time_end > greatest_note_projtime or time_end- time_start == 0 then

		reaper.GetSet_LoopTimeRange2(0,1,0,smallest_note_projtime,greatest_note_projtime,0)

	
		ppq_greatest_note_time = reaper.MIDI_GetPPQPosFromProjTime(midi_take,greatest_note_projtime)
		ppq_smallest_note_time = reaper.MIDI_GetPPQPosFromProjTime(midi_take,smallest_note_projtime)

		ppq_time_length = ppq_greatest_note_time - ppq_smallest_note_time


	end



	if time_start <= smallest_note_projtime and (time_end > smallest_note_projtime and time_end < greatest_note_projtime) then
		reaper.GetSet_LoopTimeRange2(0,1,0,time_start,greatest_note_projtime,0)

		ppq_greatest_note_time = reaper.MIDI_GetPPQPosFromProjTime(midi_take,greatest_note_projtime)
		ppq_time_start = reaper.MIDI_GetPPQPosFromProjTime(midi_take,time_start)


		ppq_time_length = ppq_greatest_note_time - ppq_time_start
	end     


	if time_end >= greatest_note_projtime and (time_start > smallest_note_projtime and time_start < greatest_note_projtime) then
		reaper.GetSet_LoopTimeRange2(0,1,0,smallest_note_projtime,time_end,0)

		ppq_smallest_note_time = reaper.MIDI_GetPPQPosFromProjTime(midi_take,smallest_note_projtime)
		ppq_time_end = reaper.MIDI_GetPPQPosFromProjTime(midi_take,time_end)


		ppq_time_length = ppq_time_end - ppq_smallest_note_time
	end     


	---SCAN
	notes_remaining = true

	notes_to_delete = {}
	notes_to_delete_iter = 1


	reaper.MIDI_SelectAll( midi_take, true)

	current_note = -2
	while current_note ~= -1 do

		current_note = reaper.MIDI_EnumSelNotes(midi_take,current_note)
		if current_note == -1 then break end

		retval, selected, muted, startppqpos, endppqpos, chan, pitch, vel = reaper.MIDI_GetNote(midi_take, current_note)

		if not pitch_not_in_table(pitch, pitch_table) then

			n = 1
			while note_table[n] ~= nil do

				new_note_start = note_table[n] + ppq_time_length
				new_note_end = note_table[n+1] + ppq_time_length

				if pitch == note_table[n+2] then
					if new_note_start <= startppqpos and new_note_end > startppqpos then
						notes_to_delete[notes_to_delete_iter] = current_note
						notes_to_delete_iter = notes_to_delete_iter + 1
					elseif new_note_start > startppqpos and new_note_end > startppqpos and new_note_start <= endppqpos then
						reaper.MIDI_SetNote(midi_take,current_note,1,0,startppqpos,new_note_start)
					end
				end
					
				n = n+5
			end
		end

	end

	--unselect all notes to keep
	reaper.MIDI_SelectAll( midi_take, false )

	i = 1
	while notes_to_delete[i] ~= nil do
		reaper.MIDI_SetNote(midi_take,notes_to_delete[i],1)
		i = i+1
	end

	reaper.MIDIEditor_OnCommand(reaper.MIDIEditor_GetActive(),40002) --delete selected notes


	--------CREATE NEW NOTES

	midi_take = reaper.MIDIEditor_GetTake(reaper.MIDIEditor_GetActive())

	w = 1


	n_time_start, n_time_end = reaper.GetSet_LoopTimeRange2(0,0,0,0,0,0)

	n_time_start_ppq = reaper.MIDI_GetPPQPosFromProjTime(midi_take,n_time_start)
	n_time_end_ppq = reaper.MIDI_GetPPQPosFromProjTime(midi_take,n_time_end)

	n_ppq_time_length = n_time_end_ppq - n_time_start_ppq


	for i=1, number_of_entries do
		startppqpos = note_table[w]
		endppqpos = note_table[1+w]
		pitch = note_table[2+w] 
		vel = note_table[3+w] 
		chan = note_table[4+w]
		w = w+5

		reaper.MIDI_InsertNote( midi_take, 1, 0, startppqpos+n_ppq_time_length, endppqpos+n_ppq_time_length,chan , pitch, vel, 0 )

	end



	after_time_start, after_time_end = reaper.GetSet_LoopTimeRange2(0,0,0,0,0,0)

	after_time_length = after_time_end - after_time_start


	reaper.GetSet_LoopTimeRange2(0,1,0,after_time_start+after_time_length,after_time_end+after_time_length,0)
end


reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(-1)


main()


reaper.PreventUIRefresh(1)
reaper.Undo_EndBlock("midi_duplicate",0)








		-- note_start_projtime = reaper.MIDI_GetProjTimeFromPPQPos(midi_take,startppqpos)
		-- note_end_projtime = reaper.MIDI_GetProjTimeFromPPQPos(midi_take,endppqpos)

		-- startppqpos = reaper.MIDI_GetPPQPosFromProjTime(midi_take,note_start_projtime)
		-- endppqpos = reaper.MIDI_GetPPQPosFromProjTime(midi_take,note_end_projtime)

		-- reaper.ShowConsoleMsg("pitch: "..pitch.."\n")

		-- reaper.ShowConsoleMsg("startppqpos: "..startppqpos.."\n")
		-- reaper.ShowConsoleMsg("endppqpos: "..endppqpos.."\n")

		-- reaper.ShowConsoleMsg("startppqpos new: "..startppqpos+n_ppq_time_length.."\n")
		-- reaper.ShowConsoleMsg("endppqpos new: "..endppqpos+n_ppq_time_length.."\n")

	


--      for i=1,number_of_entries*4 do 

-- reaper.ShowConsoleMsg(note_table[i])
-- reaper.ShowConsoleMsg("\n")

-- end


	--reaper.MIDIEditor_OnCommand(reaper.MIDIEditor_GetActive(),40214)









-- reaper.ShowConsoleMsg(longest_note)

-- reaper.ShowConsoleMsg(number_of_entries)





-- for i=1,number_of_entries*4 do 

-- reaper.ShowConsoleMsg(note_table[i])
-- reaper.ShowConsoleMsg("\n")

-- end




 --retval, selected, muted, startppqpos, endppqpos, chan, pitch, vel = reaper.MIDI_GetNote( take, noteidx )
