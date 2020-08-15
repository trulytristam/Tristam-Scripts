

reaper.PreventUIRefresh(-1)
reaper.PreventUIRefresh( 0 )

reaper.Undo_BeginBlock2( 0 )


t = reaper.GetSelectedTrack(0,0)

if t then
c =  reaper.GetMediaTrackInfo_Value( t, "I_CUSTOMCOLOR" )

reaper.Main_OnCommand(40001,0)-- add tracks
t = reaper.GetSelectedTrack(0,0)
reaper.SetMediaTrackInfo_Value( t, "I_CUSTOMCOLOR",c )

end



reaper.Undo_EndBlock2( 0, "add track same color",0 )

reaper.PreventUIRefresh(1)
