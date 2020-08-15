function main()

reaper.Undo_BeginBlock()


  track = reaper.GetSelectedTrack(0,0)

  if track == nil then

  else

   fxcount = reaper.TrackFX_GetCount(track)

  commandID = reaper.NamedCommandLookup("_S&M_PASTE_TRACKFXCHAIN1")

   reaper.Main_OnCommand(commandID,0)

 
  
  end

end

reaper.Undo_EndBlock("addfxslot1",0)


reaper.PreventUIRefresh(1)

main()

reaper.PreventUIRefresh(-1)
    

track = reaper.GetSelectedTrack(0,0)
nt = reaper.CountSelectedTracks(0)




if nt == 1 then

    nfx =  reaper.TrackFX_GetCount( track )
    
    
    if nfx > 0 then
    
    
        reaper.GetFXEnvelope( track, nfx-1, 2, 1 )
        reaper.GetFXEnvelope( track, nfx-1, 15, 1 )
        
        reaper.Main_OnCommand(40888,0)
        
    end
    
    
    

end

