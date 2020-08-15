




doesit = reaper.HasExtState("click","firstclickpos")


if doesit == true then

--allow to reset if run over not item
	original_item = reaper.GetExtState("click","item")



		reaper.BR_GetMouseCursorContext()
	isitem = reaper.BR_GetMouseCursorContext_Item()



	


			if isitem == nil then
				

			reaper.DeleteExtState("click","firstclickpos",false)
			reaper.DeleteExtState("click","item",false)

			end

---------
	mouse_pos = reaper.GetExtState("click","firstclickpos")

	reaper.BR_GetMouseCursorContext()
	mouse_pos_2 = reaper.BR_GetMouseCursorContext_Position()
	item_under_mouse = reaper.BR_GetMouseCursorContext_Item()


			
					if tostring(isitem) == original_item then


									if isitem ~= nil then


											if tonumber(mouse_pos) > tonumber(mouse_pos_2) then
												mouse1 = mouse_pos_2
												mouse2 = mouse_pos

											else
												mouse1 = mouse_pos
												mouse2 = mouse_pos_2
											end

												---splits item
											item2 = reaper.SplitMediaItem(item_under_mouse,mouse1)
											reaper.SplitMediaItem(item2,mouse2)
											item2_volume = reaper.GetMediaItemInfo_Value(item2,"D_VOL")
											reaper.SetMediaItemInfo_Value(item2,"D_VOL",item2_volume/3)

									end
							else

								reaper.BR_GetMouseCursorContext()
								itemfirst = reaper.BR_GetMouseCursorContext_Item()
								mouse_pos = reaper.BR_GetMouseCursorContext_Position()



								reaper.SetExtState("click","firstclickpos",mouse_pos,false)
								reaper.SetExtState("click","item",tostring(itemfirst),false)


					end



				reaper.DeleteExtState("click","firstclickpos",false)
		else


		reaper.BR_GetMouseCursorContext()
		itemfirst = reaper.BR_GetMouseCursorContext_Item()
		mouse_pos = reaper.BR_GetMouseCursorContext_Position()

		if itemfirst ~= nil then

			reaper.SetExtState("click","firstclickpos",mouse_pos,false)
			reaper.SetExtState("click","item",tostring(itemfirst),false)
			else

			reaper.DeleteExtState("click","firstclickpos",false)
			reaper.DeleteExtState("click","item",false)

		end





end

reaper.UpdateArrange() 



