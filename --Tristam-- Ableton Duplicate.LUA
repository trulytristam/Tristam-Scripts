
reaper.PreventUIRefresh(1)

startTime, endTime = reaper.BR_GetArrangeView(0)


reaper.Main_OnCommand( reaper.NamedCommandLookup( "_SWS_SAVESEL"),  0)


reaper.Undo_BeginBlock()
tstart, tend = reaper.GetSet_LoopTimeRange2(0,false,false,0,0,false)
cur_pos = reaper.GetCursorPosition()
reaper.Main_OnCommand(40290,0) --settime selection to items
cstart, cend = reaper.GetSet_LoopTimeRange2(0,false,false,0,0,false) 
reaper.GetSet_LoopTimeRange2(0,true,false,tstart,tend,false)
tlen = tend - tstart

-----------automation follow item toggle
follow_item_move = reaper.GetToggleCommandState(40070)


--[[
	a = "dog"
	if follow_item_move == 1 then

		reaper.Main_OnCommand(40070,0)

		a = "cat"
	end
	]]--
---------------------------------------------------------
if cstart < tstart and cend <= tstart  
		or
	   cstart >= tend and cend > tend
	  or
	  tstart == tend then

	   reaper.Main_OnCommand(40290,0)
	tstart, tend = reaper.GetSet_LoopTimeRange2(0,false,false,0,0,false)     
	tlen = tend - tstart     
	 end

function duplicate()

	first_item = reaper.GetSelectedMediaItem(0,0)

		if first_item ~= nil then

			first_track = reaper.GetMediaItemTrack(first_item)

			reaper.CountSelectedMediaItems(0)

			reaper.SetOnlyTrackSelected(first_track)

			reaper.Main_OnCommand(40914,0) --set first track as last touched

			reaper.Main_OnCommand( reaper.NamedCommandLookup( "_SWS_SELTRKWITEM"),  0)

			reaper.Main_OnCommand(40289,0) -- unselect all items

			reaper.Main_OnCommand(40718,0) -- select all items in track/time selection

			reaper.GetSet_LoopTimeRange2(0,true,false,tstart,tend,false)

			--reaper.Main_OnCommand(40061,0) --split selected items


			reaper.Main_OnCommand(40290,0) --settime selection to items

			fstart, fend = reaper.GetSet_LoopTimeRange2(0,false,false,0,0,false)

			reaper.GetSet_LoopTimeRange2(0,true,false,tstart,tend,false)          

			reaper.Main_OnCommand(40289,0)

			reaper.Main_OnCommand(40718,0) -- select all items in track/time selection

			reaper.GetSet_LoopTimeRange2(0,true,false,tstart,tend,false)                

				distance_to_first_item = fstart - tstart

			if cstart < tstart then
				distance_to_first_item = -distance_to_first_item
			end

			--reaper.Main_OnCommand(40698,0) --copy items

			reaper.GetSet_LoopTimeRange2(0,true,false,tend,tend + tlen,false)  --set next time selection               

			reaper.Main_OnCommand(40718,0) -- select all items in track/time selection

			isitem = reaper.GetSelectedMediaItem(0,0)

			if isitem ~= nil then
			reaper.Main_OnCommand(40312,0) -- remove selected area of item
			end

			reaper.GetSet_LoopTimeRange2(0,true,false,tstart,tend,false)



			reaper.SetEditCurPos(tend + distance_to_first_item,false,false)

			reaper.Main_OnCommand(40914,0) --set first track as last touched

			reaper.Main_OnCommand(40718,0) -- select all items in track/time selection

			reaper.Main_OnCommand(41296,0) --duyplicate

			reaper.SetEditCurPos(cur_pos,false,false)
--[[
			if a == "cat" then
			reaper.Main_OnCommand(40070,0)
			end
]]--
			
	end
end
-------------------------------------

duplicate()

reaper.Main_OnCommand(40297,0)

reaper.Main_OnCommand( reaper.NamedCommandLookup( "_SWS_RESTORESEL"),  0)





reaper.Undo_EndBlock("Duplicate",0)

reaper.BR_SetArrangeView(0, startTime, endTime)


reaper.Main_OnCommand(42085,0)
reaper.PreventUIRefresh(-1)




































