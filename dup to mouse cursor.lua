function check_selected(take, index)
	retval, selected, muted, startppqpos, endppqpos, chan, pitch, vel = reaper.MIDI_GetNote( take, index ) 
	if selected == true then
		return true 
	end
	return false
end

function unpack_note(table)
	retval = table[1]
	selected = table[2]
	muted = table[3]
	startppqpos = table[4]
	endppqpos = table[5]
	chan = table[6]
	pitch = table[7]
	vel = table[8]

	return retval, selected, muted, startppqpos, endppqpos, chan, pitch, vel
end

list_of_notes = {}

reaper.BR_GetMouseCursorContext()
mouse_pos = reaper.BR_GetMouseCursorContext_Position()
mouse_pos_snap = reaper.SnapToGrid(0, mouse_pos)

item = reaper.GetSelectedMediaItem(0, 0)
item_take = reaper.GetTake(item, 0)


--reaper.MIDI_EnumSelNotes( take, noteidx )

ppq_mouse_pos = reaper.MIDI_GetPPQPosFromProjTime(item_take, mouse_pos_snap)

number_of_notes = reaper.FNG_CountMidiNotes(item_take)

--number_of_notes = reaper.FNG_CountMidiNotes(midi_take)

selectednote = 0
first_loop = true

x = 1

--reaper.ShowConsoleMsg("number of notes: "..tostring(number_of_notes).."\n")

for i = 0, 100 do

	if check_selected(item_take, 0) == true and first_loop == true then
		selectednote = 0
		
	else
		selectednote = reaper.MIDI_EnumSelNotes( item_take, selectednote)
	end

	if selectednote < 0 then
		break

	else

	retval, selected, muted, startppqpos, endppqpos, chan, pitch, vel = reaper.MIDI_GetNote( item_take, selectednote )
	--reaper.MIDI_SetNote(take, noteidx, selectedIn, mutedIn, startppqposIn, endppqposIn, chanIn, pitchIn, velIn, noSortIn)
	list_of_notes[x] = {retval, selected, muted, startppqpos, endppqpos, chan, pitch, vel}

	if first_loop == true then
		distancetomouse = ppq_mouse_pos - startppqpos
	end

	x = x + 1

	end


	first_loop = false

end


count = 0


for k, v in pairs(list_of_notes) do


	retval, selected, muted, startppqpos, endppqpos, chan, pitch, vel = unpack_note(v)
	reaper.MIDI_InsertNote(item_take, false, muted, startppqpos+distancetomouse, endppqpos+distancetomouse, chan, pitch, vel, noSortIn)

end







--= reaper.MIDI_InsertNote( take, selected, muted, startppqpos, endppqpos, chan, pitch, vel, noSortIn )