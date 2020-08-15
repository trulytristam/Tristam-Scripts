_,_,_ = reaper.BR_GetMouseCursorContext()
mouse_position = reaper.BR_GetMouseCursorContext_Position()



--[[doesit     = reaper.HasExtState( "times", "starttime" )

if doesit ~= true then

	--original_zoom_level = reaper.GetHZoomLevel()
	startTime, endTime = reaper.BR_GetArrangeView(0)



	reaper.SetExtState( "times", "starttime", startTime, false )
	reaper.SetExtState( "times", "endtime", endTime, false )
end--]]

if mouse_position >= 0 then

		doesit = reaper.HasExtState("times", "starttime")


			if doesit == true then 
				reset_starttime = reaper.GetExtState( "times", "starttime")
				reset_endtime = reaper.GetExtState( "times", "endtime")

				reaper.BR_SetArrangeView(0, reset_starttime, reset_endtime)

				reaper.DeleteExtState("times", "starttime", true)
				reaper.DeleteExtState("times", "endtime", true)

			end

end