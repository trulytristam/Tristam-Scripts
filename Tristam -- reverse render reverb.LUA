
length_of_tail = 4



reaper.PreventUIRefresh( -1 )

reaper.Undo_BeginBlock2( 0 )


n_sel_items =  reaper.CountSelectedMediaItems( 0 )

if n_sel_items == 1 then

reaper.Main_OnCommand(40297,0) -- unselect all tracks
original_item = reaper.GetSelectedMediaItem( 0, 0 )

track = reaper.GetMediaItem_Track( original_item )
reaper.SetTrackSelected( track, 1 )

reaper.Main_OnCommand(40061,0) -- SPLIT at time selection
n_items = reaper.CountTrackMediaItems(track)

itemtorender = reaper.GetSelectedMediaItem(0,0)

mute_states = {}



for i = 0, n_items-1  do

  item = reaper.GetTrackMediaItem( track, i)
  mute_states[i] = reaper.GetMediaItemInfo_Value( item, "B_MUTE" )
  
  if item ~= itemtorender then
    reaper.SetMediaItemInfo_Value( item, "B_MUTE", 1 )
  end

end

start, endd = reaper.GetSet_LoopTimeRange2( 0, 0, 0, 0, 0, 0 )


reaper.GetSet_LoopTimeRange2( 0, 1, 0, start, start+length_of_tail, 0 )




reaper.Main_OnCommand(41716,0) -- RENDER COMMAND

--MODIFY NEW RENDERED ITEM
----------------------
newtrack = reaper.GetSelectedTrack( 0, 0 )
newitem = reaper.GetTrackMediaItem( newtrack, 0)

reaper.Main_OnCommand(40289,0) -- unselect all items

reaper.SetMediaItemInfo_Value( newitem,"B_UISEL",1)



reaper.Main_OnCommand(41051,0) -- reverse item

newitem_length = reaper.GetMediaItemInfo_Value( newitem, "D_LENGTH" )
newitem_pos = reaper.GetMediaItemInfo_Value( newitem, "D_POSITION" )
reaper.SetMediaItemInfo_Value( newitem, "D_POSITION", newitem_pos - newitem_length+0.01+ (endd-start) )
reaper.SetMediaItemInfo_Value( newitem,"D_LENGTH",newitem_length-(endd-start))


reaper.SetMediaItemInfo_Value( newitem,"D_FADEOUTLEN",0.02)

---------------------------
------------------


reaper.SetMediaTrackInfo_Value( track, "B_MUTE", 0 )

for i = 0, n_items-1 do
  item = reaper.GetTrackMediaItem( track,i)
  reaper.SetMediaItemInfo_Value( item, "B_MUTE", mute_states[i])

end


--REPAIR ORIGINAL ITEM


itemtorender_start = reaper.GetMediaItemInfo_Value(itemtorender, "D_POSITION")
itemtorender_len = reaper.GetMediaItemInfo_Value(itemtorender, "D_LENGTH")
itemtorender_end = itemtorender_start+itemtorender_len

reaper.Main_OnCommand(40289,0) -- unselect all items
reaper.SetMediaItemInfo_Value( itemtorender,"B_UISEL", 1)
for i = 0, n_items-1 do

  item = reaper.GetTrackMediaItem( track,i)
  
  item_start = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
  item_len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
  item_end = item_start+item_len
  
  
  if item_start == itemtorender_end or item_end == itemtorender_start then
    reaper.SetMediaItemInfo_Value( item,"B_UISEL", 1)
    
  end
end



reaper.GetSet_LoopTimeRange2( 0, 1, 0, itemtorender_start,itemtorender_end, 0 )




reaper.Main_OnCommand(41588,0) -- glue selected items

-----------
--nfx =  reaper.TrackFX_GetCount( track )
--reaper.TrackFX_Delete( track, nfx-1 )
end


reaper.Undo_EndBlock2( 0, "Render and reverse", 0 )


reaper.PreventUIRefresh( 1 )
