
 function main()



	_,_,_ = reaper.BR_GetMouseCursorContext()
	item = reaper.BR_GetMouseCursorContext_Item()

if item ~= nil then

	item_len = reaper.GetMediaItemInfo_Value(item,"D_LENGTH")
	item_fadeout = reaper.GetMediaItemInfo_Value(item,"D_FADEOUTLEN")
	item_fadein = reaper.GetMediaItemInfo_Value(item,"D_FADEINLEN")
	item_volume = reaper.GetMediaItemInfo_Value(item,"D_VOL")

			local i = 0

				while i < reaper.CountSelectedMediaItems(0) do		
				items = reaper.GetSelectedMediaItem(0,i)		
				reaper.SetMediaItemInfo_Value(items,"D_LENGTH", item_len)
				reaper.SetMediaItemInfo_Value(items,"D_FADEOUTLEN", item_fadeout)
				reaper.SetMediaItemInfo_Value(items,"D_FADEINLEN", item_fadein)
				reaper.SetMediaItemInfo_Value(items,"D_VOL", item_volume)

				i = i + 1
			end

end

end


reaper.PreventUIRefresh(1)

main()
reaper.PreventUIRefresh(-1)



reaper.UpdateArrange()















		
		
