


function m(a)
	reaper.ShowConsoleMsg(a)
end


function main()


		_,_,_ = reaper.BR_GetMouseCursorContext()
		item = reaper.BR_GetMouseCursorContext_Item()


		item_len = reaper.GetMediaItemInfo_Value(item,"D_LENGTH")
		item_fadeinlen = reaper.GetMediaItemInfo_Value(item, "D_FADEINLEN")

		fadein_ratio = item_fadeinlen / item_len  



		mouse_position = reaper.BR_GetMouseCursorContext_Position()

		item_right = reaper.SplitMediaItem(item,mouse_position)


		track = reaper.BR_GetMouseCursorContext_Track()


		new_item_len = reaper.GetMediaItemInfo_Value(item_right ,"D_LENGTH")
		reaper.SetMediaItemInfo_Value(item_right,"D_FADEINLEN",(new_item_len * fadein_ratio))

		reaper.DeleteTrackMediaItem(track, item )

end



main()



reaper.UpdateArrange()