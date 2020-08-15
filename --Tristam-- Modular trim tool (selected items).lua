


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
		

		distance_between_pos = second_pos - first_pos

		
		astart, aend = reaper.BR_GetArrangeView(0)
		arrangement_dist = aend - astart
		perc_arrang_dist = arrangement_dist * (1/100)

		item_num = reaper.CountSelectedMediaItems(0)

w = 0

		for i = 0, item_num - 1 do 

			item_cycle = reaper.GetSelectedMediaItem(0,w)
			position = 	reaper.GetMediaItemInfo_Value(item_cycle,"D_POSITION")
			length = reaper.GetMediaItemInfo_Value(item_cycle,"D_LENGTH")
			itemend = position + length
			track = reaper.GetMediaItemTrack(item_cycle)


					if first_pos > position and	first_pos < itemend then



						if first_pos < second_pos then


								if distance_between_pos <= perc_arrang_dist then

								new_item = reaper.SplitMediaItem(item_cycle,first_pos)
								reaper.DeleteTrackMediaItem(track,new_item)

								elseif distance_between_pos > perc_arrang_dist then

									new_item = reaper.SplitMediaItem(item_cycle,first_pos)

									reaper.SetMediaItemInfo_Value(item_cycle,"D_FADEOUTLEN",0.04)

									third_item = reaper.SplitMediaItem(new_item,second_pos)
									reaper.SetMediaItemInfo_Value(third_item,"D_FADEINLEN",0.04)
									reaper.DeleteTrackMediaItem(track,new_item)



									w = w + 1
								end
						elseif first_pos > second_pos then

						distance_between_pos = first_pos - second_pos

								if distance_between_pos <= perc_arrang_dist then

								new_item = reaper.SplitMediaItem(item_cycle,first_pos)
								reaper.DeleteTrackMediaItem(track,item_cycle)

								elseif distance_between_pos > perc_arrang_dist then

									new_item = reaper.SplitMediaItem(item_cycle,first_pos)
									third_item = reaper.SplitMediaItem(item_cycle,second_pos)
									reaper.SetMediaItemInfo_Value(third_item,"D_FADEINLEN",0.04)
									reaper.SetMediaItemInfo_Value(third_item,"D_FADEOUTLEN",0.04)
									reaper.DeleteTrackMediaItem(track,item_cycle)
									reaper.DeleteTrackMediaItem(track,new_item)

								end
						end
					
					end
				w = w + 1
			end
		
end


reaper.UpdateArrange()




		
	

	























		--distance_between_pos = 
		 





		-----trim left

