item = reaper.GetSelectedMediaItem(0,0)

item_take = reaper.GetMediaItemTake(item,0)

reaper.BR_GetMouseCursorContext()
curpos = reaper.BR_GetMouseCursorContext_Position()

reaper.ShowConsoleMsg(curpos)

curpos_projt = reaper.MIDI_GetProjTimeFromPPQPos(item_take	,curpos)


reaper.MIDI_GetNote(item_take,0)

number_of_notes = reaper.MIDI_CountEvts(item_take)




reaper.SetEditCurPos(curpos,false,false)






reaper.BR_GetMouseCursorContext()

reaper.BR_GetMouseCursorContext_MIDI()

reaper.MIDIEditor_OnCommand(0,40010)

reaper.MIDIEditor_OnCommand(0,40889)

reaper.UpdateArrange()





