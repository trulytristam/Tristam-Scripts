

if reaper.HasExtState( "test", "action" ) then

    first = reaper.GetExtState("test","action")
    
    reaper.BR_GetMouseCursorContext()
    second = reaper.BR_GetMouseCursorContext_Position()
  
    track = reaper.BR_GetMouseCursorContext_Track()
    
    if track then
        reaper.CreateNewMIDIItemInProj( track, first, second, 0)
        
    end
    
    reaper.DeleteExtState("test","action",0)

else


  reaper.BR_GetMouseCursorContext()
  time = reaper.BR_GetMouseCursorContext_Position()

  reaper.SetExtState( "test" , "action", time, 0 )
  

end











    
    
    
    
    




