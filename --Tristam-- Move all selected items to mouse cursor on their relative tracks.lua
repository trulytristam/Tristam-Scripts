



--reaper.GetExtState("inv_marker",key)


reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()
w = 0


while reaper.HasExtState("inv_marker",tostring(w)) == true
 and reaper.HasExtState("which_item",tostring(w)) == true do

w = w + 1

end

if w > 20 then
	reaper.ShowConsoleMsg("script fucked")
end


reaper.BR_GetMouseCursorContext()
mouse_pos = reaper.BR_GetMouseCursorContext_Position()
mouse_pos_snap = reaper.SnapToGrid(0,mouse_pos)
item = reaper.BR_GetMouseCursorContext_Item()



if mouse_pos < 0 then
	for i = 0, w do
	reaper.DeleteExtState("inv_marker",tostring(i),false)
	reaper.DeleteExtState("which_item",tostring(i),false)
	end
end


isthereanythingstored = reaper.HasExtState("inv_marker","0")

 if isthereanythingstored == false then
 	reaper.Main_OnCommand(40289,0)
 end


--reaper.SetMediaItemSelected(item,true)
if item ~= nil then
reaper.SetMediaItemSelected(item,true)
reaper.UpdateArrange()
end
reaper.SetExtState("inv_marker",tostring(w),mouse_pos,false)
reaper.SetExtState("which_item",tostring(w),tostring(item),false)





if item == nil then


	for i = 0, w - 1 do

		where_to_split = reaper.GetExtState("inv_marker",tostring(i))
		which_item_to_split = reaper.GetExtState("which_item",tostring(i))


	--reaper.ShowConsoleMsg(tostring(which_item_to_split).."\n")

			----scan
			for j = 0, w - 1 do 


				
				selct_item =  reaper.GetSelectedMediaItem(0,j)

				if which_item_to_split == tostring(selct_item) then
					finalitemtocut = selct_item
				end
			end


		track = reaper.GetMediaItemTrack(finalitemtocut)
		tokeep = reaper.SplitMediaItem(finalitemtocut,where_to_split)
		reaper.DeleteTrackMediaItem(track,finalitemtocut)
		reaper.SetMediaItemInfo_Value(tokeep,"D_POSITION",mouse_pos_snap)


	end




	for i = 0, w do
	reaper.DeleteExtState("inv_marker",tostring(i),false)
	reaper.DeleteExtState("which_item",tostring(i),false)
	end
end

reaper.Undo_EndBlock("",0)
reaper.PreventUIRefresh(-1)













