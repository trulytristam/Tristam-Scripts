 
 
 
 n_items =  reaper.CountSelectedMediaItems( 0 )
 starttime, endtime = reaper.GetSet_LoopTimeRange2( 0, 0, 0, 0, 0, 0 )
 
 
 
for i = 0, n_items-1 do

current_item = reaper.GetSelectedMediaItem(0, i )

right =  reaper.SplitMediaItem( current_item, endtime )
reaper.SetMediaItemSelected( current_item, 0 )



end


reaper.GetSet_LoopTimeRange2( 0, 1, 0, endtime, endtime+(endtime-starttime), 0 )



reaper.UpdateArrange()






