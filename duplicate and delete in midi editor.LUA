

_,_,_ = reaper.BR_GetMouseCursorContext()
reaper.BR_GetMouseCursorContext_MIDI()
mouse_position = reaper.BR_GetMouseCursorContext_Position()
media_item = reaper.GetSelectedMediaItem(0,0)
item_track = reaper.GetMediaItem_Track(media_item)
media_item_take = reaper.GetMediaItemTake(media_item,0)
midi_mouse_position = reaper.MIDI_GetPPQPosFromProjTime(media_item_take, mouse_position )
number_of_notes = reaper.MIDI_CountEvts(media_item_take)
timestart, timeend = reaper.GetSet_LoopTimeRange2(0,false,false,0,0,false)
timelength = timeend - timestart

reaper.ShowConsoleMsg(timeend)

midi_timestart = reaper.MIDI_GetPPQPosFromProjTime(media_item_take,timestart)
midi_timeend = reaper.MIDI_GetPPQPosFromProjTime(media_item_take,timeend)
midi_timelength = midi_timeend - midi_timestart


reaper.GetSet_LoopTimeRange2(0,true,false,timeend,(timeend + timelength), false)


reaper.MIDI_SelectAll(media_item_take,true)


for i = 0, number_of_notes-1 do
 retval, selectedOut, mutedOut, startnote, endnote, chanOut, pitchOut, velOut = reaper.MIDI_GetNote( media_item_take, i )

 if startnote < midi_timestart and endnote <= midi_timestart
 	or
 	startnote >= midi_timeend and endnote > startnote   then

 	reaper.MIDI_SetNote(media_item_take,i,NULL,NULL,false,NULL,NULL,NULL,NULL,NULL)

elseif start note < midi_timestart and endnote > midi_timestart
	








-- reaper.MIDI_InsertEvt(media_item_take, selected, muted, ppqpos, bytestr )

--splitmid



