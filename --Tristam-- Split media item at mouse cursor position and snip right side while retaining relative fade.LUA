----Made by: Tristam


function m(a)
	reaper.ShowConsoleMsg(a)
end

function main()


		_,_,_ = reaper.BR_GetMouseCursorContext()
		item = reaper.BR_GetMouseCursorContext_Item()


		item_len = reaper.GetMediaItemInfo_Value(item,"D_LENGTH")
		item_fadeoutlen = reaper.GetMediaItemInfo_Value(item, "D_FADEOUTLEN")

		fadeout_ratio = item_fadeoutlen / item_len  

		mouse_position = reaper.BR_GetMouseCursorContext_Position()

		item_right = reaper.SplitMediaItem(item,mouse_position)


		track = reaper.BR_GetMouseCursorContext_Track()


		new_item_len = reaper.GetMediaItemInfo_Value(item,"D_LENGTH")
		reaper.SetMediaItemInfo_Value(item,"D_FADEOUTLEN",(new_item_len * fadeout_ratio))

		reaper.DeleteTrackMediaItem(track, item_right )

end


main()

reaper.UpdateArrange()