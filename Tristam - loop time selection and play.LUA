reaper.Main_OnCommand(reaper.NamedCommandLookup('_SWS_SETREPEAT'),0)

timestart, timeend = reaper.GetSet_LoopTimeRange2(0	,0,0,0,0,0)


reaper.GetSet_LoopTimeRange2(0,1,1,timestart,timeend,0)


reaper.SetEditCurPos2(0,timestart,0,1)


--reaper.Main_OnCommand(40044,0)
reaper.Main_OnCommand(1007,0)

