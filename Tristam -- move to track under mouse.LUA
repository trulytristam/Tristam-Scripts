

n_items = reaper.CountSelectedMediaItems(0)
reaper.BR_GetMouseCursorContext()

track = reaper.BR_GetMouseCursorContext_Track()


if n_items>0 then


    item = reaper.GetSelectedMediaItem(0,0)
    reaper.MoveMediaItemToTrack( item, track )
    
    
    reaper.SetMediaItemInfo_Value(item, "B_UISEL", 0)
    reaper.UpdateArrange()
end

