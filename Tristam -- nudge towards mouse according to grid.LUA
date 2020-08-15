reaper.BR_GetMouseCursorContext()
mouse_pos = reaper.BR_GetMouseCursorContext_Position()

--reaper.ShowConsoleMsg(mouse_pos.."\n")
		
track = reaper.BR_GetMouseCursorContext_Track()


retval, divisionIn, swingmodeIn, swingamtIn = reaper.GetSetProjectGrid( project, set )


item = reaper.GetSelectedMediaItem(0,0)


i = 0






while item ~= nil do

	
	item = reaper.GetSelectedMediaItem(0,i)

	item_pos = reaper.GetMediaItemInfo_Value(item,	"D_POSITION")





	i= i +1
end



