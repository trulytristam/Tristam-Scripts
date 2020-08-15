item = reaper.GetSelectedMediaItem(0,0)
item_take = reaper.GetMediaItemTake(item,0)


tstart, tend = reaper.GetSet_LoopTimeRange2(0,false,false,0,0,false)
tlen = tend - tstart
tstart_midi = reaper.MIDI_GetPPQPosFromProjTime(item_take,tstart)
tend_midi = reaper.MIDI_GetPPQPosFromProjTime(item_take,tend)

number_of_events = reaper.MIDI_CountEvts(item_take)




isselecttable = {}
shortestdistance = {}
notelength = {}

function main()

	

	for i = 0, number_of_events - 1 do 
		 retval, isselected, mutedOut, startnoteppq, endnoteppq, chanOut, pitchOut, velOut = reaper.MIDI_GetNote(item_take,i)

		isselecttable[i] = isselected 
		
	end

	for i = 0, number_of_events - 1 do

			if isselecttable[i] == false then
				isselecttable[i] = true
			else
				isselecttable[i] = false
			end
		
		reaper.MIDI_SetNote(item_take,i,isselecttable[i],NULL,NULL,NULL,NULL,NULL,NULL,NULL)
	end


	for i = 0, number_of_events - 1 do 
		 retval, isselected, mutedOut, startnoteppq, endnoteppq, chanOut, pitchOut, velOut = reaper.MIDI_GetNote(item_take,i)

		isselecttable[i] = isselected 
		

	end

	j = 0

	for i = 0, number_of_events - 1 do 
		 retval, isselected, mutedOut, startnoteppq, endnoteppq, chanOut, pitchOut, velOut = reaper.MIDI_GetNote(item_take,i)

		 if isselected == true then

		 notelength[j] = startnoteppq

		 j = j + 1

		end
	end

	---establish shortest note
	shortestdistance_note = notelength[0]

	position_to_paste = ((reaper.MIDI_GetProjQNFromPPQPos(item_take,shortestdistance_note)/2))
	
    reaper.SetEditCurPos(position_to_paste,false,false)

	 reaper.MIDIEditor_LastFocused_OnCommand( 40012, false ) ----cut notes




	next_grid_division = reaper.BR_GetNextGridDivision(tstart)
	grid_len = next_grid_division - tstart

	number_of_splits = tlen / grid_len



	number_of_splits_int = math.floor(number_of_splits)

	j = tstart

	for i = 0, number_of_splits_int do 

	newitem = reaper.SplitMediaItem(item,j)
	item = newitem
	j = j + grid_len
	end

end




	
reaper.PreventUIRefresh(1)

reaper.Undo_BeginBlock()

main()





zoomstart, zoomend = reaper.GetSet_ArrangeView2(0, false, 0, 0 )

reaper.Main_OnCommand(41588,0) ---glue 


item = reaper.GetSelectedMediaItem(0,0)
item_take = reaper.GetMediaItemTake(item,0)

	 shortest_distance_noteppq = reaper.MIDI_GetProjTimeFromPPQPos(item_take,shortestdistance_note)

	

	reaper.MIDIEditor_LastFocused_OnCommand( 40011, false )


reaper.BR_SetArrangeView( 0, zoomstart, zoomend )

 



reaper.Undo_EndBlock("split MIDI notes at grid in time selection",0)





reaper.PreventUIRefresh(-1)
reaper.UpdateArrange()



















