reaper.Undo_BeginBlock()

reaper.PreventUIRefresh(1)

reaper.Main_OnCommand(40297,0) --unselect tracks

origitem = reaper.GetSelectedMediaItem(0,0)
origtrack = reaper.GetMediaItem_Track(origitem)
reaper.SetMediaTrackInfo_Value(origtrack,"I_SELECTED",1)

itemnum = reaper.CountSelectedMediaItems(0)


 i=0

repeat

itemtomove = reaper.GetSelectedMediaItem(0,0)

reaper.Main_OnCommand(40001,0)  --insert new track

reaper.Main_OnCommand(40914,0) --set selected as last touched

outputdesttrack = reaper.GetSelectedTrack(0,0)

reaper.MoveMediaItemToTrack(itemtomove,outputdesttrack)

reaper.SetMediaItemSelected(itemtomove,false)

i = i + 1


until i==itemnum



	 i=0

repeat

reaper.Main_OnCommand(40288,0)

i = i + 1


until i==itemnum -1

--reaper.Main_OnCommand(40297,0) --unselect tracks
--reaper.SetMediaTrackInfo_Value(origtrack,"I_SELECTED",1)
	

	reaper.PreventUIRefresh(-1)

reaper.Undo_EndBlock("Move Items to tracks",0)

reaper.UpdateArrange()




