
i = 0
still_items = true
while still_items do
	item = reaper.GetSelectedMediaItem(0,i)
	if item == nil then
		break
	end
	i = i+1
end

if i == 0 then
	reaper.BR_GetMouseCursorContext()
	track = reaper.BR_GetMouseCursorContext_Track()
	reaper.Main_OnCommand(40297,0) --unselect all tracks
	reaper.SetMediaTrackInfo_Value(track,"I_SELECTED",1)
	reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_TOGZOOMTT"),0)
else
	reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_TOGZOOMI"),0)
end



