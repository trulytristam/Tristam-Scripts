reaper.BR_GetMouseCursorContext()

trackunder = reaper.BR_GetMouseCursorContext_Track()


issel = reaper.GetMediaTrackInfo_Value(trackunder,"I_SELECTED")



if issel == 0 then

reaper.SetMediaTrackInfo_Value(trackunder,"I_SELECTED",1)

else

	reaper.SetMediaTrackInfo_Value(trackunder,"I_SELECTED",0)

end