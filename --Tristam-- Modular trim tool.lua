


if reaper.HasExtState("mousepos","first") == false then

reaper.BR_GetMouseCursorContext()
first_mouse_pos = reaper.BR_GetMouseCursorContext_Position()
reaper.SetExtState("mousepos","first",first_mouse_pos,false)



elseif reaper.HasExtState("mousepos","first") == true then


		first_pos = reaper.GetExtState("mousepos","first")
		first_pos = tonumber( first_pos)
		reaper.DeleteExtState("mousepos","first",true)
		reaper.BR_GetMouseCursorContext()
		second_pos = reaper.BR_GetMouseCursorContext_Position()
		origin_item = reaper.BR_GetMouseCursorContext_Item()
		track = reaper.BR_GetMouseCursorContext_Track()

		distance_between_pos = second_pos - first_pos

		
		astart, aend = reaper.BR_GetArrangeView(0)
		arrangement_dist = aend - astart
		perc_arrang_dist = arrangement_dist * (1/100)



		if first_pos < second_pos then


				if distance_between_pos <= perc_arrang_dist then

				new_item = reaper.SplitMediaItem(origin_item,first_pos)
				reaper.DeleteTrackMediaItem(track,new_item)

				elseif distance_between_pos > perc_arrang_dist then

					new_item = reaper.SplitMediaItem(origin_item,first_pos)
					third_item = reaper.SplitMediaItem(new_item,second_pos)
					reaper.DeleteTrackMediaItem(track,new_item)
				end
		elseif first_pos > second_pos then

		distance_between_pos = first_pos - second_pos

				if distance_between_pos <= perc_arrang_dist then

				new_item = reaper.SplitMediaItem(origin_item,first_pos)
				reaper.DeleteTrackMediaItem(track,origin_item)

				elseif distance_between_pos > perc_arrang_dist then

					new_item = reaper.SplitMediaItem(origin_item,first_pos)
					third_item = reaper.SplitMediaItem(origin_item,second_pos)
					reaper.DeleteTrackMediaItem(track,origin_item)
					reaper.DeleteTrackMediaItem(track,new_item)
				end
		end


reaper.UpdateArrange()




		
	

	













end










		--distance_between_pos = 
		 





		-----trim left

