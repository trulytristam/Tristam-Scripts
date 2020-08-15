


--mouse position value
-----------------
reaper.BR_GetMouseCursorContext()
mouse_pos = reaper.BR_GetMouseCursorContext_Position()

--Time selection values
-----------------
tstart, tend = reaper.GetSet_LoopTimeRange2(0,false,false,0,0,false)
time_length = tend - tstart
time_center = (time_length / 2) + tstart

--Item
-----------------
item_before = reaper.GetSelectedMediaItem(0,0)

--Item Info
-------------------
item_before_pos = reaper.GetMediaItemInfo_Value(item_before,"D_POSITION")
item_before_len = reaper.GetMediaItemInfo_Value(item_before,"D_LENGTH")
item_before_end	= item_before_pos + item_before_len

--Distances
----------------------
item_start_to_tstart = tstart - item_before_pos
item_end_to_tend = item_before_end - tend  


function main()

		reaper.Undo_BeginBlock()


					if mouse_pos <= time_center then

						if  item_end_to_tend > time_length then


						local item_after = reaper.SplitMediaItem(item_before,tend)
						reaper.SetMediaItemInfo_Value(item_after,"D_POSITION",tstart)
						reaper.SetMediaItemInfo_Value(item_after,"D_FADEINLEN", (time_length))
						reaper.SetMediaItemInfo_Value(item_before,"D_FADEOUTLEN", (time_length))

						else 

							reaper.ShowConsoleMsg("Time Selection to great.".."\n")

						end
					    
					
					end

					if mouse_pos > time_center then

						if  item_start_to_tstart > time_length then

						local item_after = reaper.SplitMediaItem(item_before,tstart)
						item_before_length_after = reaper.GetMediaItemInfo_Value(item_before,"D_LENGTH")			
						reaper.SetMediaItemInfo_Value(item_before,"D_POSITION",(tend - item_before_length_after))
						reaper.SetMediaItemInfo_Value(item_after,"D_FADEINLEN", (time_length))
						reaper.SetMediaItemInfo_Value(item_before,"D_FADEOUTLEN", (time_length))

						else

							reaper.ShowConsoleMsg("Time Selection to great.".."\n")

						end
						
					end

					reaper.Main_OnCommand(41588,0)


		reaper.Undo_EndBlock(" ",0)

end



reaper.PreventUIRefresh(-1)
main()
reaper.PreventUIRefresh(1)

reaper.UpdateArrange()





















--reaper.ShowConsoleMsg("You are my favorite son!".."\n")