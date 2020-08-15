

if reaper.HasExtState("undotest","last") then

    reaper.BR_GetMouseCursorContext()
    
    pos = reaper.BR_GetMouseCursorContext_Position()
    
    
    reaper.ShowConsoleMsg(pos.."\n")
    
    if pos<0 then
        
        reaper.Undo_EndBlock2("testundo",0,0)
        
        reaper.Undo_DoUndo2(0)
        
    end
    
    
    reaper.DeleteExtState("undotest","last",0)
    
        

else

    reaper.SetExtState("undotest","last","0", 0)
    reaper.Undo_BeginBlock2( 0 )
    
    
end
