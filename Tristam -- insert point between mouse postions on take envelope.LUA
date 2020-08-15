
AMOUNT = 350


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


			item = reaper.GetSelectedMediaItem(0,i)
			pos = reaper.GetMediaItemInfo_Value(item,"D_POSITION")

			take = reaper.GetTake(item,0)


			take_volume = reaper.GetTakeEnvelope( take, 0 )
			val = 0
			
			
			
			n_points = reaper.CountEnvelopePoints(take_volume)
			prev = 0
			
			for j = 0, n_points -1 do
				
				retval, time, value, shape, tension, selected = reaper.GetEnvelopePoint( take_volume, j )
				if time >= first_pos or j == n_points then
								    
					break
				end
				
				val = value
			    
			end
			
	

			reaper.InsertEnvelopePoint(take_volume,first_pos-pos,val,0,0,0,0)
			reaper.InsertEnvelopePoint(take_volume,(first_pos-pos)+(distance_between_pos*0.10),val - AMOUNT,0,0,0,0)
			reaper.InsertEnvelopePoint(take_volume,(second_pos-pos)-(distance_between_pos*0.10),val - AMOUNT,0,0,0,0)
			reaper.InsertEnvelopePoint(take_volume,second_pos-pos,val,0,0,0,0)

		end
end
