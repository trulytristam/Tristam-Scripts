 reaper.PreventUIRefresh(1)

reaper.Main_OnCommand(40914,0) --set selected as last touched


stemtrack = reaper.GetSelectedTrack(0,0)


reaper.Main_OnCommand(40044,0) --stop
reaper.Main_OnCommand(40001,0)  --insert new track


item = reaper.GetSelectedMediaItem(0,0)

reaper.Main_OnCommand(40914,0) --set selected as last touched


outputtrack = reaper.GetSelectedTrack(0,0)




 reaper.MoveMediaItemToTrack(item,outputtrack)

reaper.Main_OnCommand(40297,0)

 reaper.SetTrackSelected(stemtrack,true)


 reaper.PreventUIRefresh(-1)

  reaper.UpdateArrange()

