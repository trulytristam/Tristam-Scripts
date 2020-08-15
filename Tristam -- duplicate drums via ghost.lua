starttime, endtime = reaper.GetSet_LoopTimeRange2(0,0,0,0,0,0)
curpos = reaper.GetCursorPosition()

if reaper.CountSelectedMediaItems(0) ~= 0 then


fg = reaper.GetSelectedMediaItem(0,0)
fgp = reaper.GetMediaItemInfo_Value(fg,"D_POSITION")




reaper.PreventUIRefresh(-1)

reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40034,0) -- select all grouped items

-----
--FIND EARLIEST ITEM (earliest)
earliest = 1000

n = reaper.CountSelectedMediaItems(0)

x = 0

while x< n do
    it =  reaper.GetSelectedMediaItem( 0, x )
    itpos = reaper.GetMediaItemInfo_Value(it, "D_POSITION")

    if itpos < earliest then
      earliest = itpos
    end

    x = x+1

end

diff = 0

if earliest - starttime < 0 and earliest ~= 1000 then
    
    diff = earliest - fgp
end
-------
---------



reaper.Main_OnCommand(40698,0) -- copy items
reaper.Main_OnCommand(40297,0) -- Unselect all tracks items





firstitem = reaper.GetSelectedMediaItem(0,0)
firstitem_pos = reaper.GetMediaItemInfo_Value(firstitem, "D_POSITION")
offset = firstitem_pos - starttime

tr = reaper.GetMediaItemTrack(firstitem)
reaper.SetMediaTrackInfo_Value(tr, "I_SELECTED", 1)
reaper.Main_OnCommand(40505,0) -- set last touched

reaper.Main_OnCommand(40289,0) -- unselect all items



reaper.GetSet_LoopTimeRange2(0,1,0,endtime, endtime+(endtime-starttime),0)




reaper.Main_OnCommand(40718,0) -- select in time selection

reaper.Main_OnCommand(40034,0) -- select all grouped items
reaper.Main_OnCommand(40697,0) -- delete items


reaper.SetEditCurPos(endtime+ offset+diff,0,0)
reaper.Main_OnCommand(42398,0) -- paste items

reaper.SetEditCurPos(curpos,0,0)
reaper.Undo_EndBlock("Duplicate Ghost Groups",0)

reaper.PreventUIRefresh(1)


end

