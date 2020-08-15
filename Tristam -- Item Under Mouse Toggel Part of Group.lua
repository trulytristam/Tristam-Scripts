reaper.BR_GetMouseCursorContext()
it = reaper.BR_GetMouseCursorContext_Item()


if it then
      
    reaper.SetMediaItemInfo_Value(it, "B_UISEL", 1)
    
    is_g = reaper.GetMediaItemInfo_Value(it, "I_GROUPID")


    if is_g == 0 then
        reaper.Main_OnCommand(40034, 0) -- Select all In group
        reaper.Main_OnCommand(40032,0) -- Group items
    
    else
    
        reaper.Main_OnCommand(40289,0) --Unselect all items
        reaper.SetMediaItemInfo_Value(it, "B_UISEL", 1)
        reaper.Main_OnCommand(40033,0) --Remove From Group
        
    
    end

else
    
   nit = reaper.CountSelectedMediaItems(0)
   
   if nit > 0 then
        reaper.Main_OnCommand(40032,0) -- Group items
   end
   
   
end

reaper.UpdateArrange()

