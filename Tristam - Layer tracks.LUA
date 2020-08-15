
function convert_track_midi_to_channel(t,ch)

	reaper.Main_OnCommand(40914,0) --last touched
	reaper.Main_OnCommand(40421,0) --select all on track

	reaper.Main_OnCommand(41588,0) -- glue

	
	local num_items = reaper.CountSelectedMediaItems(0)

	for i = 0, num_items - 1 do
		
		local item = reaper.GetSelectedMediaItem(0, i)
		local take = reaper.GetActiveTake(item)
		
		if reaper.TakeIsMIDI(take) then 
			reaper.MIDI_SelectAll(take, 1)
		end
		
	end

	midi_e = reaper.MIDIEditor_GetActive()


	if ch == 1 then
		reaper.MIDIEditor_OnCommand(midi_e,40020) -- set to channel one
	elseif ch == 2 then
		reaper.MIDIEditor_OnCommand(midi_e,40021) -- set to channel one
	elseif ch == 3 then
		reaper.MIDIEditor_OnCommand(midi_e,40022) -- set to channel one
	elseif ch == 4 then
		reaper.MIDIEditor_OnCommand(midi_e,40023) -- set to channel one
	elseif ch == 5 then
		reaper.MIDIEditor_OnCommand(midi_e,40024) -- set to channel one
	end

end


reaper.PreventUIRefresh(1)



trck = reaper.GetSelectedTrack(0,0)
tracknum = reaper.GetMediaTrackInfo_Value(trck,"IP_TRACKNUMBER")

reaper.InsertTrackAtIndex(tracknum-1,1)


reaper.InsertTrackAtIndex(tracknum,1)


trck = reaper.GetTrack(0,tracknum-1)
trck2 = reaper.GetTrack(0,tracknum)

retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( trck, "P_NAME", "PARENT", true )
reaper.SetTrackColor(trck, reaper.ColorToNative(5,5,5))
reaper.SetMediaTrackInfo_Value(trck,"I_SELECTED",1)

retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( trck2, "P_NAME", "PITCH", true )
reaper.SetTrackColor(trck, reaper.ColorToNative(10,10,10))
reaper.SetMediaTrackInfo_Value(trck,"I_SELECTED",1)


current_track = 0
while true do

	t = reaper.GetSelectedTrack(0,current_track)
	reaper.CreateTrackSend(trck2 , t )
	reaper.CreateTrackSend(trck , t )


	if t == nil then
		break
	end


	--convert_track_midi_to_channel(t,current_track)




	if current_track == 1 then
		reaper.SetTrackColor(t, reaper.ColorToNative(234,64,94))
		 retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( t, "P_NAME", "1", true )
		 reaper.SetTrackSendInfo_Value( t, -1, 0, "I_MIDIFLAGS", 1.0 )
	elseif current_track == 2 then
		reaper.SetTrackColor(t, reaper.ColorToNative(221,117,13))
		retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( t, "P_NAME", "2", true )
		-- reaper.ShowConsoleMsg(info)
		 reaper.SetTrackSendInfo_Value( t, -1, 0, "I_MIDIFLAGS", 2.0 )

	elseif current_track == 3 then


		reaper.SetTrackColor(t, reaper.ColorToNative(60,166,86))
		retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( t, "P_NAME", "3", true )
		-- info = reaper.GetTrackSendInfo_Value(tk,-1,0,"I_MIDIFLAGS")
		-- reaper.ShowConsoleMsg(info)
		 reaper.SetTrackSendInfo_Value( t, -1, 0, "I_MIDIFLAGS", 3.0 )

	elseif current_track == 4 then
		reaper.SetTrackColor(t, reaper.ColorToNative(58,163,165))
		retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( t, "P_NAME", "4", true )
-- reaper.ShowConsoleMsg(info)
 		reaper.SetTrackSendInfo_Value( t, -1, 0, "I_MIDIFLAGS", 4.0 )
    elseif current_track == 5 then

		reaper.SetTrackColor(t, reaper.ColorToNative(135,81,145))
		retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( t, "P_NAME", "5", true )
		-- reaper.ShowConsoleMsg(info)
		 reaper.SetTrackSendInfo_Value( t, -1, 0, "I_MIDIFLAGS", 5.0 )


	end



	
	current_track = current_track +1
	
end


-----


local r = reaper; local function nothing() end; local function bla() r.defer(nothing) end

function last_tr_in_folder (folder_tr)
  last = nil
  local dep = r.GetTrackDepth(folder_tr)
  local num = r.GetMediaTrackInfo_Value(folder_tr, 'IP_TRACKNUMBER')
  local tracks = r.CountTracks()
  for i = num+1, tracks do
    if r.GetTrackDepth(r.GetTrack(0,i-1)) <= dep then last = r.GetTrack(0,i-2) break end
  end
  if last == nil then last = r.GetTrack(0, tracks-1) end
  return last
end

sel_tracks = r.CountSelectedTracks()
if sel_tracks == 0 then bla() end

first_sel = r.GetSelectedTrack(0,0)
tr_num = r.GetMediaTrackInfo_Value(first_sel, 'IP_TRACKNUMBER')

last_sel = r.GetSelectedTrack(0,sel_tracks-1)
last_sel_dep = r.GetMediaTrackInfo_Value(last_sel, 'I_FOLDERDEPTH')
if last_sel_dep == 1 then last_tr = last_tr_in_folder(last_sel) else last_tr = last_sel end

r.Undo_BeginBlock()
r.PreventUIRefresh(1)

r.InsertTrackAtIndex(tr_num-1, 1)
r.TrackList_AdjustWindows(0)
tr = r.GetTrack(0, tr_num-1)

r.SetMediaTrackInfo_Value(tr, 'I_FOLDERDEPTH', 1)
r.SetMediaTrackInfo_Value(last_tr, 'I_FOLDERDEPTH', last_sel_dep-1)
r.SetOnlyTrackSelected(tr)
retval, stringNeedBig = reaper.GetSetMediaTrackInfo_String( tr, "P_NAME", "BUS", true )

r.Main_OnCommand(40914,0) -- Track: Set first selected track as last touched track

r.PreventUIRefresh(-1)

r.Main_OnCommand(40913,0) -- Track: Vertical scroll selected tracks into view

r.Undo_EndBlock('Create folder from selected tracks', -1)

--

--

reaper.PreventUIRefresh(-1)