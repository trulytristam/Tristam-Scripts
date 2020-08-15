reaper.Main_OnCommand(40491,0)--unarm all tracks


midi_take = reaper.MIDIEditor_GetTake(reaper.MIDIEditor_GetActive())

track = reaper.GetMediaItemTake_Track(midi_take)
reaper.SetMediaTrackInfo_Value(track,"I_RECARM",1)